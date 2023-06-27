const mysql = require('mysql2');

const conexion = mysql.createConnection({
    host:'127.0.0.1',
    user: 'root',
    port:'3307',
    password: '',
    database: 'beautysoft'
})

module.exports=conexion;