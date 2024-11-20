#!/bin/bash
set -e

echo "SETTING REPLICATION SLAVE DB"


psql \
-v ON_ERROR_STOP=1 \
-U $POSTGRES_USER \
-d $POSTGRES_DB  << EOSQL
    ALTER SYSTEM SET primary_conninfo = "host=bs_db port=5432 user=$REPLICATION_USER password=$REPLICATION_PASSWORD sslmode=allow require_auth=scram-sha-256";


    CREATE DATABASE $REPLICATION_USER;
    SHOW wal_level;
    CREATE USER $REPLICATION_USER WITH PASSWORD '$REPLICATION_PASSWORD';
    CREATE SUBSCRIPTION db_sub CONNECTION 'host=bs_db user=$REPLICATION_USER password=$REPLICATION_PASSWORD' PUBLICATION db_pub;
EOSQL

#     CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'replicator_password';
#     SELECT pg_create_physical_replication_slot('replication_slot')