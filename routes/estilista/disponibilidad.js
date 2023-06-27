const express = require('express');
const router = express.Router();
const conn = require('../../config/database');

async function getDisponibilidades(){
    const [dispo] = await conn.query("SELECT * FROM disponibilidad_estilista");
    return dispo;
}

router.get('/', async (req, res) => {
    const dispo =  await getDisponibilidades();
    if(dispo.length > 0){
        res.status(200).json({
            count: dispo.length,
            disponibilidades: dispo
        })
    }
    else{
        res.json({
            message: 'No se han encontrado clientes.'
        })
    }
})

module.exports = router;