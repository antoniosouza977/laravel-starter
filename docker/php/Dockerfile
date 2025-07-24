FROM php:8.4-fpm

ARG UNAME=user
ARG UID=1000
ARG GID=1000

RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    aspell \
    aspell-en \
    && docker-php-ext-install zip pdo_mysql pcntl

RUN docker-php-ext-configure pcntl --enable-pcntl
RUN apt install libicu-dev -y
RUN docker-php-ext-install intl
RUN docker-php-ext-enable intl
RUN pecl install xdebug pcov \
    && docker-php-ext-enable xdebug

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN groupadd -g $GID -o $UNAME
RUN useradd -u $UID -g $UNAME -o -m $UNAME

USER $UNAME

WORKDIR /var/www

RUN composer global require laravel/installer

ENV PATH="/home/$UNAME/.composer/vendor/bin:$PATH"

COPY --chown=$UNAME:$UNAME ./docker/scripts/install-app.sh /usr/local/bin/install-app
COPY --chown=$UNAME:$UNAME ./docker/php/xdebug.ini /etc/php/8.4/mods-available/xdebug.ini

RUN chmod +x /usr/local/bin/install-app

EXPOSE 9000

CMD ["/usr/local/bin/install-app"]
