/*
 * Cloud Foundry API module
 *
 * CloudApp - application data
 * MysqlClient - mysql service connection
 * PGClient - postgresql service connection
 * MongoDBClient - mongodb service connection
 * RedisClient - redis service connection
 * AMQPClient - rabbitmq service connection
 */

(function () {

  module.exports = exports;

  var CloudApp = exports.CloudApp = require("./properties");

  if (CloudApp.runningInCloud) {

    if (CloudApp.serviceNamesOfType.mongodb !== undefined) {
      exports.MongoClient = require("./mongodb");
    }

    if (CloudApp.serviceNamesOfType.redis !== undefined) {
      exports.RedisClient = require("./redis");
    }

    if (CloudApp.serviceNamesOfType.mysql !== undefined) {
      exports.MysqlClient = require("./mysql");
    }

    if (CloudApp.serviceNamesOfType.postgresql !== undefined) {
      exports.PGClient = require("./postgresql");
    }

    if (CloudApp.serviceNamesOfType.rabbitmq !== undefined) {
      exports.AMQPClient = require("./amqp");
    }
  }

})();
