const mysql = require('mysql2');

const conexion = mysql.createConnection({
    host:'127.0.0.1',
    user: 'root',
    port:'3306',
    password: '',
    database: 'beautysoft'
})

module.exports=conexion;