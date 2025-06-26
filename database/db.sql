        -- Creación de la base de datos y selección de la misma
        CREATE DATABASE IF NOT EXISTS `eventos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
        USE `eventos`;

        -- Tabla de usuarios
        CREATE TABLE IF NOT EXISTS `usuarios` (
            `ID_Usuario` VARCHAR(10) NOT NULL PRIMARY KEY,
            `nombre` VARCHAR(255) NOT NULL,
            `apellido` VARCHAR(255) NOT NULL,
            `correo` VARCHAR(255) NOT NULL UNIQUE,
            `clave` VARCHAR(255) NOT NULL,
            `fecha_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

        -- Disparador para generar el ID_Usuario con el formato 'COD-XXXXX'
        CREATE TRIGGER generar_id_usuario_trigger
        BEFORE INSERT
        ON usuarios
        FOR EACH ROW
        BEGIN
          DECLARE next_val INT;
          SELECT IFNULL(MAX(CAST(SUBSTRING(u.ID_Usuario, 5) AS UNSIGNED)), 0) + 1
          INTO next_val
          FROM usuarios u
          WHERE u.ID_Usuario LIKE 'COD-%';

          IF next_val IS NULL OR next_val = 1 THEN
            SET next_val = 10000;
          END IF;

          SET NEW.ID_Usuario = CONCAT('COD-', LPAD(next_val, 5, '0'));
        END;

        -- Otras tablas de tu base de datos (ejemplo, asegúrate de mantener tus tablas originales)
        CREATE TABLE IF NOT EXISTS `eventos_eliminados` (
            `ID_Evento` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
            `Nombre_Evento` VARCHAR(255) NOT NULL,
            `Descripcion_Evento` VARCHAR(500) NOT NULL,
            `Fecha_Evento` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
            `Lugar_Evento` VARCHAR(200) NOT NULL,
            `Fecha_Eliminacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

        CREATE TABLE IF NOT EXISTS `eventos` (
           `ID_Evento` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
           `Nombre_Evento` VARCHAR(255) NOT NULL,
           `Descripcion_Evento` VARCHAR(500) NOT NULL,
           `Fecha_Evento` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
           `Lugar_Evento` VARCHAR(200) NOT NULL
        );
        