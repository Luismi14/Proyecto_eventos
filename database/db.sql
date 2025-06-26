-- Este script se ejecuta automáticamente al iniciar el contenedor MySQL si el volumen de datos está vacío.
-- La base de datos 'eventos' ya es creada por Docker Compose (MYSQL_DATABASE).
USE eventos;

-- Tabla 'usuarios'
CREATE TABLE IF NOT EXISTS `usuarios` (
    `ID_Usuario` VARCHAR(10) NOT NULL PRIMARY KEY,
    `usuario` VARCHAR(255) NOT NULL UNIQUE,
    `nombre` VARCHAR(255) NOT NULL,
    `apellido` VARCHAR(255) NOT NULL,
    `correo` VARCHAR(255) NOT NULL UNIQUE,
    `clave` VARCHAR(255) NOT NULL,
    `fecha_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla 'eventos'
CREATE TABLE IF NOT EXISTS `eventos` (
   `ID_Evento` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   `Nombre_Evento` VARCHAR(255) NOT NULL,
   `Descripcion_Evento` TEXT NOT NULL,
   `Lugar` VARCHAR(255) NOT NULL,
   `Fecha_De_Registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   `Fecha_Y_Hora` DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla 'eventos_eliminados'
CREATE TABLE IF NOT EXISTS `eventos_eliminados` (
    `ID_Evento` INT PRIMARY KEY,
    `Nombre_Evento` VARCHAR(255) NOT NULL,
    `Descripcion_Evento` TEXT NOT NULL,
    `Lugar` VARCHAR(255) NOT NULL,
    `Fecha_Y_Hora` DATETIME NOT NULL,
    `Fecha_Eliminacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Opcional: Inserta un usuario de prueba para poder iniciar sesión
-- ¡IMPORTANTE! La contraseña debe estar hasheada (ej. con password_hash en PHP)
INSERT INTO usuarios (ID_Usuario, usuario, contrasena, nombre, apellido, correo)
VALUES ('COD-00001', 'admin', 'tu_contrasena_hasheada_aqui', 'Administrador', 'General', 'admin@example.com')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);
