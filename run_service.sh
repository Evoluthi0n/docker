#!/usr/bin/env bash

if [ $1 == "start" ]
then
docker network create project_net

docker run  --rm -d \
			--name dbhost \
			--net project_net  \
			-e MYSQL_ROOT_PASSWORD=12345 \
			-e MYSQL_USER=admin \
			-e MYSQL_PASSWORD=pass123456 \
			mariadb:10.6

docker run  --rm -d \
			--name phpmyadmin \
			--net project_net \
			-e PMA_HOST=dbhost \
			-e PMA_USER=admin \
			-e PMA_PASSWORD=pass123456 \
			-p 8080:80 \
			phpmyadmin:5.2.1
else
	if [ $1 == "stop" ]
	then
		docker stop dbhost
		docker stop phpmyadmin
		docker network remove project_net
	else
		echo Неверный параметр запуска
	fi
fi