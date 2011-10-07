var sys = require("sys");
var pg = require("./lib/postgres-pure");
// pg.DEBUG=4;

var db = new pg.connect("pgsql://test:12345@localhost:5432/insert_test");

// db.query("SELECT 1::errortest;", function (error, rs, tx) {
//     if (error) {
//         console.log("Error!");
//         console.log(error);
//         console.log(error.code);
//     }
//     else {
//         console.log(sys.inspect(rs));
//     }
// });

// db.query("SELECT 1::querytest;", function (error, rs, tx) {
//     if (error) {
//         console.log("Error!");
//         console.log(error);
//         console.log(error.code);
//     }
//     else {
//         console.log(sys.inspect(rs));
//     }
//
//     tx.query("SELECT 2::int as querytest2", function (err, rs) {
//         console.log(sys.inspect(rs));
//     });
//     tx.query("SELECT 3::qt" ,function (err, rs) {
//         console.log(sys.inspect(err));
//     })
// });

// db.prepare("INSERT INTO returning_test (val) VALUES (?) RETURNING id, val", function (sth) {
//     sth.execute("text value", function(e, rs) {
//         if (rs === undefined) {
//             console.log("No data.");
//         }
//         else {
//             console.log(sys.inspect(rs));
//         }
//     });
// });

db.prepare("SELECT ?::int AS preparetest", function (sth, tx) {
    sth.execute(1, function (err, rs) {
        console.log(sys.inspect(rs));
    });
    sth.execute(2, function (err, rs) {
        console.log(sys.inspect(rs));

    });
    tx.prepare("SELECT ?::int AS preparetest2", function (sth) {
       sth.execute(3, function (err, rs) {
           console.log(sys.inspect(rs));
       }) ;
    });
    tx.prepare("SELECT ?::int AS preparetest2", function (sth) {
       sth.execute(4, function (err, rs) {
           console.log(sys.inspect(rs));
       }) ;
    });
});

// db.transaction(function (tx) {
//     tx.begin();
//     // tx.query("INSERT INTO insert_test (val) VALUES (?) RETURNING id", "test value", function (err,rs) {
//     //     console.log(sys.inspect(rs));
//     // });
//     // tx.prepare("INSERT INTO insert_test (val) VALUES (?) RETURNING id", function (sth) {
//     //     sth.execute("twooooo", function (err, rs) {
//     //         console.log(sys.inspect(rs));
//     //     });
//     // });
//     tx.query("SELECT 1::barrrrrr", function (err, rs) {
//         console.log(sys.inspect(err));
//     });
//     tx.query("SELECT 1::int as foobar", function (err, rs) {
//         console.log(sys.inspect(err));
//     });
//     tx.rollback();
//     tx.query("SELECT 1::int as foobarbaz", function (err, rs) {
//         console.log(sys.inspect(rs));
//     });
// });
db.close();

// db.prepare(query, function (sth, tx) {
//     sth.execute(args, callback, errback);
// })