-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-11-2024 a las 19:43:01
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `the_house_paws`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_cliente_tel` (IN `p_cliente_id` INT, IN `p_nuevo_tel` VARCHAR(20))   BEGIN
    UPDATE cliente
    SET cli_tel = p_nuevo_tel
    WHERE cli_ID = p_cliente_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_mascota` (IN `p_mascota_id` INT)   BEGIN
    DELETE FROM mascota
    WHERE masct_ID = p_mascota_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_cirugia` (IN `p_cirugia` TEXT)   BEGIN
    INSERT INTO historial_cirugias (cir_cirugias_previas)
    VALUES (p_cirugia);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_dieta` (IN `p_dieta` VARCHAR(255))   BEGIN
    INSERT INTO dieta (Diet_dieta)
    VALUES (p_dieta);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_enfermedad` (IN `p_enfermedad` TEXT)   BEGIN
    INSERT INTO enfermedades (enf_enfermedades)
    VALUES (p_enfermedad);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_mascota` (IN `p_cliente_id` INT, IN `p_nombre` VARCHAR(100), IN `p_especie` VARCHAR(50), IN `p_raza` VARCHAR(50))   BEGIN
    INSERT INTO mascota (masct_Cliente_ID, masct_nom, masct_especie, masct_raza)
    VALUES (p_cliente_id, p_nombre, p_especie, p_raza);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_tratamiento` (IN `p_tipo_tratamiento` VARCHAR(255), IN `p_medicamentos` TEXT, IN `p_dosis` VARCHAR(255), IN `p_fecha_inicio` DATE, IN `p_fecha_fin` DATE)   BEGIN
    INSERT INTO tratamiento (tr_tipo_tratamiento, tr_medicamentos, tr_dosis, tr_fecha_inicio, tr_fecha_fin)
    VALUES (p_tipo_tratamiento, p_medicamentos, p_dosis, p_fecha_inicio, p_fecha_fin);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mascotas_esterilizadas` ()   BEGIN
    SELECT hc.hc_Esterilizacion_ID, mas.masct_nom, mas.masct_raza, est.est_esterilizado
    FROM historial_clinico AS hc
    INNER JOIN mascota AS mas ON hc.hc_Mascota_ID = mas.masct_ID
    INNER JOIN esterilizacion AS est ON hc.hc_Esterilizacion_ID = est.est_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `peluqueria_veterinarias` ()   BEGIN
    SELECT vet.vet_nombre, pel.peluq_servicios, pel.peluq_precio
    FROM peluqueria_serv AS pel
    INNER JOIN veterinaria AS vet ON pel.peluq_Veterinaria_ID = vet.vet_ID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `adopcion`
--

CREATE TABLE `adopcion` (
  `adop_ID` int(11) NOT NULL,
  `adop_Mascota_ID` int(11) DEFAULT NULL,
  `adop_Fecha_Adopcion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `adopcion`
--

INSERT INTO `adopcion` (`adop_ID`, `adop_Mascota_ID`, `adop_Fecha_Adopcion`) VALUES
(1, 1, '2024-10-01'),
(2, 2, '2024-10-02'),
(3, 3, '2024-10-03'),
(4, 4, '2024-10-04'),
(5, 5, '2024-10-05'),
(6, 6, '2024-10-06'),
(7, 7, '2024-10-07'),
(8, 8, '2024-10-08'),
(9, 9, '2024-10-09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_cliente`
--

CREATE TABLE `auditoria_cliente` (
  `audit_ID` int(11) NOT NULL,
  `cli_ID` int(11) DEFAULT NULL,
  `cli_nom` varchar(100) DEFAULT NULL,
  `cli_dir` varchar(255) DEFAULT NULL,
  `cli_tel` varchar(20) DEFAULT NULL,
  `fecha_insert` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auditoria_cliente`
--

INSERT INTO `auditoria_cliente` (`audit_ID`, `cli_ID`, `cli_nom`, `cli_dir`, `cli_tel`, `fecha_insert`) VALUES
(1, 10, 'Juan Pérez', 'Calle Ficticia 123', '555-123456', '2024-11-19 15:55:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_historial_clinico`
--

CREATE TABLE `auditoria_historial_clinico` (
  `auditoria_id` int(11) NOT NULL,
  `hc_ud` int(11) DEFAULT NULL,
  `aud_fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `aud_operacion` varchar(10) DEFAULT NULL,
  `aud_campo` varchar(50) DEFAULT NULL,
  `aud_valor_anterior` text DEFAULT NULL,
  `aud_valor_nuevo` text DEFAULT NULL,
  `aud_usuario` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_mascota`
--

CREATE TABLE `auditoria_mascota` (
  `aud_ID` int(11) NOT NULL,
  `masct_ID` int(11) DEFAULT NULL,
  `masct_nom_old` varchar(100) DEFAULT NULL,
  `masct_nom_new` varchar(100) DEFAULT NULL,
  `masct_especie_old` varchar(50) DEFAULT NULL,
  `masct_especie_new` varchar(50) DEFAULT NULL,
  `masct_raza_old` varchar(50) DEFAULT NULL,
  `masct_raza_new` varchar(50) DEFAULT NULL,
  `Foto_old` varchar(255) DEFAULT NULL,
  `Foto_new` varchar(255) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auditoria_mascota`
--

INSERT INTO `auditoria_mascota` (`aud_ID`, `masct_ID`, `masct_nom_old`, `masct_nom_new`, `masct_especie_old`, `masct_especie_new`, `masct_raza_old`, `masct_raza_new`, `Foto_old`, `Foto_new`, `fecha`) VALUES
(1, 16, 'Firulais', 'Toby', 'Perro', 'Perro', 'Labrador', 'Labrador', NULL, NULL, '2024-11-19 15:54:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cirugias`
--

CREATE TABLE `cirugias` (
  `cir_id` int(11) NOT NULL,
  `cir_cirugias_previas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cirugias`
--

INSERT INTO `cirugias` (`cir_id`, `cir_cirugias_previas`) VALUES
(1, 'Cirugía de esterilización en 2022'),
(2, 'Cirugía de fractura en la pata trasera'),
(3, 'Cirugía de extracción de tumores en 2021'),
(4, 'Cirugía de hernia inguinal'),
(5, 'Cirugía de cataratas en el ojo izquierdo'),
(6, 'Cirugía para eliminar piedras en la vejiga'),
(7, 'Cirugía de reconstrucción de ligamentos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `cit_ID` int(11) NOT NULL,
  `cit_Mascota_ID` int(11) DEFAULT NULL,
  `cit_fecha` date DEFAULT NULL,
  `cit_motivo` varchar(255) DEFAULT NULL,
  `cit_empleado_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`cit_ID`, `cit_Mascota_ID`, `cit_fecha`, `cit_motivo`, `cit_empleado_ID`) VALUES
(1, 1, '2024-10-02', 'Consulta general', 1),
(2, 2, '2024-10-03', 'Vacunación', 2),
(3, 3, '2024-10-04', 'Tratamiento de urgencias', 3),
(4, 4, '2024-10-05', 'Chequeo anual', 4),
(5, 5, '2024-10-06', 'Tratamiento de parásitos', 5),
(6, 6, '2024-10-07', 'Cirugía menor', 6),
(7, 7, '2024-10-08', 'Consulta dermatológica', 7),
(8, 8, '2024-10-09', 'Urgencia por intoxicación', 8),
(9, 9, '2024-10-10', 'Evaluación post-operatoria', 9);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `citas_empleado`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `citas_empleado` (
`cit_ID` int(11)
,`mascota_nombre` varchar(100)
,`cit_fecha` date
,`cit_motivo` varchar(255)
,`empleado_nombre` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `cli_ID` int(11) NOT NULL,
  `cli_nom` varchar(100) DEFAULT NULL,
  `cli_dir` varchar(255) DEFAULT NULL,
  `cli_tel` varchar(20) DEFAULT NULL,
  `cli_contraseña` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`cli_ID`, `cli_nom`, `cli_dir`, `cli_tel`, `cli_contraseña`) VALUES
(1, 'Juan Pérez', 'Calle Ficticia 123, Ciudad A', '555-12345', 'aB12!@#cde'),
(2, 'María López', 'Avenida del Sol 45, Ciudad B', '555-2345', 'fGh34$%ijK'),
(3, 'Carlos García', 'Calle del Parque 67, Ciudad C', '555-3456', '12Qw!abcZ1'),
(4, 'Lucía Sánchez', 'Calle Principal 89, Ciudad D', '555-4567', 'P@ssw0rD23'),
(5, 'Pedro Martínez', 'Avenida Libertad 101, Ciudad E', '555-5678', 'zX!987WqRt'),
(6, 'Ana Rodríguez', 'Calle del Rio 54, Ciudad F', '555-6789', '876A$z!bcd'),
(7, 'Raúl Fernández', 'Calle San Juan 32, Ciudad G', '555-7890', 'ZyX!0987eT'),
(8, 'Carmen Díaz', 'Avenida 23, Ciudad H', '555-8901', '123Qwer!X'),
(9, 'José Ramírez', 'Calle de la Flor 78, Ciudad I', '555-9012', 'pass$12345'),
(10, 'Juan Pérez', 'Calle Ficticia 123', '555-123456', NULL);

--
-- Disparadores `cliente`
--
DELIMITER $$
CREATE TRIGGER `cliente_insert` AFTER INSERT ON `cliente` FOR EACH ROW BEGIN
    INSERT INTO auditoria_cliente (cli_ID, cli_nom, cli_dir, cli_tel)
    VALUES (NEW.cli_ID, NEW.cli_nom, NEW.cli_dir, NEW.cli_tel);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `clientes_mascotas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `clientes_mascotas` (
`cli_ID` int(11)
,`cli_nom` varchar(100)
,`cli_tel` varchar(20)
,`mascota_nombre` varchar(100)
,`masct_especie` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dieta`
--

CREATE TABLE `dieta` (
  `Diet_id` int(11) NOT NULL,
  `Diet_dieta` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `dieta`
--

INSERT INTO `dieta` (`Diet_id`, `Diet_dieta`) VALUES
(1, 'Dieta balanceada de pollo y arroz'),
(2, 'Dieta alta en proteínas para perros activos'),
(3, 'Comida húmeda de carne y vegetales para gatos adultos'),
(4, 'Comida seca para perros pequeños con alto contenido de fibra'),
(5, 'Dieta para mascotas con intolerancia al gluten'),
(6, 'Comida para perros con problemas renales'),
(7, 'Comida para gatos con sobrepeso y problemas digestivos'),
(8, 'Dieta para control de peso'),
(9, 'Dieta para control de peso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `emple_id` int(11) NOT NULL,
  `emple_nombre` varchar(100) DEFAULT NULL,
  `emple_puesto` varchar(50) DEFAULT NULL,
  `emple_Veterinaria_Id` int(11) DEFAULT NULL,
  `emple_contraseña` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`emple_id`, `emple_nombre`, `emple_puesto`, `emple_Veterinaria_Id`, `emple_contraseña`) VALUES
(1, 'Ana Torres', 'Veterinario', 1, 'mN9!$gFqP'),
(2, 'Luis Martínez', 'Auxiliar Veterinario', 2, 'WpQ@13xyzB'),
(3, 'Sandra Gómez', 'Recepcionista', 3, 'Vt!56N&yMm'),
(4, 'Juan Herrera', 'Veterinario', 4, 'rT7!V78Q@1'),
(5, 'Elena Pérez', 'Auxiliar Veterinario', 5, '2dXmP@9yZa'),
(6, 'Carlos Ruiz', 'Veterinario', 6, 'aB$4g7F!Q1'),
(7, 'María González', 'Recepcionista', 7, 'aZ!91Gh2B'),
(8, 'Pedro López', 'Veterinario', 8, '123P@sswD3'),
(9, 'Lucía Fernández', 'Auxiliar Veterinario', 9, 'Jk78!dPzQ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enfermedades`
--

CREATE TABLE `enfermedades` (
  `enf_id` int(11) NOT NULL,
  `enf_enfermedades` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `enfermedades`
--

INSERT INTO `enfermedades` (`enf_id`, `enf_enfermedades`) VALUES
(1, 'Sin enfermedades previas'),
(2, 'Enfermedad renal crónica'),
(3, 'Alergia a ciertos alimentos'),
(4, 'Problemas articulares debido a la edad'),
(5, 'Leucemia felina'),
(6, 'Parvovirus en perros'),
(7, 'Infección respiratoria crónica'),
(8, 'Enfermedad renal crónica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `esterilizacion`
--

CREATE TABLE `esterilizacion` (
  `est_id` int(11) NOT NULL,
  `est_esterilizado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `esterilizacion`
--

INSERT INTO `esterilizacion` (`est_id`, `est_esterilizado`) VALUES
(1, 1),
(2, 0),
(3, 1),
(4, 1),
(5, 0),
(6, 1),
(7, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_clinico`
--

CREATE TABLE `historial_clinico` (
  `hc_ud` int(11) NOT NULL,
  `hc_fecha` date DEFAULT NULL,
  `hc_Mascota_ID` int(11) DEFAULT NULL,
  `hc_Cirugias_ID` int(11) DEFAULT NULL,
  `hc_Dieta_ID` int(11) DEFAULT NULL,
  `hc_Enfermedades_ID` int(11) DEFAULT NULL,
  `hc_Esterilizacion_ID` int(11) DEFAULT NULL,
  `hc_Tratamiento_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_clinico`
--

INSERT INTO `historial_clinico` (`hc_ud`, `hc_fecha`, `hc_Mascota_ID`, `hc_Cirugias_ID`, `hc_Dieta_ID`, `hc_Enfermedades_ID`, `hc_Esterilizacion_ID`, `hc_Tratamiento_ID`) VALUES
(1, '2024-11-25', 1, 1, 1, 1, 1, 1),
(2, '2024-11-25', 2, 2, 2, 2, 2, 2),
(3, '2024-11-25', 8, 3, 3, 3, 3, 3),
(4, '2024-11-25', 8, 4, 4, 4, 4, 4),
(5, '2024-11-25', 7, 5, 5, 5, 5, 5),
(6, '2024-11-25', 9, 6, 6, 6, 6, 6),
(7, '2024-11-25', 6, 7, 7, 7, 7, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mascota`
--

CREATE TABLE `mascota` (
  `masct_ID` int(11) NOT NULL,
  `masct_Cliente_ID` int(11) DEFAULT NULL,
  `masct_nom` varchar(100) DEFAULT NULL,
  `masct_especie` varchar(50) DEFAULT NULL,
  `masct_raza` varchar(50) DEFAULT NULL,
  `Foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mascota`
--

INSERT INTO `mascota` (`masct_ID`, `masct_Cliente_ID`, `masct_nom`, `masct_especie`, `masct_raza`, `Foto`) VALUES
(1, 1, 'Rex', 'Perro', 'Pastor Alemán', NULL),
(2, 2, 'Miau', 'Gato', 'Siames', NULL),
(3, 3, 'Fido', 'Perro', 'Golden Retriever', NULL),
(4, 4, 'Luna', 'Gato', 'Persa', NULL),
(5, 5, 'Boby', 'Perro', 'Beagle', NULL),
(6, 6, 'Mango', 'Gato', 'Maine Coon', NULL),
(7, 7, 'Rosa', 'Perro', 'Bulldog Francés', NULL),
(8, 8, 'Toby', 'Gato', 'Sphynx', NULL),
(9, 9, 'Max', 'Perro', 'Chihuahua', NULL),
(14, 2, 'Fido', 'Perro', 'Pastor Aleman', NULL),
(15, 1, 'Miau', 'Gato', 'Criollo', NULL),
(16, 1, 'Toby', 'Perro', 'Labrador', NULL);

--
-- Disparadores `mascota`
--
DELIMITER $$
CREATE TRIGGER `mascota_update` AFTER UPDATE ON `mascota` FOR EACH ROW BEGIN
    -- Insertar el registro en la tabla de auditoría
    INSERT INTO auditoria_mascota (
        masct_ID, 
        masct_nom_old, masct_nom_new,
        masct_especie_old, masct_especie_new,
        masct_raza_old, masct_raza_new,
        Foto_old, Foto_new,
        fecha
    )
    VALUES (
        OLD.masct_ID, 
        OLD.masct_nom, NEW.masct_nom,
        OLD.masct_especie, NEW.masct_especie,
        OLD.masct_raza, NEW.masct_raza,
        OLD.Foto, NEW.Foto,
        CURRENT_TIMESTAMP
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `peluqueria_serv`
--

CREATE TABLE `peluqueria_serv` (
  `peluq_ID` int(11) NOT NULL,
  `peluq_Veterinaria_ID` int(11) DEFAULT NULL,
  `peluq_servicios` text DEFAULT NULL,
  `peluq_precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `peluqueria_serv`
--

INSERT INTO `peluqueria_serv` (`peluq_ID`, `peluq_Veterinaria_ID`, `peluq_servicios`, `peluq_precio`) VALUES
(1, 1, 'Corte de pelo para perros', 30.00),
(2, 2, 'Baño y corte para gatos', 25.00),
(3, 3, 'Corte de uñas para perros', 15.00),
(4, 4, 'Corte de pelo para razas pequeñas', 20.00),
(5, 5, 'Tratamiento anti pulgas y baño', 40.00),
(6, 6, 'Corte de pelo para gatos', 28.00),
(7, 7, 'Corte y baño para perros grandes', 35.00),
(8, 8, 'Baño para razas pequeñas', 18.00),
(9, 9, 'Corte y baño para gatos', 22.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `prod_ID` int(11) NOT NULL,
  `prod_nom` varchar(100) DEFAULT NULL,
  `prod_prec` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`prod_ID`, `prod_nom`, `prod_prec`) VALUES
(1, 'Alimento para perros', 15.50),
(2, 'Medicamento para gatos', 8.99),
(3, 'Collares para mascotas', 12.30),
(4, 'Peluche para perros', 6.75),
(5, 'Shampoo para mascotas', 5.50),
(6, 'Antipulgas', 20.00),
(7, 'Comida húmeda para gatos', 3.80),
(8, 'Rascador para gatos', 22.90),
(9, 'Juguetes interactivos para perros', 18.40);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recibo`
--

CREATE TABLE `recibo` (
  `rec_ID` int(11) NOT NULL,
  `rec_Cliente_ID` int(11) DEFAULT NULL,
  `rec_fecha_emision` date DEFAULT NULL,
  `rec_monto` decimal(10,2) DEFAULT NULL,
  `rec_Producto_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `recibo`
--

INSERT INTO `recibo` (`rec_ID`, `rec_Cliente_ID`, `rec_fecha_emision`, `rec_monto`, `rec_Producto_ID`) VALUES
(1, 1, '2024-10-01', 50.00, 6),
(2, 2, '2024-10-02', 80.00, 3),
(3, 3, '2024-10-03', 45.00, 9),
(4, 4, '2024-10-04', 120.00, 2),
(5, 5, '2024-10-05', 60.00, 7),
(6, 6, '2024-10-06', 75.00, 1),
(7, 7, '2024-10-07', 55.00, 4),
(8, 8, '2024-10-08', 90.00, 8),
(9, 9, '2024-10-09', 110.00, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamiento`
--

CREATE TABLE `tratamiento` (
  `tr_id` int(11) NOT NULL,
  `tr_tipo_tratamiento` varchar(255) DEFAULT NULL,
  `tr_medicamentos` text DEFAULT NULL,
  `tr_dosis` varchar(255) DEFAULT NULL,
  `tr_fecha_inicio` date DEFAULT NULL,
  `tr_fecha_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tratamiento`
--

INSERT INTO `tratamiento` (`tr_id`, `tr_tipo_tratamiento`, `tr_medicamentos`, `tr_dosis`, `tr_fecha_inicio`, `tr_fecha_fin`) VALUES
(1, 'Medicamento', 'Amoxicilina', '1 pastilla diaria', '2024-01-01', '2024-01-07'),
(2, 'Terapia', 'Fisioterapia para la cadera', '1 sesión diaria', '2024-02-01', '2024-02-14'),
(3, 'Medicamento', 'Ibuprofeno', '1/2 pastilla diaria', '2024-03-01', '2024-03-10'),
(4, 'Cirugía', 'Cirugía de fractura de pierna', 'N/A', '2024-04-01', '2024-04-01'),
(5, 'Medicamento', 'Antibiótico', '2 pastillas al día', '2024-05-01', '2024-05-07'),
(6, 'Tratamiento para parásitos', 'Pipeta antiparásitos', '1 aplicación cada mes', '2024-06-01', '2024-06-30'),
(7, 'Terapia', 'Terapia de rehabilitación post-cirugía', '1 sesión diaria', '2024-07-01', '2024-07-10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `veterinaria`
--

CREATE TABLE `veterinaria` (
  `vet_ID` int(11) NOT NULL,
  `vet_nombre` varchar(100) DEFAULT NULL,
  `vet_direccion` varchar(255) DEFAULT NULL,
  `vet_contraseña` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `veterinaria`
--

INSERT INTO `veterinaria` (`vet_ID`, `vet_nombre`, `vet_direccion`, `vet_contraseña`) VALUES
(1, 'Vet Clínica 1', 'Calle Ficticia 123, Ciudad A', 'S5$MvYd9H'),
(2, 'Vet Animal Care', 'Avenida del Sol 45, Ciudad B', 'oX1!pQ34Fs'),
(3, 'Clínica Veterinaria San Pedro', 'Calle del Parque 67, Ciudad C', 'D1@wQzx25V'),
(4, 'Vet Salud Animal', 'Calle Principal 89, Ciudad D', 'VtXz$33Ab'),
(5, 'Clínica Veterinaria Los Reyes', 'Avenida Libertad 101, Ciudad E', 'oP#nK7ZqS'),
(6, 'Centro Veterinario El Buen Amigo', 'Calle del Rio 54, Ciudad F', 'mNb6@YwT8'),
(7, 'Veterinaria de la Paz', 'Calle San Juan 32, Ciudad G', 'vX3!dVs56'),
(8, 'Vet Mundo Animal', 'Avenida 23, Ciudad H', 'YqG$2Xy1F'),
(9, 'Veterinaria San Martín', 'Calle de la Flor 78, Ciudad I', 'aB1!QwM9T');

-- --------------------------------------------------------

--
-- Estructura para la vista `citas_empleado`
--
DROP TABLE IF EXISTS `citas_empleado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `citas_empleado`  AS SELECT `cit`.`cit_ID` AS `cit_ID`, `masct`.`masct_nom` AS `mascota_nombre`, `cit`.`cit_fecha` AS `cit_fecha`, `cit`.`cit_motivo` AS `cit_motivo`, `emp`.`emple_nombre` AS `empleado_nombre` FROM ((`cita` `cit` join `mascota` `masct` on(`cit`.`cit_Mascota_ID` = `masct`.`masct_ID`)) join `empleado` `emp` on(`cit`.`cit_empleado_ID` = `emp`.`emple_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `clientes_mascotas`
--
DROP TABLE IF EXISTS `clientes_mascotas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `clientes_mascotas`  AS SELECT `cli`.`cli_ID` AS `cli_ID`, `cli`.`cli_nom` AS `cli_nom`, `cli`.`cli_tel` AS `cli_tel`, `masct`.`masct_nom` AS `mascota_nombre`, `masct`.`masct_especie` AS `masct_especie` FROM (`cliente` `cli` join `mascota` `masct` on(`cli`.`cli_ID` = `masct`.`masct_Cliente_ID`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `adopcion`
--
ALTER TABLE `adopcion`
  ADD PRIMARY KEY (`adop_ID`),
  ADD KEY `adop_Mascota_ID` (`adop_Mascota_ID`);

--
-- Indices de la tabla `auditoria_cliente`
--
ALTER TABLE `auditoria_cliente`
  ADD PRIMARY KEY (`audit_ID`);

--
-- Indices de la tabla `auditoria_historial_clinico`
--
ALTER TABLE `auditoria_historial_clinico`
  ADD PRIMARY KEY (`auditoria_id`);

--
-- Indices de la tabla `auditoria_mascota`
--
ALTER TABLE `auditoria_mascota`
  ADD PRIMARY KEY (`aud_ID`);

--
-- Indices de la tabla `cirugias`
--
ALTER TABLE `cirugias`
  ADD PRIMARY KEY (`cir_id`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`cit_ID`),
  ADD KEY `cit_Mascota_ID` (`cit_Mascota_ID`),
  ADD KEY `cit_empleado_ID` (`cit_empleado_ID`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cli_ID`),
  ADD KEY `idx_cliente_nombre` (`cli_nom`),
  ADD KEY `cliente_nom` (`cli_nom`);

--
-- Indices de la tabla `dieta`
--
ALTER TABLE `dieta`
  ADD PRIMARY KEY (`Diet_id`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`emple_id`),
  ADD KEY `emple_Veterinaria_Id` (`emple_Veterinaria_Id`);

--
-- Indices de la tabla `enfermedades`
--
ALTER TABLE `enfermedades`
  ADD PRIMARY KEY (`enf_id`);

--
-- Indices de la tabla `esterilizacion`
--
ALTER TABLE `esterilizacion`
  ADD PRIMARY KEY (`est_id`);

--
-- Indices de la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  ADD PRIMARY KEY (`hc_ud`),
  ADD KEY `fk_mascota` (`hc_Mascota_ID`),
  ADD KEY `fk_cirugia` (`hc_Cirugias_ID`),
  ADD KEY `fk_dieta` (`hc_Dieta_ID`),
  ADD KEY `fk_enfermedades` (`hc_Enfermedades_ID`),
  ADD KEY `fk_esterilizacion` (`hc_Esterilizacion_ID`),
  ADD KEY `fk_tratamiento` (`hc_Tratamiento_ID`);

--
-- Indices de la tabla `mascota`
--
ALTER TABLE `mascota`
  ADD PRIMARY KEY (`masct_ID`),
  ADD KEY `mascota_cliente_id` (`masct_Cliente_ID`),
  ADD KEY `idx_cliente_nom_especie` (`masct_Cliente_ID`,`masct_nom`,`masct_especie`);

--
-- Indices de la tabla `peluqueria_serv`
--
ALTER TABLE `peluqueria_serv`
  ADD PRIMARY KEY (`peluq_ID`),
  ADD KEY `peluq_Veterinaria_ID` (`peluq_Veterinaria_ID`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`prod_ID`);

--
-- Indices de la tabla `recibo`
--
ALTER TABLE `recibo`
  ADD PRIMARY KEY (`rec_ID`),
  ADD KEY `rec_Cliente_ID` (`rec_Cliente_ID`),
  ADD KEY `FK_rec_Producto_ID` (`rec_Producto_ID`);

--
-- Indices de la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  ADD PRIMARY KEY (`tr_id`);

--
-- Indices de la tabla `veterinaria`
--
ALTER TABLE `veterinaria`
  ADD PRIMARY KEY (`vet_ID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `adopcion`
--
ALTER TABLE `adopcion`
  MODIFY `adop_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `auditoria_cliente`
--
ALTER TABLE `auditoria_cliente`
  MODIFY `audit_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `auditoria_historial_clinico`
--
ALTER TABLE `auditoria_historial_clinico`
  MODIFY `auditoria_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auditoria_mascota`
--
ALTER TABLE `auditoria_mascota`
  MODIFY `aud_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cirugias`
--
ALTER TABLE `cirugias`
  MODIFY `cir_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `cit_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `cli_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `dieta`
--
ALTER TABLE `dieta`
  MODIFY `Diet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `emple_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `enfermedades`
--
ALTER TABLE `enfermedades`
  MODIFY `enf_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `esterilizacion`
--
ALTER TABLE `esterilizacion`
  MODIFY `est_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  MODIFY `hc_ud` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `mascota`
--
ALTER TABLE `mascota`
  MODIFY `masct_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `peluqueria_serv`
--
ALTER TABLE `peluqueria_serv`
  MODIFY `peluq_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `prod_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `recibo`
--
ALTER TABLE `recibo`
  MODIFY `rec_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  MODIFY `tr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `veterinaria`
--
ALTER TABLE `veterinaria`
  MODIFY `vet_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `adopcion`
--
ALTER TABLE `adopcion`
  ADD CONSTRAINT `adopcion_ibfk_1` FOREIGN KEY (`adop_Mascota_ID`) REFERENCES `mascota` (`masct_ID`);

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`cit_Mascota_ID`) REFERENCES `mascota` (`masct_ID`),
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`cit_empleado_ID`) REFERENCES `empleado` (`emple_id`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`emple_Veterinaria_Id`) REFERENCES `veterinaria` (`vet_ID`);

--
-- Filtros para la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  ADD CONSTRAINT `fk_cirugia` FOREIGN KEY (`hc_Cirugias_ID`) REFERENCES `cirugias` (`cir_id`),
  ADD CONSTRAINT `fk_dieta` FOREIGN KEY (`hc_Dieta_ID`) REFERENCES `dieta` (`Diet_id`),
  ADD CONSTRAINT `fk_enfermedades` FOREIGN KEY (`hc_Enfermedades_ID`) REFERENCES `enfermedades` (`enf_id`),
  ADD CONSTRAINT `fk_esterilizacion` FOREIGN KEY (`hc_Esterilizacion_ID`) REFERENCES `esterilizacion` (`est_id`),
  ADD CONSTRAINT `fk_mascota` FOREIGN KEY (`hc_Mascota_ID`) REFERENCES `mascota` (`masct_ID`),
  ADD CONSTRAINT `fk_tratamiento` FOREIGN KEY (`hc_Tratamiento_ID`) REFERENCES `tratamiento` (`tr_id`);

--
-- Filtros para la tabla `mascota`
--
ALTER TABLE `mascota`
  ADD CONSTRAINT `mascota_ibfk_1` FOREIGN KEY (`masct_Cliente_ID`) REFERENCES `cliente` (`cli_ID`);

--
-- Filtros para la tabla `peluqueria_serv`
--
ALTER TABLE `peluqueria_serv`
  ADD CONSTRAINT `peluqueria_serv_ibfk_1` FOREIGN KEY (`peluq_Veterinaria_ID`) REFERENCES `veterinaria` (`vet_ID`);

--
-- Filtros para la tabla `recibo`
--
ALTER TABLE `recibo`
  ADD CONSTRAINT `FK_rec_Producto_ID` FOREIGN KEY (`rec_Producto_ID`) REFERENCES `producto` (`prod_ID`),
  ADD CONSTRAINT `recibo_ibfk_1` FOREIGN KEY (`rec_Cliente_ID`) REFERENCES `cliente` (`cli_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
