var lib_http = require('http');
var lib_fs = require('fs');
var lib_sys = require('sys');

// Define a helper to log things at an easily predictable location.
function myLog(pStr)
{
  console.log(pStr);
  // Optional alternative destination...
  // var lF = lib_fs.openSync("/tmp/mvstore-applog.txt", "a+"); // REVIEW: hard-coded.
  // lib_fs.writeSync(lF, pStr);
  // lib_fs.writeSync(lF, "\n");
  // lib_fs.close(lF);
}
myLog("started at " + new Date());
myLog("process.env: " + JSON.stringify(process.env));

// Determine the web app and db host/port mapping, also allowing for standalone execution outside of CF.
var MYPORT = (process.env.VCAP_APP_PORT || 3000);
var MYHOST = (process.env.VCAP_APP_HOST || 'localhost');
var MYPORT_DB = 4560;
var MYHOST_DB = 'localhost';
var MYUSER_DB = 'default';
var MYUSERPW_DB = '';
var MYSERVICES = process.env.VCAP_SERVICES;
if (undefined != MYSERVICES)
{
  // Note:
  //   If a mvstore service is bound to the app, we expect something like this:
  //   {
  //     "mvstore-1.0":
  //     [{
  //       "name":"mvstore-becd2",
  //       "label":"mvstore-1.0",
  //       "plan":"free",
  //       "tags":["mvstore","nosql"],
  //       "credentials":{"hostname":"172.16.228.128","port":25001,"username":"525c549c-4e73-46ae-87f8-c8fdea5c4b27","password":"9d5c8f92-aac6-4f5a-b61c-9e63f1bd1451","name":"mvstore-8eb852a8-e276-4a1e-b3d8-5584a7577f7e","db":"db"}
  //     }]
  //   }
  myLog(MYSERVICES);
  MYSERVICES = JSON.parse(MYSERVICES);
  if (undefined != MYSERVICES['mvstore-1.0'])
  {
    MYPORT_DB = MYSERVICES['mvstore-1.0'][0]['credentials']['port'];
    MYHOST_DB = MYSERVICES['mvstore-1.0'][0]['credentials']['hostname'];
    MYUSER_DB = MYSERVICES['mvstore-1.0'][0]['credentials']['username'].replace(/\-/g, "");
    MYUSERPW_DB = MYSERVICES['mvstore-1.0'][0]['credentials']['password'].replace(/\-/g, "");
  }
}
myLog("mvstore bound at: " + MYHOST_DB + ":" + MYPORT_DB);
myLog("app " + process.env.VMC_APP_NAME + " bound at: " + MYHOST + ":" + MYPORT);

// Define a small helper to serialize things (similar to the Step module).
function InstrSeq()
{
  var iSubStep = 0;
  var lSubSteps = new Array();
  var lThis = this;
  this.next = function() { iSubStep++; if (iSubStep < lSubSteps.length) lSubSteps[iSubStep](); }
  this.push = function(pSubStep) { lSubSteps.push(pSubStep); }
  this.start = function() { iSubStep = 0; lSubSteps[iSubStep](); }
  this.curstep = function() { return iSubStep; }
  this.simpleOnResponse = function(pError, pResponse)
  {
    if (pError) { myLog("\n*** ERROR in substep " + lThis.curstep() + ": " + _pError + "\n"); }
    else { myLog("Result from substep " + lThis.curstep() + ":" + JSON.stringify(pResponse)); lThis.next(); }
  }
}

// Launch our trivial web server.
lib_http.createServer(
  function (req, res)
  {
    myLog("app " + process.env.VMC_APP_NAME + " received a request: " + req.url);
    res.writeHead(200, {'Content-Type': 'text/plain'});

    // Setup a simple http interface to mvstore via mvsql.
    // Note: I don't use mvstore's client here, just to simplify the deployment of this test.
    var lMvStore = lib_http.createClient(MYPORT_DB, MYHOST_DB/*'localhost'*/);
    var lAuth = MYUSER_DB + ":" + MYUSERPW_DB;
    myLog("auth: " + lAuth);
    var lHeaders = [["Authorization", "Basic " + new Buffer(lAuth, "ascii").toString("base64")]];
    var lCallMv = function(_pMvsql)
    {
      var _lSS = new InstrSeq();
      var _lR1r = "";
      _lSS.push(
        function() {
          myLog("emitting mvsql: " + _pMvsql);
          var _lDbReq = lMvStore.request('GET', "/db/?q=" + encodeURIComponent(_pMvsql) + "&i=mvsql&o=json", lHeaders);
          _lDbReq.on('response', function(__pResponse) {
            __pResponse.setEncoding('utf8');
            __pResponse.on('data', function(__pChunk) { myLog("received data from mvstore: " + __pChunk); _lR1r = _lR1r + __pChunk; });
            __pResponse.on('end', function() { myLog("received end from mvstore"); _lSS.next(); });
            __pResponse.on('close', function() { myLog("received close from mvstore"); _lSS.next(); });
          });
          _lDbReq.on('error', function(__pError) { myLog("received error from mvstore: " + __pError); _lSS.next(); });
          _lDbReq.end();
        });
      // Publish mvstore's json response as our own.
      _lSS.push(function() { res.end(_lR1r); });
      _lSS.start();
    }

    // Handle the incoming request.
    var lMatchBasicReq = req.url.match(/\/service\/mvstore\/(\w+)$/)
    if (undefined != lMatchBasicReq)
    {
      var lKey = lMatchBasicReq[1];
      myLog("basic request: key=" + lKey + " method=" + req.method);
      if (req.method.match(/^get$/i))
        lCallMv("SELECT * WHERE mvstore_bvt1_key='" + lKey + "');");
      else if (req.method.match(/^(put|post)$/i))
      {
        var lIncoming = ""
        req.on('data', function(_pChunk) { lIncoming += _pChunk; });
        req.on('end', function() { lCallMv("INSERT (mvstore_bvt1_hello, mvstore_bvt1_date, mvstore_bvt1_key, mvstore_bvt1_value) VALUES ('Hello from " + process.env.VMC_APP_NAME + "', '" + new Date() + "', '" + lKey + "', '" + lIncoming + "');"); });
      }
      else if (req.method.match(/^delete$/i))
        lCallMv("DELETE WHERE mvstore_bvt1_key='" + lKey + "');");
      else
        myLog("unexpected http method: " + req.method);
    }
    else
    {
      // Default handling (+/- a basic 'echo').
      myLog("default handling for " + req.url);
      lCallMv("INSERT (mvstore_bvt1_hello, mvstore_bvt1_date) VALUES ('Hello from " + process.env.VMC_APP_NAME + "', '" + new Date() + "');");
    }
  }).listen(Number(MYPORT), MYHOST);
