var http = require('http');
var url = require('url');

HOST = null;

var host = process.env.VCAP_APP_HOST || 'localhost';
var port = process.env.VCAP_APP_PORT || 3000

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  if(process.version.match(/^v0\.4\./)) {
    res.end('running node04');
  } else if(process.version.match(/^v0\.6\./)) {
    res.end('running node06');
  } else {
    res.end('unknown runtime');
  }
}).listen(port, null);

console.log('Server running at http://' + host + ':' + port + '/');
