const express = require('express');
const router = express.Router();
const conn = require('../../config/database');

async function nuevoServicioCita(servicio_estilista, id_cita){
    const query = `INSERT INTO servicios_por_cita (id_servicio_por_estilista, id_cita) VALUES(?,?)`;
    const nuevoServicioCita = conn.query(query, [servicio_estilista, id_cita]);
    return nuevoServicioCita;
}

router.post('/nuevo-servicio-por-cita', async (req, res) => {
    const id_serv_estilista = req.body.serv_estilista;
    const id_cita = req.body.id_cita;

    try{
        const result = await nuevoServicioCita(id_serv_estilista, id_cita);
        if (result) {
            res.json({
                mensaje: 'Actualización exitosa'
            });
        } else {
            res.status(404).json({ mensaje: 'No se encontró el registro para actualizar' });
        }
    }
    catch (error) {
        console.error('Error al actualizar:', error);
        res.status(500).json({ mensaje: 'Error al actualizar' });
    }
})

module.exports = router;