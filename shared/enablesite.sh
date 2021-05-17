#!/bin/bash

rootFolder=$1

if [ -z $rootFolder ]
then
        read -p "Root folder: /var/www/" rootFolder
fi

if [ ! -L /etc/nginx/sites-enabled/$rootFolder.conf ] 
then
	ln -s /etc/nginx/sites-available/$rootFolder.conf /etc/nginx/sites-enabled
	systemctl reload nginx
fi

echo "Enabled site"
