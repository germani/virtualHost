#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );
SITE_DIR=/Users/$USER/Sites;
DOT_LOCAL=.local;

echo -e "Введите название проекта (Например example)";
read PROJECT
echo -e "Введите домен первого уровня (Например .com)";
read DOT_COM

echo "создаем nginx конф"
touch /usr/local/etc/nginx/sites-available/$PROJECT$DOT_COM

echo -e "Какой фреймворк используете? [symfony, laravel, html, php] : ";
read FW
if [ -f $DIR/frameworks/$FW.sh ]; then
    source $DIR/frameworks/$FW.sh;
else 
    source $DIR/frameworks/php.sh;
fi

#создаем папки проекта
sudo mkdir $SITE_DIR
sudo mkdir $SITE_DIR/$PROJECT$DOT_COM
sudo mkdir $SITE_DIR/$PROJECT$DOT_COM/$site_folder/

#указываем владельца и права на папку "public"
sudo chown -R $USER:staff $SITE_DIR/$PROJECT$DOT_COM/
sudo chown -R $USER:staff $SITE_DIR/$PROJECT$DOT_COM/$site_folder/

echo "Созданы папки:"
echo $SITE_DIR/$PROJECT$DOT_COM/
echo $SITE_DIR/$PROJECT$DOT_COM/$site_folder/

# Создаем страничку в public для того чтобы сайт хоть что-то отражал
cp -r $DIR/template/$FW.html $SITE_DIR/$PROJECT$DOT_COM/$site_folder/index.html
cp -r $DIR/template/index.php $SITE_DIR/$PROJECT$DOT_COM/$site_folder/index.php

sudo chown -R $USER:staff $SITE_DIR/$PROJECT$DOT_COM/$site_folder/index.html
sudo chown -R $USER:staff $SITE_DIR/$PROJECT$DOT_COM/$site_folder/index.php


echo "$site_config" >> /usr/local/etc/nginx/sites-available/$PROJECT$DOT_COM;
ln -sfv /usr/local/etc/nginx/sites-available/$PROJECT$DOT_COM /usr/local/etc/nginx/sites-enabled/$PROJECT$DOT_COM

#добавляем в /etc/hosts
sudo sh -c "echo 127.0.0.1      $PROJECT$DOT_LOCAL >> /etc/hosts"
dscacheutil -flushcache

echo "Рестар Nginx"
# Рестар Nginx
sudo nginx -s reload




echo "***********************************"
echo "** Запомните следующие данные : **"
echo "***********************************"
echo "** "
echo "** Ваш сайт нужно разместить в этот каталог: $SITE_DIR/$PROJECT$DOT_LOCAL/www"
echo "** "
echo "** После открыть в браузере адрес http://$PROJECT$DOT_LOCAL"
echo "** "
echo "** "
echo "***********************************"
echo "***********************************"

