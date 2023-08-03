const express = require('express');
const conexion = require('../../config/conexionJhon');
const router = express.Router();


//Find cliente
router.get('/', (req,res)=>{
    const sql = `SELECT U.nombre, U.apellido,r.nombre_rol,c.id_cliente, C.correo_cliente, C.telefono, c.direccion
    FROM cliente C JOIN usuario U ON C.correo_cliente = U.correo_usuario JOIN rol r ON U.id_rol = r.id_rol`

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
    const correo_usuario=req.body.correo;
    const nombre=req.body.nombre;
    const apellido=req.body.apellido;
    const contrasena=req.body.contraseña;
    const inserUsuarios = `Insert into usuario (correo_usuario, nombre, apellido, contrasena,estado, id_rol ) VALUES('${correo_usuario}', '${nombre}', '${apellido}', '${contrasena}', 1, 1)`
    const sql = `insert into cliente (correo_cliente, estado, telefono, direccion ) VALUES ('${correo}','${estado}', '${telefono}','${direccion}' )`
    conexion.query(inserUsuarios, (error, results, fields) => {
      if (error) {
        console.error('Error al realizar la consulta:', error);
      } else {
        res.json({
          status: 'usuario agregado'
        });
      }
      
      
    });  
    conexion.query(sql, (error, results, fields) => {
      
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
router.put('/:id',(req, res)=>{
    const id= req.params.id
    const{ correo} = req.body

    let sql = `update cliente set correo_cliente ='${correo}' where id_cliente = '${id}'`
    
    conexion.query(sql, (err, rows, fields)=>{
        if(err) throw err
        else{
            res.json({
              id,
              correo
            })
        }
    })

})

router.put('/estado/:idEstado', (req, res)=>{
  const idEstado=req.params.id;
  const estado=req.body.estado;
  let consulta =`update cliente set estado = 1 where id_cliente = '${idEstado}'`
  conexion.query(consulta,(error,rows,fields)=>{
    if (error) {
      console.error('Error al realizar la consulta:', error);
    } else {
      res.json({
          status: 'Estado cambiado'
      });
    }
      });
  })


module.exports = router
