var mysql      = require('mysql2');

var pool = mysql.createPool({
    host     : '127.0.0.1',
    user     : 'root',
    password : '',
    database: 'beautysoft',
    port:      '3306'
}).promise();



module.exports = pool;

