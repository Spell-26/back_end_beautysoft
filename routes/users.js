const express = require('express');
const router = express.Router();

// Conexion con la base de datos
const conn = require('../config/database');

// Función para obtener los usuarios
async function getUsuarios() {
  const [usuarios] = await conn.query("SELECT * FROM usuario");
  return usuarios;
}

// Ruta para obtener todos los usuarios
router.get('/', async (req, res) => {
  try {

    const usuarios = await getUsuarios();
    if (usuarios.length > 0) {
      res.status(200).json({
        count: usuarios.length,
        usuarios: usuarios
      });
    } else {
      res.json({
        message: 'No se han encontrado usuarios.'
      });
    }
  } catch (error) {
    console.error('Error al obtener los usuarios:', error);
    res.status(500).json({ error: 'Error al obtener los usuarios' });
  }
});


//obtener un solo usuario 

router.get('/', async (req, res) => {
  try {

    const usuarios = await getUsuarios();
    if (usuarios.length > 0) {
      res.status(200).json({
        count: usuarios.length,
        usuarios: usuarios
      });
    } else {
      res.json({
        message: 'No se han encontrado usuarios.'
      });
    }
  } catch (error) {
    console.error('Error al obtener los usuarios:', error);
    res.status(500).json({ error: 'Error al obtener los usuarios' });
  }
});

//funcion para agregar un nuevo usuario


async function agregarUsuario(correo_usuario, nombre, apellido, contraseña) {
  const query = 'INSERT INTO usuario (correo_usuario, nombre, apellido, contrasena, id_rol, estado) values(?,?,?,?,2,1)' ;
  const [result] = await conn.query(query, [correo_usuario, nombre, apellido, contraseña]);
  return result.insertId;
}


// Ruta para agregar un nuevo usuario
router.post('/', async (req, res) => {
  try {
    const correo_usuario = req.body.correo_usuario; // Suponiendo que el objeto del nuevo usuario se encuentra en el cuerpo de la solicitud (req.body)
    const nombre = req.body.nombre; // Suponiendo que el objeto del nuevo usuario se encuentra en el cuerpo de la solicitud (req.body)
    const apellido = req.body.apellido; // Suponiendo que el objeto del nuevo usuario se encuentra en el cuerpo de la solicitud (req.body)
    const contraseña = req.body.contraseña; // Suponiendo que el objeto del nuevo usuario se encuentra en el cuerpo de la solicitud (req.body)
    
    const usuarioId = await agregarUsuario(correo_usuario, nombre, apellido, contraseña);
    res.status(201).json({ message: 'Usuario agregado exitosamente.' });
  } catch (error) {
    console.error('Error al agregar el usuario:', error);
    res.status(500).json({ error: 'Error al agregar el usuario.' });
  }
});


// Ruta para editar un usuario por su ID
router.put('/:id', async (req, res) => {
  try {
    const usuarioId = req.params.id;
    const { correo_usuario, nombre, apellido, contraseña } = req.body;

    const query = 'UPDATE usuario SET correo_usuario = ?, nombre = ?, apellido = ?, contrasena = ? WHERE id_usuario = ?';
    const values = [correo_usuario, nombre, apellido, contraseña, usuarioId];

    await conn.query(query, values);
    
    res.status(200).json({ message: 'Usuario actualizado exitosamente.' });
  } catch (error) {
    console.error('Error al editar el usuario:', error);
    res.status(500).json({ error: 'Error al editar el usuario.' });
  }
});






module.exports = router;
