#!/bin/bash
#
#  This script is to automate a common WP setup.
#
#   - Download the latest version of Wordpress
#   - Unzip
#   - Download the latest version of plugin X
#   - Unzip to WP plugins folder
#   - Download theme
#   - Unzip to themes folder

# WordPress Directories used later

# Install PHP repo

sudo apt-get update

sudo apt-get -y install apt-transport-https lsb-release ca-certificates curl

sudo curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg

sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

sudo apt-get update && \

#Install Apache a Php7.4

sudo apt-get install apache2 php7.4 -y && \
sudo apt-get install php7.4-json \
                     php7.4-mysql \
                     php7.4-curl \
                     php7.4-xml \
                     php7.4-mbstring \
                     php7.4-common \
                     php7.4-imagick \
                     php7.4-zip \
                     php7.4-memcache \
                     php7.4-opcache \
                     php7.4-redis \
                     php7.4-ssh2 -y && \

#Download and extract wordpress files

cd /var/www/ && sudo rm -rf * && \

sudo mkdir wordpress && cd wordpress && \

sudo curl -OL "https://fr.wordpress.org/latest-fr_FR.tar.gz" && \

sudo tar -zxf "./latest-fr_FR.tar.gz" --strip-components=1 && \

sudo rm "./latest-fr_FR.tar.gz" && \

sudo chown -R www-data:www-data /var/www/

# Setup Apache server

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wordpress.conf

sudo sed -i s/html/wordpress/ /etc/apache2/sites-available/wordpress.conf

sudo a2dissite 000-default.conf && \

sudo a2ensite wordpress.conf && \

sudo systemctl reload apache2

# Setup wordpress database config

cp wp-config-sample.php wp-config.php

sed -i s/votre_nom_de_bdd/wordpress/ /var/www/wordpress/wp-config.php

sed -i s/votre_utilisateur_de_bdd/wpadmin/ /var/www/wordpress/wp-config.php

sed -i s/localhost/172.17.0.4/ /var/www/wordpress/wp-config.php