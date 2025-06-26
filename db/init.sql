-- Asegúrate de estar usando la base de datos correcta.
-- 'eventos' se define en MYSQL_DATABASE en docker-compose.yml
USE eventos;

-- Tabla 'usuarios'
CREATE TABLE IF NOT EXISTS usuarios (
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    nombre VARCHAR(100)
    -- Añade aquí cualquier otra columna que tengas en tu tabla 'usuarios'
);

-- Tabla 'eventos'
CREATE TABLE IF NOT EXISTS eventos (
    ID_Evento INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Evento VARCHAR(255) NOT NULL,
    Descripcion_Evento TEXT,
    Lugar VARCHAR(255),
    Fecha_De_Registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Fecha_Y_Hora DATETIME NOT NULL
);

-- Tabla 'eventos_eliminados'
CREATE TABLE IF NOT EXISTS eventos_eliminados (
    ID_Evento INT PRIMARY KEY,
    Nombre_Evento VARCHAR(255) NOT NULL,
    Descripcion_Evento TEXT,
    Lugar VARCHAR(255),
    Fecha_Y_Hora DATETIME NOT NULL
);

-- Opcional: Inserta un usuario de prueba para poder iniciar sesión
-- ¡IMPORTANTE! La contraseña debe estar hasheada (por ejemplo, con password_hash en PHP)
-- No uses contraseñas en texto plano en un entorno real.
INSERT INTO usuarios (usuario, contrasena, nombre) VALUES ('admin', 'tu_contrasena_hasheada_aqui', 'Administrador')
ON DUPLICATE KEY UPDATE usuario=usuario; -- Evita insertar el mismo usuario si ya existe
