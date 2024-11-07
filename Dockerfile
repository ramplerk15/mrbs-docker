# Use PHP with Apache
FROM php:7.4-apache

# Install required PHP extensions
RUN docker-php-ext-install mysqli

# Copy MRBS files to the web directory
COPY ./mrbs-1.11.6 /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Configure Apache to use the correct DocumentRoot
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/web|' /etc/apache2/sites-available/000-default.conf

# Install locales and configure en_GB.UTF-8
RUN apt-get update && apt-get install -y locales \
    && sed -i '/en_GB.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen en_GB.UTF-8

# Check Apache Configuration
#RUN echo '<Directory "/var/www/html"> Options Indexes FollowSymLinks AllowOverride All Require all granted </Directory>' > /etc/apache2/conf-enabled/mrbs.conf

# Set ServerName to localhost to suppress the warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Set the timezone
ENV TZ="Europe/Vienna"

# Install the pdo_mysql extension to enable PHP to connect to MySQL databases using PDO
RUN docker-php-ext-install pdo_mysql

