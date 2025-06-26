<?php
// Incluir la clase de conexión a la base de datos
require_once 'conexion.php';

// Clase para autenticar usuarios
class Auth
{
    protected PDO $conexion;

    public function __construct(Conexion $conexion)
    {
        $this->conexion = $conexion->conectar();
    }

    // Función para verificar si el correo ya existe en la base de datos
    public function verificar_correo(string $correo): bool
    {
        $sqlVerificarCorreo = $this->conexion->prepare('SELECT ID_Usuario, nombre, apellido, correo, clave FROM usuarios WHERE correo = :correo');
        $sqlVerificarCorreo->bindParam(':correo', $correo, PDO::PARAM_STR);
        $sqlVerificarCorreo->execute();
        return $sqlVerificarCorreo->fetch() !== false;
    }

    // Función para registrar un usuario
    public function registrar_usuario($nombre, $apellido, $correo, $clave): bool
    {
        $check_stmt = $this->verificar_correo($correo);

        if ($check_stmt === true) {
            $_SESSION['register_message'] = 2;
            return false;
        } else {
            $clave_encriptada = password_hash($clave, PASSWORD_DEFAULT);

            $stmt = $this->conexion->prepare('INSERT INTO usuarios (nombre, apellido, correo, clave) VALUES (:nombre, :apellido, :correo, :clave_encriptada)');
            $stmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
            $stmt->bindParam(':apellido', $apellido, PDO::PARAM_STR);
            $stmt->bindParam(':correo', $correo, PDO::PARAM_STR);
            $stmt->bindParam(':clave_encriptada', $clave_encriptada, PDO::PARAM_STR);

            if ($stmt->execute()) {
                $_SESSION['register_message'] = 3;
                return true;
            } else {
                $_SESSION['register_message'] = 1;
                return false;
            }
        }
    }

    // Función para logear un usuario
    public function logear_usuario($correo, $clave): bool
    {
        $stmt = $this->conexion->prepare('SELECT * FROM usuarios WHERE correo = :correo');
        $stmt->bindParam(':correo', $correo, PDO::PARAM_STR);
        $stmt->execute();
        $usuario = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($usuario === false || !isset($usuario['clave'])) {
            $_SESSION['login_message'] = 1;
            return false;
        }

        $clave_encriptada = $usuario['clave'];
        if (!password_verify($clave, $clave_encriptada)) {
            $_SESSION['login_message'] = 2;
            return false;
        } else {
            $_SESSION['usuario_id'] = $usuario['ID_Usuario'];
            $_SESSION['nombre'] = $usuario['nombre'];   // CAMBIO: 'Nombre' a 'nombre'
            $_SESSION['apellido'] = $usuario['apellido']; // CAMBIO: 'Apellido' a 'apellido'
            $_SESSION['correo'] = $usuario['correo'];   // CAMBIO: 'Correo' a 'correo'
            $_SESSION['login_message'] = 3;
            return true;
        }
    }

    // Función para eliminar un usuario
    public function eliminar_usuario($correo): bool
    {
        $stmt = $this->conexion->prepare('DELETE FROM usuarios WHERE Correo = :correo');
        $stmt->bindParam(':correo', $correo, PDO::PARAM_STR);
        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }
}
