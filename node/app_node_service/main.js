var sys = require("sys");
var http = require('http');
var url_lib = require('url');
var mongodb = require('./lib/node-mongodb-native/lib/mongodb');
var nerve = require( './lib/nerve/lib/nerve' ),
    get = nerve.get,
    post = nerve.post;

var msg_value="";

var port = process.env.VMC_APP_PORT || 8080;
var getBody = function(req, callback){
    var body = '';
    req.on('data', function(chunk){
      body += chunk;
      callback(body);
    });
}


var app = [
  [get(/^\/env$/), function(req, res, name) {
    var services =  eval('(' + process.env.VMC_SERVICES + ')');
    res.respond('env: '+ sys.inspect(services));
  }],
  [get(/^\/$/), function(req, res, name) {
    res.respond('hello from node');
  }],
  [get(/^\/crash$/), function(req, res, name) {
    process.kill(process.pid, 'SIGKILL');
  }],
  [get(/^\/service\/redis\/(\w+)$/), function(req, res, key) {
    var client = redis_services();
    client.stream.on( 'connect', function() {
       client.get( key, function(err, data) {
         res.respond( data.toString() );
         client.quit();
       });
    });
  }],
  [post(/^\/service\/redis\/(\w+)$/), function(req, res, key) {
    getBody(req, function(body){
      var client = redis_services();
      client.stream.on( 'connect', function() {
         client.set( key, body );
         client.quit();
      });
      res.end();
    });
  }],
  [get(/^\/service\/postgresql\/(\w+)$/), function(req, res, key) {
    client = postgres_services(res);
    client.query("select data_value from  data_values where id='" + key  + "'", function(err, results, fields){
      res.respond(results[0].data_value);
      client.close();
    });
  }],
  [post(/^\/service\/postgresql\/(\w+)$/), function(req, res, key) {
    getBody(req, function(body){
      client = postgres_services(res);
      client.query("insert into data_values (id, data_value) values('"+key+"','"+body+"');");
      client.close();
    });
    res.end();
  }],
  [get(/^\/service\/mysql\/(\w+)$/), function(req, res, key) {
    client = mysql_services();
    client.query('select data_value from  data_values where id = \''+ key+'\'', function(err, results, fields){
      res.respond(results[0]['data_value']);
      client.end();
    });
  }],
  [post(/^\/service\/mysql\/(\w+)$/), function(req, res, key) {
    getBody(req, function(body){
      client = mysql_services();
      client.query('insert into data_values (id, data_value) values(\''+key+'\',\''+body+'\');');
      client.end();
    });
    res.end();
  }],
  [get(/^\/service\/mongo\/(\w+)$/), function(req, res, key) {
    var mongo_service = load_service('mongodb');
    var db = new mongodb.Db(mongo_service["db"], new mongodb.Server(mongo_service["hostname"], mongo_service["port"], {}), {});
    db.open(function (error, client) {
      db.authenticate(mongo_service["username"], mongo_service["password"], function(err, replies) {
        var collection = new mongodb.Collection(client, 'test_collection');
        collection.find({'key': key}, function(err, cursor) {
          cursor.toArray(function(err, items) {
            res.respond(items[0].data_value);
            db.close();
          });
        });
      });
    });
  }],
  [post(/^\/service\/mongo\/(\w+)$/), function(req, res, key) {
    getBody(req, function(body){
      var mongo_service = load_service('mongodb');
      var db = new mongodb.Db(mongo_service["db"], new mongodb.Server(mongo_service["hostname"], mongo_service["port"], {}), {});
      db.open(function (error, client) {
        db.authenticate(mongo_service["username"], mongo_service["password"], function(err, replies) {
          db.createCollection('test_collection', function(err, collection) {
            collection.insert({ 'key' : key, 'data_value': body});
            db.close();
          });
        });
      });
      res.end();
    });
  }],
  [get(/^\/service\/rabbit\/(\w+)$/), function(req, res, key) {
    res.end(msg_value);
  }],
  [post(/^\/service\/rabbit\/(\w+)$/), function(req, res, key) {
    getBody(req, function(body){
      rabbit(key,body);
      res.end();
    });
  }],
  [get(/^\/service\/rabbitmq\/(\w+)$/), function(req, res, key) {
    res.end(msg_value);
  }],
  [post(/^\/service\/rabbitmq\/(\w+)$/), function(req, res, key) {
    getBody(req, function(body){
      rabbitsrs(key,body);
      res.end();
    });
  }],
];

nerve.create(app, {session_duration: 10000}).listen(port);

function redis_services(){
  var redis_service = load_service('redis');
  var redis = require("./lib/node_redis");
  var client = redis.createClient(redis_service['port'], redis_service['hostname']);
  client.auth(redis_service['password']);
  return client;
}

function postgres_services(res){
  var postgres_service = load_service('postgresql');
  var sys = require("sys");
  var pg = require('./lib/postgres-js/lib/postgres-pure');
  var client = new pg.connect("pgsql://"+postgres_service['user']+":"+postgres_service['password']+"@"+postgres_service['hostname']+":"+postgres_service['port']+"/"+postgres_service['name']);

  client.query("CREATE OR REPLACE FUNCTION create_data_values_if_doesnot_exists() RETURNS void AS $$\n BEGIN\n IF NOT EXISTS(SELECT table_name FROM information_schema.tables where table_name = 'data_values') THEN\n CREATE TABLE data_values (id varchar(20), data_value varchar(20));\n END IF;\n RETURN;\n END;\n $$ LANGUAGE plpgsql; ", function(err, results, fields){ });
  client.query("select create_data_values_if_doesnot_exists(); ", function(err, results, fields){ });
  return client;
}
function mysql_services(){
  var mysql_service = load_service('mysql');
  var Client = require("./lib/node-mysql").Client,
      client = new Client();
  client.host = mysql_service['hostname'];
  client.port = mysql_service['port'];
  client.user = mysql_service['user'];
  client.password = mysql_service['password'];
  client.connect();
  client.query('USE '+mysql_service['name']);
  client.query('Create table IF NOT EXISTS data_values (id varchar(20), data_value varchar(20));');
  return client;
}

function load_service(service_name){
  var services =  eval('(' + process.env.VMC_SERVICES + ')');
  var service = null;
  services.forEach(function(s){
    if(s.vendor.toLowerCase() === service_name.toLowerCase()){
      service = s.options;
    }
  });
  return service;
}

function rabbitsrs(key, value, res){
  var service = load_service('rabbitmq');
  var amqp = require('./lib/node-amqp');
  url = require('url').parse(service['url']);
  var hostname = url['hostname'];
  var auth = url['auth'].split(':');
  var user = auth[0];
  var pass = auth[1];
  var connection = amqp.createConnection({ host: url['hostname'],  port: url['port'], login: user, password: pass, vhost:  url.pathname.substr(1) });
  connection.on('ready', function () {
    var q = connection.queue('node-default-exchange', function() {
      q.bind("#");
      q.on('queueBindOk', function() { // wait until queue is bound
        q.on('basicConsumeOk', function () { // wait until consumer is registered
          connection.publish(key, {'data_value' : value});
          setTimeout(function () {
            connection.end();
          }, 1000);
        });
        q.subscribe({ routingKeyInPayload: true }, function (msg) { // register consumer
          msg_value = msg.data_value;
          console.log(msg.data_value);
        });
      });
    });
  });
}
function rabbit(key, value, res){
  var service = load_service('rabbitmq');
  var amqp = require('./lib/node-amqp');
  var connection = amqp.createConnection({ host: service['hostname'],  port: service['port'], login: service['user'], password: service['pass'], vhost: service['vhost']});
  connection.on('ready', function () {
    var q = connection.queue('node-default-exchange', function() {
      q.bind("#");
      q.on('queueBindOk', function() { // wait until queue is bound
        q.on('basicConsumeOk', function () { // wait until consumer is registered
          connection.publish(key, {'data_value' : value});
          setTimeout(function () {
            connection.end();
          }, 1000);
        });
        q.subscribe({ routingKeyInPayload: true }, function (msg) { // register consumer
          msg_value = msg.data_value;
          console.log(msg.data_value);
        });
      });
    });
  });
}