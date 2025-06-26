<?php
/**
 * FILEPATH: /c:/Xampp/htdocs/eventos/clases/conexion.php
 *
 * Este archivo contiene la clase Conexion y constantes para conectarse a una base de datos MySQL.
 *
 * @package Conexion
 */

// --- MODIFICACIONES PARA DOCKER COMPOSE ---
// La dirección del servidor es el nombre del servicio de la base de datos en docker-compose.yml
const DB_HOST = 'db'; // Usamos 'db' porque así se llama el servicio en el archivo YAML
const DB_NAME = 'eventos'; // El nombre de la base de datos que definiste en docker-compose.yml
const DB_PORT = '3306'; // El puerto estándar de MySQL
const DB_USER = 'eventos1'; // El usuario que configuraste en docker-compose.yml
const DB_PASS = 'pass'; // La contraseña que configuraste en docker-compose.yml
// ------------------------------------------

/**
 * La clase Conexion contiene métodos para conectarse a una base de datos MySQL.
 *
 * @class Conexion
 */
class Conexion
{
    /**
     * El atributo privado $conexion contiene la conexión a la base de datos.
     *
     * @var PDO
     * @access private
     */
    private PDO $conexion; // private: solo se puede acceder desde la misma clase

    /**
     * El método conectar() se conecta a la base de datos y devuelve la conexión.
     *
     * @method conectar
     * @return PDO La conexión a la base de datos.
     */
    public function conectar(): PDO // public: se puede acceder desde cualquier clase
    {
        try { // try: intenta ejecutar el código, si hay error, se ejecuta el catch
            $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';port=' . DB_PORT;
            $this->conexion = new PDO($dsn, DB_USER, DB_PASS);

            // Configura el atributo ERRMODE_EXCEPTION para manejar excepciones
            $this->conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            return $this->conexion; // Devuelve la conexión
        } catch (PDOException $e) { // catch: captura el error
            echo 'Error al conectar a la base de datos: ' . $e->getMessage(); // getMessage(): devuelve el mensaje de error
            exit(); // Termina la ejecución del script
        }
    }
}