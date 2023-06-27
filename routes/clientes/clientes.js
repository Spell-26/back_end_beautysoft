const express = require('express');
const conexion = require('../../config/conexionJhon');
const router = express.Router();


//Find cliente
router.get('/', (req,res)=>{
    const sql = `SELECT U.nombre, U.apellido,r.nombre_rol,c.id_cliente, C.correo_cliente, C.telefono, C.direccion 
    FROM cliente C JOIN usuario U ON C.correo_cliente = U.correo_usuario 
    JOIN rol r ON U.id_rol = r.id_rol;`;

conexion.query(sql, (error, results, fields) => {
  if (error) {
    console.error('Error al realizar la consulta:', error);
  } else {
    res.json({
        message:results
    });
  }
});
})

//Get cliente
router.get('/:id', (req,res)=>{
    const {id} = req.params
    const sql = 'SELECT * FROM cliente where id_cliente=?';

conexion.query(sql,[id], (error, results, fields) => {
  if (error) {
    console.error('Error al realizar la consulta:', error);
  } else {
    res.json({
        message:results
    });
  }
});
})


router.post('/',(req,res)=>{
    const correo=req.body.correo;
    const estado=req.body.estado;
    const telefono =req.body.telefono;
    const direccion =req.body.direccion;
    const sql = `insert into cliente (correo_cliente, estado, telefono, direccion ) VALUES ('${correo}','${estado}', '${telefono}','${direccion}' )`
    conexion.query(sql, (error, results, fields) => {
        if (error) {
          console.error('Error al realizar la consulta:', error);
        } else {
          res.json({
              status: 'cliente agregado'
          });
        }
      });
})

//Consulta para eliminar
router.delete('/:id', (req,res)=>{
    const {id} = req.params
    const sql = `DELETE  FROM cliente where id_cliente= '${id}'`;

conexion.query(sql,[id], (error, results, fields) => {
  if (error) {
    console.error('Error al realizar la consulta:', error);
  } else {
    res.json({
        status: 'cliente eliminado'
    });
  }
    });
})

//Modificar
router.put('/',(req, res)=>{
    
    const{id, correo} = req.body

    let sql = `update cliente set correo_cliente ='${correo}' where id_cliente = '${id}'`
    
    conexion.query(sql, (err, rows, fields)=>{
        if(err) throw err
        else{
            res.json({status: 'cliente modificado'})
        }
    })

})

module.exports = router
