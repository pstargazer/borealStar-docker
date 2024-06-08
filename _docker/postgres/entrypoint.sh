#!/bin/bash

su -c "chmod 700 -R /var/lib/postgresql/"
su -c "chown postgres:postgres -R /var/lib/postgresql/"

dumpdb() {
    # ARG 1 - middle dump name (onstart|onstop)
    middlename=$1
    local dumpname = $EXPORT_PATH\/${sequenceId}_bs_dump_${middlename}_$(date +%d-%h-%Y-%H:%M:%S).sql

    echo $middlename
    while ! /usr/lib/postgresql/16/bin/pg_isready; do
        # wait until db is up
        echo "not ready"
    done
    local EXPORT_PATH=/opt/dumps/
    local sequenceId=20
    cd $EXPORT_PATH
    # get the dump of database
    pg_dump borealstar -U $POSTGRES_USER >> $EXPORT_PATH\/${sequenceId}_bs_dump_${middlename}_$(date +%d-%h-%Y-%H:%M:%S).sql
    chown 1000:users $EXPORT_PATH
}

# perform standart init
/usr/local/bin/docker-ensure-initdb.sh
/usr/local/bin/docker-entrypoint.sh
# setup handlers
echo "setting stop handler"
trap "dumpdb \"onstop\"" HUP INT QUIT TERM USR1 KILL


# current process pid
dpid=$!
# wait for script to halt
# and backup the db dump 
su postgres -c "postgres" & dumpdb "onstart" & wait $dpid


