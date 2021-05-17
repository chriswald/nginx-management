#!/bin/bash

scriptDir=$(dirname $0)
hostname=$1
port=$2
outUrl=$3
serverNames=$4

if [ -z $hostname ] || [ -z $port ] || [ -z $outUrl ]
then
	read -p "Hostname: " hostname
	read -p "Inbound port: " port
	read -p "Proxied URL: " outUrl
	read -p "Server names: " serverNames
fi

$scriptDir/../shared/getcert.sh $hostname $serverNames

php $scriptDir/template.php $hostname $port $outUrl $serverNames > /etc/nginx/sites-available/$hostname.conf
echo "Created /etc/nginx/sites-available/$hostname.conf"

$scriptDir/../shared/enablesite.sh $hostname

echo "Test nginx configuration and deploy with"
echo " nginx -t"
echo " systemctl reload nginx"
