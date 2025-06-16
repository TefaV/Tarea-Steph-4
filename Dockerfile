# Usa imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    zip \
    unzip \
    git \
    curl \
    libonig-dev \
    libxml2-dev \
    libsqlite3-dev \
    pkg-config \
    && docker-php-ext-install pdo pdo_sqlite mbstring gd

# Instala Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia el proyecto completo al contenedor
COPY . .

# Asegura permisos para Laravel
RUN chmod -R 777 storage bootstrap/cache

# Instala dependencias con Composer
# ⚠️ Se usa --no-scripts para evitar errores si aún no está configurado el entorno
RUN COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader --no-scripts || true

# Copia .env si no existe
RUN test -f .env || cp .env.example .env

# Genera clave de aplicación (no falla si ya está definida)
RUN php artisan key:generate || true

# Crea base de datos SQLite si no existe
RUN mkdir -p database && touch database/database.sqlite && chmod -R 777 database

# Configura Apache para servir desde /public
RUN echo '<VirtualHost *:80>' > /etc/apache2/sites-available/000-default.conf && \
    echo '    DocumentRoot /var/www/html/public' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    <Directory /var/www/html/public>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        AllowOverride All' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Require all granted' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf

# Habilita mod_rewrite y headers en Apache
RUN a2enmod rewrite headers

# Expone el puerto
EXPOSE 80

# Comando por defecto: inicia Apache
CMD ["apache2-foreground"]
