# Utiliza una imagen base de PHP con Apache
FROM php:8.2-apache

# Instala la extensión mysqli y pdo_mysql para la conexión a la base de datos MySQL
RUN docker-php-ext-install mysqli pdo_mysql \
    && docker-php-ext-enable mysqli pdo_mysql

# Habilita el módulo Apache mod_rewrite
RUN a2enmod rewrite

# Copia la configuración personalizada de Apache
COPY apache-conf/000-default.conf /etc/apache2/sites-available/000-default.conf

# Habilita la configuración del sitio
RUN a2ensite 000-default.conf

# Habilita display_errors para depuración (desactivar en producción)
RUN echo "display_errors = On" >> /usr/local/etc/php/conf.d/php-custom.ini

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /var/www/html

# Crea el directorio 'logs' y le da permisos de escritura al usuario www-data
RUN mkdir -p /var/www/html/logs && chown -R www-data:www-data /var/www/html/logs
