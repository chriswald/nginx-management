<?php
	$rootFolder = (string)$argv[1];
	$port = (string)$argv[2];
	$serverNames = "";

	if ($argc === 4)
	{
		$serverNames = (string)$argv[3];
		$serverNames = str_replace(",", " ", $serverNames);
	}
?>

server {
	listen          <?php echo $port; ?> ssl http2;
	listen          [::]:<?php echo $port; ?> ssl http2;
	root            /var/www/<?php echo $rootFolder?>;
	index           index.php index.html;
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
		try_files $uri.html $uri $uri/ @rewrite;
	}

	location @rewrite {
		if ( -f $document_root$uri.php) { rewrite ^ $uri.php last; }
		return 404;
	}

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php-fpm.sock;
	}

	location ~ /\.ht {
		deny all;
	}

	location ~ /.git {
                deny all;
                return 404;
	}

	location ~ /hidden {
		deny all;
		return 404;
	}

	gzip on;
	gzip_types application/javascript image/* text/css text/plain;
	gunzip on;
}

