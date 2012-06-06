/*
 * Cloud Foundry API module
 * AMQP client to rabbitmq service
 *
 * create([implOptions]) - creates and returns an amqp client instance
 * connected to a single rabbitmq service
 *
 * createFromSvc(name, [implOptions]) - creates and returns an amqp client
 * instance connected to a rabbitmq service with the specified name
 *
 * implOptions - non-connection related implementation options
 */

var sc = require("./service")
  , util = require("util");

function AMQPClient () {
  this.type = "rabbitmq";
}

util.inherits(AMQPClient, sc.ServiceClient);

AMQPClient.prototype._create = function (props) {
  var amqp = require("amqp");

  var config = { "login" : props.username
               , "password" : props.password
               , "host" : props.host
               , "port" : props.port
               , "vhost" : props.vhost
               };

  return amqp.createConnection(config, arguments[1]);
};

exports.create = function () {
  var client = new AMQPClient();
  return client.create.apply(client, arguments);
};

exports.createFromSvc = function (name) {
  var client = new AMQPClient();
  return client.createFromSvc.apply(client, arguments);
};
