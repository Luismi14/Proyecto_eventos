<?php
// En /servidor/dirs.php

// Define la ruta a la carpeta 'clases'.
// '__DIR__' obtiene el directorio del archivo actual (servidor/),
// y '../' sube un nivel para llegar a la raíz del proyecto,
// luego añade 'clases/'.
define('CLASS_PATH', __DIR__ . '/../clases/');

// Define la ruta a la carpeta 'servidor'.
// '__DIR__' es el directorio actual (servidor/).
define('SERVER_PATH', __DIR__ . '/');

// Puedes añadir otras rutas si las tienes
// define('TEMPLATES_PATH', __DIR__ . '/../templates/');
?>
