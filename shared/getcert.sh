#!/bin/bash

hostname=$1
serverNames=$2

if [ ! -z $serverNames ]
then
	serverList="$hostname $serverNames"
	serverList=${serverList// /,}
else
	serverList=$hostname
fi

if [ ! -d /etc/letsencrypt/live/$hostname ]
then
	certbot certonly -n -d "$serverList" --nginx
fi
