-- Este script se ejecuta automáticamente al iniciar el contenedor MySQL si el volumen de datos está vacío.
-- La base de datos 'eventos' ya es creada por Docker Compose (MYSQL_DATABASE).
USE eventos;

-- Tabla 'usuarios'
-- Asegúrate de que el nombre de la columna 'ID_Usuario' coincida con tu código PHP.
-- Si en tu phpMyAdmin se muestra 'ID.Usuario', es un error de visualización o de cómo se creó.
-- Lo estándar y recomendado es 'ID_Usuario'.
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
-- **IMPORTANTE: El nombre de la columna de fecha/hora debe ser 'Fecha_Y_Hora' para coincidir con tu PHP.**
CREATE TABLE IF NOT EXISTS `eventos` (
   `ID_Evento` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   `Nombre_Evento` VARCHAR(255) NOT NULL,
   `Descripcion_Evento` TEXT NOT NULL, -- Cambiado a TEXT para descripciones más largas
   `Lugar` VARCHAR(255) NOT NULL, -- Cambiado a 'Lugar' para coincidir con tu PHP
   `Fecha_De_Registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   `Fecha_Y_Hora` DATETIME NOT NULL -- **Nombre de columna corregido para coincidir con PHP**
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla 'eventos_eliminados'
-- **IMPORTANTE: 'ID_Evento' no debe ser AUTO_INCREMENT aquí.**
-- **IMPORTANTE: Los nombres de las columnas deben coincidir con 'eventos' y tu PHP.**
CREATE TABLE IF NOT EXISTS `eventos_eliminados` (
    `ID_Evento` INT PRIMARY KEY, -- No AUTO_INCREMENT
    `Nombre_Evento` VARCHAR(255) NOT NULL,
    `Descripcion_Evento` TEXT NOT NULL, -- Cambiado a TEXT
    `Lugar` VARCHAR(255) NOT NULL, -- Cambiado a 'Lugar'
    `Fecha_Y_Hora` DATETIME NOT NULL, -- **Nombre de columna corregido para coincidir con PHP**
    `Fecha_Eliminacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Opcional: Inserta un usuario de prueba para poder iniciar sesión
-- ¡IMPORTANTE! La contraseña debe estar hasheada (ej. con password_hash en PHP)
-- No uses contraseñas en texto plano en un entorno de producción.
-- Si ya tienes un usuario 'admin', esto lo actualizará.
INSERT INTO usuarios (ID_Usuario, usuario, contrasena, nombre, apellido, correo)
VALUES ('COD-00001', 'admin', 'tu_contrasena_hasheada_aqui', 'Administrador', 'General', 'admin@example.com')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre); -- Actualiza si el ID_Usuario ya existe
