#!/bin/bash
site_config="server {
    listen 80;
    server_name $PROJECT$DOT_LOCAL www.$PROJECT$DOT_LOCAL;
    root $SITE_DIR/$PROJECT$DOT_COM/www;

    index index.html index.htm;

    error_log /usr/local/etc/nginx/logs/$PROJECT$DOT_COM.error.log;
    access_log /usr/local/etc/nginx/logs/$PROJECT$DOT_COM.access.log;

}";

site_folder='www';