const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const app = express();
const cors = require('cors');
//trabajar con json que vienen por POST
const bodyparser = require('body-parser');
app.use(bodyparser.json());


//RUTAS
const clientesRouter = require('./routes/clientes/clientes');
const usuariosRouter = require('./routes/users');
//vista citas del actor Estilista
const estilistaCitasRouter = require('./routes/estilista/citas');
const estilistaDispoRouter = require('./routes/estilista/disponibilidad');
const estilistaServiciosCita = require('./routes/estilista/servicio_x_cita')
//servicios
const serviciosRouter = require('./routes/servicios/servicios');

//USAR RUTAS
app.use('/api/clientes', clientesRouter);
app.use('/api/usuarios', usuariosRouter);
//rutas estilista
app.use('/api/estilista/citas', estilistaCitasRouter);
app.use('/api/estilista/disponibilidad', estilistaDispoRouter);
app.use('/api/estilista/servicio-cita', estilistaServiciosCita);
//fin rutas estilista
app.use('/api/servicios', serviciosRouter)

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "http://localhost:4200"); // puerto del front
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));



module.exports = app;
