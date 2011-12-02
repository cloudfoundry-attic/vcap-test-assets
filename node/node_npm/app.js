
var app = require('express').createServer();

app.get('/', function(req, res){
    res.send('hello world test using express and npm!');
});

app.listen(process.env.VCAP_APP_PORT || 3000);
