var sys = require("sys");
var pg = require("../lib/postgres-pure");
pg.DEBUG=0;

var db = new pg.connect("pgsql://test:12345@localhost:5432/template1");
db.query("SELECT 1::int as foobar;", function (err, rs, tx) {
    console.log(sys.inspect(rs));
    tx.query("SELECT 2::int as foobartwo", function (err, rs) {
        console.log(sys.inspect(rs));
    });
});
db.close();