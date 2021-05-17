<?php
	$rootFolder = (string)$argv[1];
	$inPort = (string)$argv[2];
	$outUrl = (string)$argv[3];
	$serverNames = "";

	if ($argc === 5)
	{
		$serverNames = (string)$argv[4];
		$serverNames = str_replace(",", " ", $serverNames);
	}
?>

server {
	<?php
	$ports = explode(",", $inPort);
	foreach ($ports as $port)
	{
		echo "listen\t\t$port ssl http2;";
		echo "listen\t\t[::]:$port ssl http2;";
	}
	?>

	<?php
	if (strlen($serverNames) !== 0)
	{
		echo "server_name\t$serverNames;";
	}?>

	ssl_certificate /etc/letsencrypt/live/<?php echo $rootFolder; ?>/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/<?php echo $rootFolder; ?>/privkey.pem;
	add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
	add_header Permissions-Policy interest-cohort=();

	location / {
		proxy_pass <?php echo $outUrl; ?>;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection "upgrade";
	}
}

