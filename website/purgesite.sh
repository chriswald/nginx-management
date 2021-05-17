#!/bin/bash

scriptDir=$(dirname $0)
rootFolder=$1

if [ -z $rootFolder ]
then
        read -p "Root folder: /var/www/" rootFolder
fi

$scriptDir/../shared/disablesite.sh $rootFolder

rm /etc/nginx/sites-available/$rootFolder.conf
echo "Removed /etc/nginx/sites-available/$rootFolder.conf"

rm -rf /var/www/$rootFolder
echo "Removed /var/www/$rootFolder"

$scriptDir/../shared/deletecert.sh $rootFolder

echo "Test nginx configuration and deploy with"
echo " nginx -t"
echo " systemctl reload nginx"
