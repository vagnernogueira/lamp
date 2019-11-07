#!/bin/sh
apt-get update
apt-get upgrade -y
apt-get install vim wget net-tools mlocate git unzip -y
apt-get install ca-certificates apt-transport-https -y
apt-get install apache2 apache2-utils -y
apt-get install php libapache2-mod-php -y
apt-get install php-mysql -y
apt-get install php-curl php-gd php-pear php-imagick -y
apt-get install php-mbstring php-zip php-bz2 -y
#
a2enmod rewrite
#
systemctl restart apache2
#
rm -rf /var/www/
ln -s /vagrant/www/ /var/www
chown -R www-data:www-data /var/www
#
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
#
echo "END 01<-"
# vim /etc/php/7.3/apache2/php.ini
# vim /etc/apache2/apache2.conf


# <Directory "/var/www/html"> Change the AllowOverride None directive to AllowOverride All. 

#
apt-get install mariadb-server -y
mysql -u root -t < /vagrant/provision/create_tables.sql
mysql -u root -t < /vagrant/provision/provision.sql
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb.service
#
cd /tmp
wget -q https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-all-languages.zip
unzip -q phpMyAdmin-4.9.1-all-languages.zip -d /opt
mv /opt/phpMyAdmin-4.9.1-all-languages /opt/phpmyadmin
rm -rf /opt/phpmyadmin/setup/
rm -f /opt/phpmyadmin/config.sample.inc.php
cp /vagrant/provision/config.inc.php /opt/phpmyadmin/
chmod 644 /opt/phpmyadmin/config.inc.php
chown -R www-data:www-data /opt/phpmyadmin/
ln -s /vagrant/provision/phpmyadmin.conf /etc/apache2/sites-available/phpmyadmin.conf
a2ensite phpmyadmin.conf
systemctl reload apache2
echo "END 02<-"