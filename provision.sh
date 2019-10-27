#!/bin/sh
apt-get update
apt-get upgrade -y
apt-get install vim wget net-tools mlocate -y
apt-get install ca-certificates apt-transport-https -y
apt-get install apache2 apache2-utils -y
apt-get install php libapache2-mod-php -y
apt-get install php-mysql -y
apt-get install php-curl php-gd php-pear php-imagick -y
#
a2enmod rewrite
chown -R www-data:www-data /var/www
systemctl restart apache2
rm -rf /var/www/
ln -s /vagrant/www/ /var/www
#
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
echo "END <-"
# vim /etc/php/7.3/apache2/php.ini
# vim /etc/apache2/apache2.conf
# <Directory "/var/www/html"> Change the AllowOverride None directive to AllowOverride All. 
