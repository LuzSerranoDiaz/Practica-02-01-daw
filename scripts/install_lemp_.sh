#!/bin/bash
 
# Para mostrar los comandos que se van ejecutando
set -ex

# Actualizamos la lista de repositorios
apt update
# ACtualizamos los paquetes del sistema
#apt upgrade -y

#instalacion Nginx
apt install nginx -y

#instalacion php-fpm
apt install php-fpm -y

#Instalamos MYSQL SERVER
apt install mysql-server -y

#instalacion php-mysql
apt install php-mysql -y

#copiamos archivo de configuracion de nginx modificado
cp ../conf/000-default.conf /etc/nginx/sites-available/default

#reiniciar el servicio ngnix
sudo systemctl restart nginx

#configuramos php-fmp
sed -i 's/^listen = \/run\/php\/php8.1-fpm.sock/listen = 127.0.0.1:9000/' /etc/php/8.1/fpm/pool.d/www.conf

#reiniciamos php8.1-fpm
sudo systemctl restart php8.1-fpm

#configuracion de la directiva cgi.fix_pathinfo 
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/8.1/fpm/php.ini

#reiniciamos php8.1-fpm
sudo systemctl restart php8.1-fpm