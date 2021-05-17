#!/bin/bash

scriptDir=$(dirname $0)
hostname=$1

if [ -z $hostname ]
then
	read -p "Hostname: " hostname
fi

$scriptDir/../shared/disablesite.sh $hostname

rm /etc/nginx/sites-available/$hostname.conf
echo "Removed /etc/nginx/sites-available/$hostname.conf"

$scriptDir/../shared/deletecert.sh $hostname

echo "Test nginx configuration and deploy with"
echo " nginx -t"
echo " systemctl reload nginx"
