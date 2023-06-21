CREATE TABLE `Usuario` (
  `id_usuario` int PRIMARY KEY AUTO_INCREMENT,
  `correo_usuario` varchar(150),
  `usuario` varchar(150),
  `nombre` varchar(50),
  `apellido` varchar(50),
  `contrasena` varchar(150),
  `id_rol` int,
  `foto_perfil` varchar(200),
  `estado` boolean,
  `id_recuperar_pass` int
);

CREATE TABLE `Recuperar_pass` (
  `id_recuperar_pass` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` int,
  `token` varchar(200),
  `fecha` date,
  `hora` time
);

CREATE TABLE `Disponibilidad_estilista` (
  `id_disponibilidad_estilista` int PRIMARY KEY AUTO_INCREMENT,
  `id_estilista` int,
  `hora_inicio` datetime,
  `hora_fin` datetime,
  `fecha` date,
  `estado` boolean
);

CREATE TABLE `Cliente` (
  `id_cliente` int PRIMARY KEY AUTO_INCREMENT,
  `id_rol` int,
  `correo_cliente` varchar(120) UNIQUE,
  `estado` boolean,
  `telefono` varchar(50)
);

CREATE TABLE `Estilista` (
  `id_estilista` int PRIMARY KEY AUTO_INCREMENT,
  `id_rol` int,
  `correo_estilista` varchar(120) UNIQUE,
  `estado` boolean
);

CREATE TABLE `Rol` (
  `id_rol` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_rol` varchar(50),
  `estado` boolean
);

CREATE TABLE `Permiso_por_rol` (
  `id_permiso_por_rol` int PRIMARY KEY AUTO_INCREMENT,
  `id_rol` int,
  `id_permiso` int
);

CREATE TABLE `Estados` (
  `id_estados` int PRIMARY KEY AUTO_INCREMENT,
  `descripcion_estado` varchar(150)
);

CREATE TABLE `Permiso` (
  `id_permiso` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_permiso` varchar(50),
  `url_permiso` varchar(200),
  `estado` boolean
);

CREATE TABLE `Servicio` (
  `id_servicio` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_servicio` varchar(50),
  `duracion` time,
  `descripcion` varchar(100),
  `valor` int,
  `estado` boolean
);

CREATE TABLE `Servicio_por_estilista` (
  `id_servicio_por_estilista` int PRIMARY KEY AUTO_INCREMENT,
  `id_servicio` int,
  `id_estilista` int,
  `estado` boolean
);

CREATE TABLE `Cita` (
  `id_cita` int PRIMARY KEY AUTO_INCREMENT,
  `fecha_y_hora` datetime,
  `id_cliente` int,
  `id_estado` int,
  `id_disponibilidad_estilista` int,
  `duracion_final` time,
  `precio_final` double
);

CREATE TABLE `Bloque_asignado` (
  `id_bloque_asignado` int PRIMARY KEY AUTO_INCREMENT,
  `id_cita` int,
  `id_estilista` int
);

CREATE TABLE `Ventas` (
  `id_venta` int PRIMARY KEY AUTO_INCREMENT,
  `id_cita` int
);

CREATE TABLE `servicios_por_cita` (
  `id_servicios_por_cita` int PRIMARY KEY AUTO_INCREMENT,
  `id_servicio_por_estilista` int,
  `id_cita` int
);

ALTER TABLE `Cita` ADD FOREIGN KEY (`id_estado`) REFERENCES `Estados` (`id_estados`);

ALTER TABLE `Usuario` ADD FOREIGN KEY (`id_rol`) REFERENCES `Rol` (`id_rol`);

ALTER TABLE `Permiso_por_rol` ADD FOREIGN KEY (`id_rol`) REFERENCES `Rol` (`id_rol`);

ALTER TABLE `Permiso_por_rol` ADD FOREIGN KEY (`id_permiso`) REFERENCES `Permiso` (`id_permiso`);

ALTER TABLE `Servicio_por_estilista` ADD FOREIGN KEY (`id_servicio`) REFERENCES `Servicio` (`id_servicio`);

ALTER TABLE `Servicio_por_estilista` ADD FOREIGN KEY (`id_estilista`) REFERENCES `Estilista` (`id_estilista`);

ALTER TABLE `Cita` ADD FOREIGN KEY (`id_cliente`) REFERENCES `Cliente` (`id_cliente`);

ALTER TABLE `Bloque_asignado` ADD FOREIGN KEY (`id_cita`) REFERENCES `Cita` (`id_cita`);

ALTER TABLE `Cita` ADD FOREIGN KEY (`id_disponibilidad_estilista`) REFERENCES `Disponibilidad_estilista` (`id_disponibilidad_estilista`);

ALTER TABLE `Bloque_asignado` ADD FOREIGN KEY (`id_estilista`) REFERENCES `Estilista` (`id_estilista`);

ALTER TABLE `Ventas` ADD FOREIGN KEY (`id_cita`) REFERENCES `Cita` (`id_cita`);

ALTER TABLE `Disponibilidad_estilista` ADD FOREIGN KEY (`id_estilista`) REFERENCES `Estilista` (`id_estilista`);

ALTER TABLE `Usuario` ADD FOREIGN KEY (`id_recuperar_pass`) REFERENCES `Recuperar_pass` (`id_recuperar_pass`);

ALTER TABLE `servicios_por_cita` ADD FOREIGN KEY (`id_servicio_por_estilista`) REFERENCES `Servicio_por_estilista` (`id_servicio_por_estilista`);

ALTER TABLE `servicios_por_cita` ADD FOREIGN KEY (`id_cita`) REFERENCES `Cita` (`id_cita`);
