# Usa imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala dependencias del sistema y extensiones PHP necesarias
RUN apt-get update && apt-get install -y \
    git unzip zip curl \
    libpng-dev libonig-dev libxml2-dev libzip-dev \
    sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite mbstring gd zip

# Instala Node.js y npm (para Vite)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia composer.json para aprovechar caché
COPY composer.json composer.lock* ./

# Instala dependencias PHP
RUN COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader

# Copia todos los archivos del proyecto
COPY . .

# Instala dependencias de JavaScript y compila Vite
RUN npm install && npm run build

# Prepara SQLite y permisos
RUN mkdir -p database && \
    touch database/database.sqlite && \
    chmod -R 777 database database/database.sqlite storage bootstrap/cache

# Copia .env si no existe y genera APP_KEY
RUN cp .env.example .env || true && \
    php artisan key:generate || true

# Configura Apache para servir desde /public
RUN a2enmod rewrite headers && \
    echo '<VirtualHost *:80>' > /etc/apache2/sites-available/000-default.conf && \
    echo '    DocumentRoot /var/www/html/public' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    <Directory /var/www/html/public>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        AllowOverride All' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Require all granted' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf

# Exponer puerto
EXPOSE 80

# Iniciar Apache
CMD ["apache2-foreground"]
