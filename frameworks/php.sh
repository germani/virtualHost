#!/bin/bash
site_config="server {
    listen 80;
    server_name $PROJECT$DOT_LOCAL www.$PROJECT$DOT_LOCAL;
    root $SITE_DIR/$PROJECT$DOT_COM/www;

    index index.php index.html index.htm;

    location ~ \.php {

        fastcgi_pass  127.0.0.1:9000;
        fastcgi_index index.php;

        include /usr/local/etc/nginx/fastcgi_params;

        fastcgi_split_path_info       ^(.+\.php)(/.+)$;
        fastcgi_param PATH_INFO       \$fastcgi_path_info;
        fastcgi_param PATH_TRANSLATED \$document_root\$fastcgi_path_info;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    error_log /usr/local/etc/nginx/logs/$PROJECT$DOT_COM.error.log;
    access_log /usr/local/etc/nginx/logs/$PROJECT$DOT_COM.access.log;

}";

site_folder='www';