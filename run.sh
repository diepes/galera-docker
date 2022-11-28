#!/usr/bin/env bash
docker build . -t galera

# mkdir /srv/galera/node{1,2,3}
# chown 999:999 /srv/galera/node{1,2,3}

#Echo start 1st galera(mariadb) node
	#-v /srv/galera/node1:/var/lib/mysql \
docker run -d --rm \
	--name node1 -h node1 --ip 172.17.0.101 \
	-p 3311:3306 \
	-v $PWD/configs/galera1.cnf:/etc/mysql/conf.d/galera.cnf \
	-e MYSQL_ROOT_PASSWORD=secret_galera_password \
	-e GALERA_NEW_CLUSTER=1 \
	galera

sleep 5; echo "#Start #2"
docker run -d --rm \
	--name node2 -h node2 --ip 172.17.0.102 \
	-p 3312:3306 \
	-v $PWD/configs/galera2.cnf:/etc/mysql/conf.d/galera.cnf \
	-e MYSQL_ALLOW_EMPTY_PASSWORD=1 \
	galera
	
sleep 5; echo "#Start #3"
docker run -d --rm \
	--name node3 -h node3 --ip 172.17.0.103 \
	-p 3313:3306 \
	-v $PWD/configs/galera3.cnf:/etc/mysql/conf.d/galera.cnf \
	-e MYSQL_ALLOW_EMPTY_PASSWORD=1 \
	galera


echo "The END."
