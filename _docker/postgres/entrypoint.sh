#!/bin/bash

su -c "chmod 700 -R /var/lib/postgresql/"
su -c "chown postgres:postgres -R /var/lib/postgresql/"

# echo "++++++++STARTING DB+++++++++"

int_handler() {
    # get the dump of database
    EXPORT_PATH = /opt/dumps/
    cd $EXPORT_PATH
    pg_dump borealstar -U $POSTGRES_USER >> $EXPORT_PATH/bs_dump_$(date +%Y-%m-%d-%H.%M.%S).sql
    return 0
}

# perform standart init
/usr/local/bin/docker-ensure-initdb.sh
# setup handlers
echo "setting traps"
trap "int_handler" HUP INT QUIT TERM USR1
/usr/local/bin/docker-entrypoint.sh



dpid=$! # current process pid
# wait for script to halt
su postgres -c "postgres" & wait $dpid


