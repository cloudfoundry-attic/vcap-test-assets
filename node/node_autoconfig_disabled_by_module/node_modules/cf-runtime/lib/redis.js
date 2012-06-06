/*
 * Cloud Foundry API module
 * Redis client
 *
 * create([options]) - creates and returns a redis client instance
 * connected to a single redis service
 *
 * createFromSvc(name, [options]) - creates and returns a redis client
 * instance connected to a redis service with the specified name
 */

var sc = require("./service")
  , util = require("util");

function RedisClient () {
  this.type = "redis";
}

util.inherits(RedisClient, sc.ServiceClient);

RedisClient.prototype._create = function (props) {
  var redis = require("redis");
  var options = arguments[1] || {};
  var client = redis.createClient(props.port, props.host, options);
  if (props.password) client.auth_pass = props.password;

  return client;
};

exports.create = function () {
  var client = new RedisClient();
  return client.create.apply(client, arguments);
};

exports.createFromSvc = function (name) {
  var client = new RedisClient();
  return client.createFromSvc.apply(client, arguments);
};
