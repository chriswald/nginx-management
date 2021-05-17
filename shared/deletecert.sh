#!/bin/bash

hostname=$1

if [ -d /etc/letsencrypt/live/$hostname ]
then
	certbot delete --cert-name $hostname
fi
