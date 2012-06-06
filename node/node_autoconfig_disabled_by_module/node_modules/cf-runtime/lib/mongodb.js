/*
 * Cloud Foundry API module
 * MongoDB client
 *
 * create([options], callback) - creates a mongodb client instance
 * connected to a single mongodb service and executes provided callback
 *
 * createFromSvc(name, [options], callback) - creates a mongodb client
 * instance connected to a mongodb service with the specified name
 * and executes provided callback
 */

var sc = require("./service")
  , util = require("util");

function MongoClient () {
  this.type = "mongodb";
}

util.inherits(MongoClient, sc.ServiceClient);

MongoClient.prototype._create = function (props) {
  var mongodb = require("mongodb").Db;

  if (arguments.length > 2) {
    return mongodb.connect(props.url, arguments[1], arguments[2]);
  }
  else {
    return mongodb.connect(props.url, arguments[1]);
  }
};

exports.create = function () {
  var client = new MongoClient();
  return client.create.apply(client, arguments);
};

exports.createFromSvc = function (name) {
  var client = new MongoClient();
  return client.createFromSvc.apply(client, arguments);
};
