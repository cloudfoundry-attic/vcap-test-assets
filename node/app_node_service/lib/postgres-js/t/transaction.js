var sys = require("sys");
var pg = require("../lib/postgres-pure");
pg.DEBUG=0;

var db = new pg.connect("pgsql://test:12345@localhost:5432/template1");
db.transaction(function (tx) {
    tx.begin();
    tx.query("CREATE TABLE insert_test (id serial not null, val text)", function (err, rs) {
        // Null query.
    });
    tx.query("INSERT INTO insert_test (val) VALUES (?) RETURNING id", "test value", function (err,rs) {
        console.log(sys.inspect(rs));
    });
    tx.prepare("INSERT INTO insert_test (val) VALUES (?) RETURNING id", function (sth) {
        sth.execute("twooooo", function (err, rs) {
            console.log(sys.inspect(rs));
        });
    });
    tx.rollback();
    tx.query("SELECT * FROM insert_test", function (err, rs) {
        // Should error
        console.log(sys.inspect(err));
    });
});
db.close();