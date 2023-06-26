const mysql = require('mysql');

const conexion = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '',
    database: 'beautysoft',
    port: 3306
});

conexion.connect((err)=>{
    if(err){
        console.log('ha ocurrido un error' + err)
    }else{
        console.log('la base de daatos se ha conectado')
    }
});


module.exports = conexion;


