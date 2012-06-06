/*
 * Cloud Foundry API module
 * Application data
 *
 * runningInCloud {boolean} - if this code is running on Cloud Foundry
 * host {string} - application host name
 * port {string} - port bound to application
 * serviceNames {array} - list of service names bound to application
 * serviceProps[serviceName] {object} - service connection properties by service name
 * serviceNamesOfType[serviceType] {object} - list of service names of specified type
 */

module.exports = CloudApp(process.env);

function CloudApp (env) {
  var self = {};

  self.runningInCloud = env.VCAP_APPLICATION ? true : false;

  self.host = env.VCAP_APP_HOST;

  self.port = env.VCAP_APP_PORT;

  self.serviceNames = [];

  self.serviceProps = {};

  self.serviceNamesOfType = {};

  if (self.runningInCloud) {
    var services = JSON.parse(env.VCAP_SERVICES);

    for (var service in services) {
      var list = services[service];

      var serviceParsedName = service.split("-");
      self.serviceNamesOfType[serviceParsedName[0]] = [];

      for (var i = 0; i < list.length; i++) {
        var s = {};

        s.name = list[i].name;
        s.label = serviceParsedName[0];
        s.version = serviceParsedName[1];
        var creds = list[i].credentials;

        switch (s.label) {

        case "mongodb" :
          s.db = creds.db;
          s.url = generateUrl("mongodb", creds);
          break;

        case "postgresql" :
          s.database = creds.name;
          s.url = generateUrl("postgresql", creds);
          break;

        case "mysql" :
          s.database = creds.name;
          s.url = generateUrl("mysql", creds);
          break;

        case "redis" :
          s.database = creds.name;
          s.url = generateUrl("redis", creds);
          break;

        case "rabbitmq" :
          s.vhost = creds.vhost;

          if (creds.url !== undefined) {
            s.url = creds.url;

            var uri = require("url").parse(s.url);
            creds.host = uri.hostname;
            creds.port = uri.port;

            var auth = uri.auth.split(":", 2);
            creds.username = auth[0];
            creds.password = auth[1];
          }
          break;

        default:
          s.database = creds.name;

        }

        s.username = creds.username;
        s.password = creds.password;
        s.host = creds.host;
        s.port = creds.port;

        self.serviceProps[s.name] = s;
        if (list.length === 1) self.serviceProps[s.label] = s;

        self.serviceNames.push(s.name);
        self.serviceNamesOfType[s.label].push(s.name);
      }
    }
  }

  return self;
}

function generateUrl (protocol, creds) {
  var db = creds.db || creds.name;
  var url = protocol + "://";
  if (creds.username) url += creds.username;
  if (creds.password) url += ":" + creds.password;
  url += "@" + creds.host + ":" + creds.port + "/" + db;
  return url;
}