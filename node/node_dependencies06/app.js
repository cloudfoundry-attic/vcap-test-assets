var app = require('express').createServer();
var bcrypt = require('bcrypt');

app.get('/', function(req, res) {
  var salt = bcrypt.genSaltSync(10);
  var hash = bcrypt.hashSync("B4c0/\/", salt);
  if (bcrypt.compareSync("B4c0/\/", hash))
    res.send('hello from express');
  else
    res.send('');
});

var port = process.env.VCAP_APP_PORT || 3000
app.listen(port);

console.log('Express server started on port %s', app.address().port);
