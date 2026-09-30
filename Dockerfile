FROM php:8.2-apache

# Installasi dependencies Winter CMS
RUN apt-get update && apt-get install -y git unzip libzip-dev default-mysql-client \
    && docker-php-ext-install pdo_mysql zip

# mod_rewrite
RUN a2enmod rewrite

# Installasi Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Menjalankan instalasi Winter CMS
RUN rm -rf /var/www/html/* \
    && composer create-project wintercms/winter /var/www/html

# Mengatur permission agar bisa diakses web server
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html