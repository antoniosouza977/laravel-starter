#!/bin/bash
composerJson=./composer.json

if [ -f "$composerJson" ]; then
  echo "Instalando dependencias.."
  composer install --no-interaction --no-plugins --no-scripts --prefer-dist

  chmod 777 -R /var/www/storage /var/www/bootstrap

  php artisan key:generate
  php artisan migrate
  php artisan db:seed

  exec php-fpm
fi
