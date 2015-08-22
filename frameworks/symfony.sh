#!/bin/bash
site_config="server {
	listen 80;
    server_name $PROJECT$DOT_LOCAL www.$PROJECT$DOT_LOCAL;
    root $SITE_DIR/$PROJECT$DOT_COM/web;

    location / {
        # try to serve file directly, fallback to app.php
        try_files $uri /app.php$is_args$args;
    }
    # DEV
    # This rule should only be placed on your development environment
    # In production, don't include this and don't deploy app_dev.php or config.php
    location ~ ^/(app_dev|config)\.php(/|$) {
        fastcgi_pass  127.0.0.1:9000;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
    # PROD
    location ~ ^/app\.php(/|$) {
        fastcgi_pass  127.0.0.1:9000;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        # Prevents URIs that include the front controller. This will 404:
        # http://domain.tld/app.php/some-path
        # Remove the internal directive to allow URIs like this
        internal;
    }

    error_log /usr/local/etc/nginx/logs/$PROJECT$DOT_COM.error.log;
    access_log /usr/local/etc/nginx/logs/$PROJECT$DOT_COM.access.log;
}";
site_folder='web';