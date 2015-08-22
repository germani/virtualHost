#!/bin/bash
site_config="server {

    listen  80;
    server_name $PROJECT$DOT_LOCAL www.$PROJECT$DOT_LOCAL;
    set \$root_path $SITE_DIR/$PROJECT$DOT_COM/public;
    root \$root_path;

    index index.php index.html index.htm;

    try_files \$uri \$uri/ @rewrite;

    location @rewrite {
        rewrite ^/(.*)$ /index.php?_url=/$1;
    }

    location ~ \.php {

        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;

        include fastcgi_params;

        fastcgi_split_path_info       ^(.+\.php)(/.+)$;
        fastcgi_param PATH_INFO       \$fastcgi_path_info;
        fastcgi_param PATH_TRANSLATED \$document_root\$fastcgi_path_info;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    location ~* ^/(css|img|js|flv|swf|download)/(.+)$ {
        root \$root_path;
    }

    location ~ /\.ht {
        deny all;
    }

    error_log logs/$PROJECT$DOT_COM.error.log;
    access_log logs/$PROJECT$DOT_COM.access.log;

}";

site_folder='public';