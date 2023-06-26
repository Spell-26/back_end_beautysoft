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







module.exports = router;
