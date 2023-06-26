const express = require('express');
const router = express.Router();

const conn = require('../../config/database');

async function getServicios(){
    const [servicios] = await conn.query("SELECT * FROM servicio");
    return servicios;
}

router.get('/', async (req, res) => {
    const servicios =  await getServicios();
    if(servicios.length > 0){
        res.status(200).json({
            count: servicios.length,
            servicios: servicios
        })
    }
    else{
        res.json({
            message: 'No se han encontrado clientes.'
        })
    }
})

module.exports = router;