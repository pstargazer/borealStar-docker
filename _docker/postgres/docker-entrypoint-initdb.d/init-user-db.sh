#!/bin/bash
set -e


sqlinit() {

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER docker;
    CREATE DATABASE docker;
    GRANT ALL PRIVILEGES ON DATABASE docker TO docker;
EOSQL
}


clustersinit(){
    echo "=========INITIALIZING DB============"
    su postgres -c "pg_createcluster $PGVERSION $PGCLUSTERNAME \
                                -D $PGDATA"
}

echo "===========INITDB.D RUNNING==============" > /var/log/postgresql/postgresql-16-main.log
clustersinit
sqlinit

echo "===========INITDB.D EXITED=============="
