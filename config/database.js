var mysql      = require('mysql2');

var pool = mysql.createPool({
    host     : 'localhost',
    user     : 'root',
    password : '',
    database: 'beautysoft',
    port: '3306'
}).promise();



module.exports = pool;

