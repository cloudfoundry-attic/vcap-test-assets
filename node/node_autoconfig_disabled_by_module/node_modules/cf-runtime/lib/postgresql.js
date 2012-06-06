/*
 * Cloud Foundry API module
 * PostgreSQL client
 *
 * create(callback) - creates a postgresql client instance
 * connected to a single postgresql service and executes provided callback
 *
 * createFromSvc(name, callback) - creates a postgresql client
 * instance connected to a postgresql service with the specified name
 * and executes provided callback
 */

var sc = require("./service")
  , util = require("util");

function PGClient () {
  this.type = "postgresql";
}

util.inherits(PGClient, sc.ServiceClient);

PGClient.prototype._create = function (props) {
  var pg = require("pg");

  var config = { "user" : props.username
               , "password" : props.password
               , "host" : props.host
               , "port" : props.port
               , "database" : props.database
               };

  return pg.connect(config, arguments[1]);
};

exports.create = function () {
  var client = new PGClient();
  return client.create.apply(client, arguments);
};

exports.createFromSvc = function (name) {
  var client = new PGClient();
  return client.createFromSvc.apply(client, arguments);
};
