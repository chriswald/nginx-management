#!/bin/bash

rootFolder=$1

if [ -z $rootFolder ]
then
        read -p "Root folder: /var/www/" rootFolder
fi

if [ -L /etc/nginx/sites-enabled/$rootFolder.conf ]
then
	rm /etc/nginx/sites-enabled/$rootFolder.conf
	systemctl reload nginx
	echo "Removed /etc/nginx/sites-enabled/$rootFolder.conf"
else
	echo "*** Site not enabled. ***"
fi
