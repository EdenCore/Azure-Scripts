#!/bin/bash

sudo apt-get update && \

sudo apt-get -y install mariadb-server && \

sudo mysql -e "create user wpadmin identified by 'AzP@ssw0rD22';"

sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpadmin'@'172.16.0.%' identified by 'AzP@ssw0rD22';"

sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('AzP@ssw0rD22') WHERE User = 'root'"

sudo mysql -e "CREATE DATABASE wordpress"

sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO azdebian@172.16.0.0/255.255.255.192 IDENTIFIED BY 'your-root-password';"

sudo mysql -e "FLUSH PRIVILEGES;"