-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 24-06-2023 a las 23:42:32
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `beautysoft`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bloque_asignado`
--

CREATE TABLE `bloque_asignado` (
  `id_bloque_asignado` int(11) NOT NULL,
  `id_cita` int(11) DEFAULT NULL,
  `id_estilista` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `id_cita` int(11) NOT NULL,
  `fecha_y_hora` datetime DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_estado` int(11) DEFAULT NULL,
  `id_disponibilidad_estilista` int(11) DEFAULT NULL,
  `duracion_final` time DEFAULT NULL,
  `precio_final` double DEFAULT NULL,
  `creacion` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `correo_cliente` varchar(120) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `direccion` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `correo_cliente`, `estado`, `telefono`, `direccion`) VALUES
(1, 'jsc.2612@gmail.com', 1, '3007502793', NULL),
(2, 'marce123@gmail.com', 1, '3243524', NULL),
(3, 'jhon@hotmail.com', 1, '3243524', NULL),
(4, 'fernando@hotmail.com', 1, '3243524', NULL),
(5, 'arianna@hotmail.com', 1, '3243524', NULL),
(6, 'nuevito@hotmail.com', 1, '2341635435', NULL),
(7, 'nuevito@hotmail.com', 1, '2341635435', NULL),
(8, 'nuevito@hotmail.com', 1, '2341635435', NULL),
(9, 'nuevito@hotmail.com', 1, '2341635435', NULL),
(10, 'nuevo@hotmail.com', 1, '2341635435', 'calle siempre viva');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `disponibilidad_estilista`
--

CREATE TABLE `disponibilidad_estilista` (
  `id_disponibilidad_estilista` int(11) NOT NULL,
  `id_estilista` int(11) DEFAULT NULL,
  `hora_inicio` datetime DEFAULT NULL,
  `hora_fin` datetime DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `id_estados` int(11) NOT NULL,
  `descripcion_estado` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estilista`
--

CREATE TABLE `estilista` (
  `id_estilista` int(11) NOT NULL,
  `correo_estilista` varchar(120) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `id_permiso` int(11) NOT NULL,
  `nombre_permiso` varchar(50) DEFAULT NULL,
  `url_permiso` varchar(200) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso_por_rol`
--

CREATE TABLE `permiso_por_rol` (
  `id_permiso_por_rol` int(11) NOT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `id_permiso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recuperar_pass`
--

CREATE TABLE `recuperar_pass` (
  `id_recuperar_pass` int(11) NOT NULL,
  `codigo` int(11) DEFAULT NULL,
  `token` varchar(200) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(50) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `nombre_rol`, `estado`) VALUES
(1, 'Cliente', 1),
(2, 'Usuario', 1),
(3, 'Estilista', 1),
(4, 'Administrador', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE `servicio` (
  `id_servicio` int(11) NOT NULL,
  `nombre_servicio` varchar(50) DEFAULT NULL,
  `duracion` time DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `valor` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios_por_cita`
--

CREATE TABLE `servicios_por_cita` (
  `id_servicios_por_cita` int(11) NOT NULL,
  `id_servicio_por_estilista` int(11) DEFAULT NULL,
  `id_cita` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio_por_estilista`
--

CREATE TABLE `servicio_por_estilista` (
  `id_servicio_por_estilista` int(11) NOT NULL,
  `id_servicio` int(11) DEFAULT NULL,
  `id_estilista` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `correo_usuario` varchar(150) DEFAULT NULL,
  `usuario` varchar(150) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `contrasena` varchar(150) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `foto_perfil` varchar(200) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `id_recuperar_pass` int(11) DEFAULT NULL,
  `creacion` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `correo_usuario`, `usuario`, `nombre`, `apellido`, `contrasena`, `id_rol`, `foto_perfil`, `estado`, `id_recuperar_pass`, `creacion`) VALUES
(1, 'jsc.2612@gmail.com', 'spell', 'James', 'Sánchez', '123', 1, NULL, 1, NULL, '2023-06-24'),
(2, 'marce123@gmail.com', 'mrce1', 'Marcela', 'Castro', '123', 1, NULL, 1, NULL, '2023-06-24'),
(3, 'jhon@hotmail.com', 'jhon123', 'Jhon', 'Castañeda', '123', 1, NULL, 1, NULL, '2023-06-24'),
(4, 'fernando@hotmail.com', 'fernando12345', 'Fernando', 'Rojas', '123', 1, NULL, 1, NULL, '2023-06-24'),
(5, 'arianna@hotmail.com', 'arianna5', 'Arianna', 'Sermeño', '123', 1, NULL, 1, NULL, '2023-06-24'),
(6, 'nuevo@hotmail.com', 'nuevito', 'nuevito', 'sanchez', '132', 1, NULL, 1, NULL, '2023-06-24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `id_cita` int(11) DEFAULT NULL,
  `fecha` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bloque_asignado`
--
ALTER TABLE `bloque_asignado`
  ADD PRIMARY KEY (`id_bloque_asignado`),
  ADD KEY `id_cita` (`id_cita`),
  ADD KEY `id_estilista` (`id_estilista`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `id_estado` (`id_estado`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_disponibilidad_estilista` (`id_disponibilidad_estilista`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `disponibilidad_estilista`
--
ALTER TABLE `disponibilidad_estilista`
  ADD PRIMARY KEY (`id_disponibilidad_estilista`),
  ADD KEY `id_estilista` (`id_estilista`);

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`id_estados`);

--
-- Indices de la tabla `estilista`
--
ALTER TABLE `estilista`
  ADD PRIMARY KEY (`id_estilista`),
  ADD UNIQUE KEY `correo_estilista` (`correo_estilista`);

--
-- Indices de la tabla `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`id_permiso`);

--
-- Indices de la tabla `permiso_por_rol`
--
ALTER TABLE `permiso_por_rol`
  ADD PRIMARY KEY (`id_permiso_por_rol`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_permiso` (`id_permiso`);

--
-- Indices de la tabla `recuperar_pass`
--
ALTER TABLE `recuperar_pass`
  ADD PRIMARY KEY (`id_recuperar_pass`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`id_servicio`);

--
-- Indices de la tabla `servicios_por_cita`
--
ALTER TABLE `servicios_por_cita`
  ADD PRIMARY KEY (`id_servicios_por_cita`),
  ADD KEY `id_servicio_por_estilista` (`id_servicio_por_estilista`),
  ADD KEY `id_cita` (`id_cita`);

--
-- Indices de la tabla `servicio_por_estilista`
--
ALTER TABLE `servicio_por_estilista`
  ADD PRIMARY KEY (`id_servicio_por_estilista`),
  ADD KEY `id_servicio` (`id_servicio`),
  ADD KEY `id_estilista` (`id_estilista`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_recuperar_pass` (`id_recuperar_pass`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_cita` (`id_cita`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bloque_asignado`
--
ALTER TABLE `bloque_asignado`
  MODIFY `id_bloque_asignado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `disponibilidad_estilista`
--
ALTER TABLE `disponibilidad_estilista`
  MODIFY `id_disponibilidad_estilista` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `id_estados` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estilista`
--
ALTER TABLE `estilista`
  MODIFY `id_estilista` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permiso_por_rol`
--
ALTER TABLE `permiso_por_rol`
  MODIFY `id_permiso_por_rol` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recuperar_pass`
--
ALTER TABLE `recuperar_pass`
  MODIFY `id_recuperar_pass` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `servicio`
--
ALTER TABLE `servicio`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `servicios_por_cita`
--
ALTER TABLE `servicios_por_cita`
  MODIFY `id_servicios_por_cita` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `servicio_por_estilista`
--
ALTER TABLE `servicio_por_estilista`
  MODIFY `id_servicio_por_estilista` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bloque_asignado`
--
ALTER TABLE `bloque_asignado`
  ADD CONSTRAINT `bloque_asignado_ibfk_1` FOREIGN KEY (`id_cita`) REFERENCES `cita` (`id_cita`),
  ADD CONSTRAINT `bloque_asignado_ibfk_2` FOREIGN KEY (`id_estilista`) REFERENCES `estilista` (`id_estilista`);

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_estados`),
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `cita_ibfk_3` FOREIGN KEY (`id_disponibilidad_estilista`) REFERENCES `disponibilidad_estilista` (`id_disponibilidad_estilista`);

--
-- Filtros para la tabla `disponibilidad_estilista`
--
ALTER TABLE `disponibilidad_estilista`
  ADD CONSTRAINT `disponibilidad_estilista_ibfk_1` FOREIGN KEY (`id_estilista`) REFERENCES `estilista` (`id_estilista`);

--
-- Filtros para la tabla `permiso_por_rol`
--
ALTER TABLE `permiso_por_rol`
  ADD CONSTRAINT `permiso_por_rol_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`),
  ADD CONSTRAINT `permiso_por_rol_ibfk_2` FOREIGN KEY (`id_permiso`) REFERENCES `permiso` (`id_permiso`);

--
-- Filtros para la tabla `servicios_por_cita`
--
ALTER TABLE `servicios_por_cita`
  ADD CONSTRAINT `servicios_por_cita_ibfk_1` FOREIGN KEY (`id_servicio_por_estilista`) REFERENCES `servicio_por_estilista` (`id_servicio_por_estilista`),
  ADD CONSTRAINT `servicios_por_cita_ibfk_2` FOREIGN KEY (`id_cita`) REFERENCES `cita` (`id_cita`);

--
-- Filtros para la tabla `servicio_por_estilista`
--
ALTER TABLE `servicio_por_estilista`
  ADD CONSTRAINT `servicio_por_estilista_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicio` (`id_servicio`),
  ADD CONSTRAINT `servicio_por_estilista_ibfk_2` FOREIGN KEY (`id_estilista`) REFERENCES `estilista` (`id_estilista`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`),
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`id_recuperar_pass`) REFERENCES `recuperar_pass` (`id_recuperar_pass`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_cita`) REFERENCES `cita` (`id_cita`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
