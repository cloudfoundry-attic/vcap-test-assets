var sys = require("sys");
var pg = require("../lib/postgres-pure");
pg.DEBUG=0;

var db = new pg.connect("pgsql://test:12345@localhost:5432/template1");
db.prepare("SELECT ?::int AS foobar", function (sth, tx) {
    sth.execute(1, function (err, rs) {
        console.log(sys.inspect(rs));
    });
    sth.execute(2, function (err, rs) {
        console.log(sys.inspect(rs));

    });
});
db.close();