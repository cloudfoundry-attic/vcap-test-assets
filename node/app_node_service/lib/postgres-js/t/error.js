/* Tests whether the error object is being correctly passed to the query
callback function */
var sys = require("sys");
var pg = require("../lib/postgres-pure");
pg.DEBUG=0;

var db = new pg.connect("pgsql://test:12345@localhost:5432/template1");
db.query("SELECT 1::foobar;", function (err, rs, tx) {
    console.log("error not null: " + not_eq(null, err));
    console.log("error code is 42704 (no such type foobar): " + eq("42704", err.code));
});
db.close();

function not_eq (l, r) {
    if (l !== r) {
        return "ok"
    }
    return "not ok\n " + l + " != " + r;
}

function eq (l, r) {
    if (l === r) {
        return "ok"
    }
    return "not ok\n " + l + " != " + r;
}