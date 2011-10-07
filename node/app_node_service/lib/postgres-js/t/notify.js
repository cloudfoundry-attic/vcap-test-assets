/* Tests whether the error object is being correctly passed to the query
callback function */
var sys = require("sys");
var pg = require("../lib/postgres-pure");
pg.DEBUG=0;

var db = new pg.connect("pgsql://test:12345@localhost:5432/template1");
var db2 = new pg.connect("pgsql://test:12345@localhost:5432/template1");

db.notify("test", function (err, payload) {
    console.log(eq(err, null));
});
db2.on("connection", function () {
    db2.query("NOTIFY test", function (err,rs) {}); // Null
    db2.close();
});
db.close();


function not_eq (l, r) {
    if (l !== r) {
        return "ok"
    }
    return "not ok  " + l + " != " + r;
}

function eq (l, r) {
    if (l === r) {
        return "ok"
    }
    return "not ok   " + l + " != " + r;
}