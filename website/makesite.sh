#!/bin/bash

scriptDir=$(dirname $0)
rootFolder=$1
port=$2
serverNames=$3

if [ -z $rootFolder ] || [ -z $port ]
then
	read -p "Root folder: /var/www/" rootFolder
	read -p "Port: " port
	read -p "Server name: " serverNames
fi

$scriptDir/../shared/getcert.sh $rootFolder $serverNames

if [ ! -d /var/www/$rootFolder ] 
then
	mkdir /var/www/$rootFolder
	echo "Created directory /var/www/$rootFolder"
fi

php $scriptDir/template.php $rootFolder $port "$serverNames" > /etc/nginx/sites-available/$rootFolder.conf
echo "Created /etc/nginx/sites-available/$rootFolder.conf"

$scriptDir/../shared/enablesite.sh $rootFolder

echo "Test nginx configuration and deploy with"
echo " nginx -t"
echo " systemctl reload nginx"
