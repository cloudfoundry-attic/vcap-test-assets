/*
 * Cloud Foundry API module
 * MySQL client
 *
 * create([options]) - creates and returns a mysql client instance
 * connected to a single mysql service
 *
 * createFromSvc(name, [options]) - creates and returns a mysql client
 * instance connected to a mysql service with the specified name
 */

var sc = require("./service")
  , util = require("util");

function MysqlClient () {
  this.type = "mysql";
}

util.inherits(MysqlClient, sc.ServiceClient);

MysqlClient.prototype._create = function (props) {
  var mysql = require("mysql");

  var options = {};
  if (arguments[1] !== undefined) options = arguments[1];

  options.host = props.host;
  options.port = props.port;
  options.user = props.username;
  options.password = props.password;
  options.database = props.database;

  return mysql.createClient(options);
};

exports.create = function () {
  var client = new MysqlClient();
  return client.create.apply(client, arguments);
};

exports.createFromSvc = function (name) {
  var client = new MysqlClient();
  return client.createFromSvc.apply(client, arguments);
};
