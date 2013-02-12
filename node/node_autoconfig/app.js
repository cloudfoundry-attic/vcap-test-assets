require("cf-autoconfig");

var port = 3000;

var serviceConfig = {
  rabbitmq : {
    host : "localhost",
    port : 5555,
    login : 'guest',
    password : 'guest',
    vhost : '/'
  },
  redis : {
    host : "localhost",
    port : 5555,
    password : "guest"
  },
  mysql : {
    user : "guest",
    password : "guest",
    host : "localhost",
    port : 5555,
    database : "database"
  },
  mongodb : {
    url : "mongodb://guest:guest@localhost:5555/database"
  },
  postgresql : {
    url : "postgresql://guest:guest@localhost:5555/database"
  }
}

require("http").createServer(function (req, res) {
  var params = require("url").parse(req.url);
  var matches = params.pathname.match(/\/service\/([^\/]*)\/([^\/]*)/);
  if (matches) {
    var serviceName = matches[1];
    var serviceKey = matches[2];
    var body = "";

    if (req.method == "POST") {
      req.on("data", function (data) {
        body += data;
      });
    }

    req.on("end", function () {
      processServiceRequest(serviceName, serviceKey, req.method, body, function (err, data) {
        if (err) throw err;
        res.end(data);
      });
    });
  }
  else if (params.pathname === "/crash") {
    process.exit(0);
  }
  else {
    res.end("hello from node");
  }
}).listen(port);


function processServiceRequest (name, key, method, value, cb) {
  switch (name) {
  case "rabbitmq" :
    processRabbitmqRequest(key, method, value, cb);
    break;
  case "redis" :
    processRedisRequest(key, method, value, cb);
    break;
  case "mysql" :
    processMysqlRequest(key, method, value, cb);
    break;
  case "mongo" :
    processMongodbRequest(key, method, value, cb);
    break;
  case "postgresql" :
    processPgRequest(key, method, value, cb);
    break;
  }
}

function processRabbitmqRequest (key, method, value, cb) {
  var conn = require("amqp").createConnection(serviceConfig.rabbitmq);

  conn.on("error", function (err) {
    return cb(err);
  });

  conn.on("ready", function () {
    conn.queue(key, function (q) {
      switch (method) {
      case "GET" :
        q.subscribe(function (msg) {
          conn.end();
          return cb(null, msg.data);
        });
        break;
      case "POST" :
        q.bind("#");

        q.on('queueBindOk', function() {
          conn.publish(key, { "data" : value });
          setTimeout(function () {
            conn.end();
          }, 1000);
          return cb(null, "");
        });
        break;
      default :
        return cb(null, "");
      }
    });
  });
}

function processRedisRequest (key, method, value, cb) {
  var client = require("redis").createClient(serviceConfig.redis.port, serviceConfig.redis.host);

  client.on("error", function (err) {
    return cb(err);
  });

  client.auth(serviceConfig.redis.password, function () {
    switch (method) {
    case "POST" :
      client.set(key, value, function (err) {
        client.quit();
        if (err) return cb(err);
        return cb(null, "");
      });
      break;
    case "GET" :
      client.get(key, function (err, msg) {
        client.quit();
        if (err) return cb(err);
        return cb(null, msg.toString());
      });
      break;
    }
  });
}

function processMysqlRequest (key, method, value, cb) {
  var client = require("mysql").createClient(serviceConfig.mysql);
  client.on("error", function (err) {
    return cb(err);
  });

  switch (method) {
  case "POST" :
    client.query("create table if not exists test_table (id varchar(20), data_value varchar(20));", function (err) {
      if (err) return cb(err);
      client.query("insert into test_table values('"+key+"','"+value+"');", function (err) {
        if (err) return cb(err);
        client.end();
        return cb(null, "");
      });
    });
    break;
  case "GET" :
    client.query("select * from test_table where id='"+ key+"'", function(err, res) {
      if (err) return cb(err);
      return cb(null, res[0]["data_value"]);
    });
    break;
  }
}

function processMongodbRequest (key, method, value, cb) {
  require("mongodb").connect(serviceConfig.mongodb.url, function (err, db) {
    if (err) return cb(err);
    db.collection("test-collection", function (err, coll) {
      if (err) return cb(err);
      switch (method) {
      case "POST" :
        coll.insert({ "key" : key, "data" : value }, { safe : true }, function (err) {
          if (err) return cb(err);
          db.close();
          return cb(null, "");
        });
        break;
      case "GET" :
        coll.findOne({ "key" : key }, function (err, item) {
          if (err) return cb(err);
          db.close();
          return cb(null, item.data);
        });
        break;
      }
    });
  });
}

function processPgRequest (key, method, value, cb) {
  var pgClient = require("pg").Client;
  var client = new pgClient(serviceConfig.postgresql.url);
  client.connect(function(err, client) {
    if (err) return cb(err);
    switch (method) {
    case "POST" :
      client.query("drop table if exists test_table", function (err) {
        if (err) return cb(err);
        client.query("create table test_table (id varchar(20), data_value varchar(20));", function (err) {
          if (err) return cb(err);
          client.query("insert into test_table values('"+key+"','"+value+"');", function (err) {
            client.end();
            return cb(null, "");
          });
        });
      });
      break;
    case "GET" :
      var query = client.query("select * from test_table where id='"+key+"'", function (err) {
        if (err) return cb(err);
      });
      var result = null;
      query.on("row", function(row) {
        result = row.data_value;
      });
      query.on("end", function() {
        client.end();
        return cb(null, result);
      });
      break;
    }
  });
}
