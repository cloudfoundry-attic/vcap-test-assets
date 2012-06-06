/*
 * Cloud Foundry API module
 * Service connection module helper
 */

var app = require("./properties");

function ServiceClient () { }

exports.ServiceClient = ServiceClient;

ServiceClient.prototype.create = function () {
  if (!this.type) return false;

  var svcNames = app.serviceNamesOfType[this.type];
  if (!svcNames) return false;

  if (svcNames.length !== 1) {
    throw new Error("Expected 1 service of " + this.type + " type, " +
                    "but found " + svcNames.length + ". " +
                    "Consider using createFromSvc(name) instead.");
  }

  var args = Array.prototype.slice.call(arguments);
  args.unshift(svcNames[0]);

  return this.createFromSvc.apply(this, args);
};

ServiceClient.prototype.createFromSvc = function (name) {
  var handler = this._create;
  if (!handler) return false;

  var props = app.serviceProps[name];

  if (!props) return false;

  switch (arguments.length) {
    case 2: return handler.call(this, props, arguments[1]);
    case 3: return handler.call(this, props, arguments[1], arguments[2]);
    default: return handler.call(this, props);
  }
};