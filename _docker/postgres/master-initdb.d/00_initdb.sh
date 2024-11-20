#!/bin/bash
# source /usr/local/bin/docker-entrypoint.sh
# echo "ensure-initdb.sh"
# perform standart init
# /usr/local/bin/docker-entrypoint.sh
/usr/local/bin/docker-ensure-initdb.sh

# cp -r /tmp/pgconf/ $PGDATA
# reload configs without reload

# pidfile="/var/lib/postgresql/data/postmaster.pid"
# # read pid from file
# pid=$(head -n 1 "$pidfile")

# kill -HUP $(ps aux | awk '/postgres/{print $2}')
# kill -HUP $pid
# /usr/local/bin/docker-enforce-initdb.sh


