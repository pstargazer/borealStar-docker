#!/bin/bash

# ls -l $PGDATA


# BASE_DIR="$(pwd)"
# cd $PGDATA
# # chmod u=rwx . -R
# chmod 700 ../main -R
# cd $BASE_DIR
# mkdir -p $PGDATA # make or pass
su -c "chmod 700 -R /var/lib/postgresql/"
su -c "chown postgres:postgres -R /var/lib/postgresql/"

echo "++++++++STARTING DB+++++++++"
# su postgres -c "postgres -D /var/lib/postgresql/${PGVERSION}/${PGCLUSTERNAME}\


# ls -l /docker-entrypoint-initdb.d


pid=0

int_handler() {
    # get the dump of database
    touch /var/log/postgresql/dump.log
    EXPORT_PATH = /opt/dumps/
    echo "dumping database" > /var/log/postgresql/dump.log
    su postgres -c "pg_dump localhost databasename >> ${EXPORT_PATH}bs_dump_$(date +%Y-%m-%d-%H.%M.%S).sql" \
        > /var/log/postgresql/dump.log

#   node deactivator & pid="$!"
}

# setup handlers
trap int_handler SIGKILL
trap int_handler SIGINT

# ls -l /etc/ | grep "postgre"
# ls -l /etc/ | grep "postgre"

# su -c "rm -rf /var/lib/postgresql/data"
echo "psql"
ls -la /var/lib/postgresql
echo "datadir"
ls -la /var/lib/postgresql/data
# cat /var/lib/postgresql/data/*

# su postgres -c "postgres \
                    #    --config-file='/etc/postgresql/$PGVERSION/$PGCLUSTERNAME/postgresql.conf'"
# su postgres -c "postgres & echo $!"
# su postgres -c "postgres"
# postgres
# su postgres -c '\
# postgres    \
#             -D /var/lib/postgresql/data'
