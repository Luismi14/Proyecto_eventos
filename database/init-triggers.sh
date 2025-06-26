#!/bin/bash

# Este script es ejecutado automáticamente por el entrypoint de Docker.
# Espera a que el servicio MySQL esté completamente listo antes de ejecutar comandos.
# Esto asegura que la base de datos 'eventos' ya exista.

echo "Esperando a que la base de datos esté lista..."
until mysql -h db -u eventos1 -ppass -e "SELECT 1" > /dev/null 2>&1; do
  echo "MySQL no está listo, esperando..."
  sleep 1
done
echo "MySQL está listo. Creando el disparador..."

# Ejecuta el script del disparador con el cliente de MySQL.
# El comando 'source' dentro del cliente de MySQL maneja los DELIMITER de forma nativa.
mysql -h db -u eventos1 -ppass eventos < /tmp/triggers.sql

echo "Disparador creado exitosamente."
