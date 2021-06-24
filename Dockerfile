FROM php:7.2.10-apache

COPY . /var/www/html

RUN apt-get update -yqq && \
    apt-get install -y nano && \
    apt-get install -y libzip-dev && \
    a2enmod rewrite && \
    docker-php-ext-install mysqli pdo pdo_mysql && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install zip && \
    rm -rf /var/lib/apt/lists/* \
    apt install phpmyadmin php-mbstring php-gettext \
    phpenmod mbstring \
    systemctl restart apache2

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/var/www/html/laravel_app --filename=composer


WORKDIR /var/www/html
RUN chmod +x /var/www/html
RUN chown -R www-data:www-data /var/www/html
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80