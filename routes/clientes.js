const express = require('express');
const router = express.Router();



//importar la conexion a la base de datos
const {database} = require('../config/helpers')


/* OBTENER TODOS LOS USUARIOS */
router.get('/', function(req, res) {
  //PAGINACION
  //asignar el numero de la pagina actual
  let page = (req.query.page !== undefined && req.query.page !== 0) ? req.query.page : 1;
  //limite de 10 registros por pagina
  const limit = (req.query.limit !== undefined && req.query.limit !== 0) ? req.query.limit : 10;

  //valor de inicio en la query
  let startValue;
  //valor final de la query
  let endValue;

  if(page > 0){
    startValue = (page * limit) - limit; // en este caso la paginacion quedaria 10,20,30...n
    endValue = page * limit;
  }else{
    //en caso de que estemos en la pagina número 0 se traen los primeros 10 registros
    startValue = 0;
    endValue = 10
  }

  //CONSULTA A LA BASE DE DATOS
    // obtener todos los usuarios
  database.table('cliente as c')
      .join([{
          table: 'usuario as u',
          on: 'u.correo_usuario = c.correo_cliente',
      },//para joins multiples se crean más objetos dentro de este array
          {
          table: 'rol as r',
          on: 'r.id_rol = u.id_rol',
      }])
      .withFields([
          'u.nombre as nombre',
          'u.apellido as apellido',
          'r.nombre_rol as rol',
          'c.correo_cliente as correo',
          'c.id_cliente as id',
          'u.estado as estado',
          'c.estado as estado',
          'c.telefono as telefono',
          'u.creacion as fecha_creacion',
          'c.direccion as direccion'
      ])
      .slice(startValue, endValue)
      .sort({ id: -1 })
      .getAll()
      .then(client =>{
        if(client.length > 0){
          res.status(200).json({
            count: client.length,
            clientes: client
          })
        } else{
          res.json({
            message: 'No se han encontrado clientes.'
          })
        }
      }).catch(err => {
      console.log(err);
      res.status(400).json({
          message: 'BAD REQUEST'
      });
  });
});
//FILTRAR CLIENTE POR ID
router.get('/:clientId', (req, res) => {
    let clienteId = req.params.clientId;
    clienteId = parseInt(clienteId);

    // obtener todos los usuarios
    database.table('cliente as c')
        .join([{
            table: 'usuario as u',
            on: 'u.correo_usuario = c.correo_cliente',
            },//para joins multiples se crean más objetos dentro de este array
            {
                table: 'rol as r',
                on: 'r.id_rol = u.id_rol',
            }])
        .withFields([
            'u.nombre as nombre',
            'u.apellido as apellido',
            'r.nombre_rol as rol',
            'c.correo_cliente as correo',
            'c.id_cliente as id'
        ])
        .filter({'c.id_cliente' : clienteId})
        .get()
        .then(client =>{
            if(client){
                res.status(200).json(client)
            } else{
                res.json({
                    message: 'No se han encontrado clientes.'
                })
            }
        }).catch(err => {
        console.log(err);
        res.status(400).json({
            message: 'BAD REQUEST'
        });
    });
    //end query
});
//NUEVO CLIENTE
router.post('/nuevo', (req, res) => {
    let {correo, estado, telefono, direccion} = req.body;

    if(correo !== null && correo.length > 10){
        database.table('cliente')
            .insert({
                correo_cliente : correo,
                estado : estado,
                telefono : telefono,
                direccion : direccion
            }).then(client =>{
            if(client){
                res.status(200).json(client)
            } else{
                res.json({
                    message: 'No se ha podido mregistrar.'
                })
            }
        }).catch(err => console.log(err));
    }else{
        console.log("!no entro!")
    }

});

module.exports = router;
