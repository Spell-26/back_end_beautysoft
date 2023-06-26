const express = require('express');
const router = express.Router();

const conn = require('../../config/database');


async function getCitas(){
    const [citas] = await conn.query("select c.fecha_y_hora as fecha_hora_cita, c.id_cita, cli.correo_cliente, cli.id_cliente, U.nombre as nombre_cliente,\n" +
        "                   U.apellido as apellido_cliente, U.foto_perfil as foto_cliente,\n" +
        "                   de.hora_inicio as inicio_disponibilidad, de.hora_fin as fin_disponiblidad,\n" +
        "                   de.fecha as fecha_disponibilidad, e.correo_estilista, e.id_estilista, u2.nombre as nombre_estilista,\n" +
        "                   u2.apellido as apellido_estilista, u2.foto_perfil as foto_estilista,\n" +
        "                   s.nombre_servicio, s.duracion, s.valor, e2.descripcion_estado, e2.id_estados\n" +
        "            from estilista as e\n" +
        "            JOIN disponibilidad_estilista de on e.id_estilista = de.id_estilista\n" +
        "            JOIN usuario u2 on e.correo_estilista = u2.correo_usuario\n" +
        "            JOIN cita c on c.id_disponibilidad_estilista = de.id_disponibilidad_estilista\n" +
        "            JOIN cliente cli on c.id_cliente = cli.id_cliente\n" +
        "            JOIN usuario u on u.correo_usuario = cli.correo_cliente\n" +
        "            JOIN servicios_por_cita spc on c.id_cita = spc.id_cita\n" +
        "            JOIN servicio_por_estilista spe on spc.id_servicio_por_estilista = spe.id_servicio_por_estilista\n" +
        "            JOIN servicio s on spe.id_servicio = s.id_servicio\n" +
        "            JOIN estados e2 on c.id_estado = e2.id_estados")
    return citas;
}
async function actualizarEstadoCita(idEstado, idCita){
    const query = `UPDATE cita SET id_estado = ? WHERE id_cita = ?`;
    const [actualizar] = await conn.query(query, [idEstado, idCita]);
    return actualizar.affectedRows > 0;
}
//fetch all citas
router.get('/', async (req, res) => {
//(    // //PAGINACION
    // //asignar el numero de la pagina actual
    // let page = (req.query.page !== undefined && req.query.page !== 0) ? req.query.page : 1;
    // //limite de 10 registros por pagina
    // const limit = (req.query.limit !== undefined && req.query.limit !== 0) ? req.query.limit : 10;
    // //valor de inicio en la query
    // let startValue;
    // //valor final de la query
    // let endValue;
    // if(page > 0){
    //     startValue = (page * limit) - limit; // en este caso la paginacion quedaria 10,20,30...n
    //     endValue = page * limit;
    // }else{
    //     //en caso de que estemos en la pagina número 0 se traen los primeros 10 registros
    //     startValue = 0;
    //     endValue = 10
    // };
    //ID DE ESTILISTA QUE SE DEBE MANDAR POR HEADER O POST)
    const citas = await getCitas();
    if(citas.length > 0){
        res.status(200).json({
            count: citas.length,
            citas: citas
        })
    }
    else{
        res.json({
            message: 'No se han encontrado clientes.'
        })
    }
});
//actualizar estado Cita
router.put('/actualizar_estado', async (req, res) =>{
    const idCita = req.body.id_cita;
    const idEstado = req.body.id_estado;

    try{
       const result = await actualizarEstadoCita(idEstado, idCita);
        if (result) {
            res.json({ mensaje: 'Actualización exitosa' });
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