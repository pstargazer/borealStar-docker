#!/bin/bash
set -e

echo "SETTING REPLICATION DB"




psql \
-v ON_ERROR_STOP=1 \
-U $POSTGRES_USER \
-d $POSTGRES_DB  << EOF
    ALTER SYSTEM SET wal_level = 'logical';
    ALTER SYSTEM SET max_wal_senders = 10;
    ALTER SYSTEM SET archive_mode = on;
    ALTER SYSTEM SET wal_log_hints = 'on';
    ALTER SYSTEM SET archive_library = '$PGDATA/archive/';
EOF

psql \
-v ON_ERROR_STOP=1 \
-U $POSTGRES_USER \
-d $POSTGRES_DB  << EOF
    
    SHOW wal_level;
    CREATE DATABASE replicator;
    CREATE ROLE replicator WITH REPLICATION ENCRYPTED PASSWORD '$REPLICATION_PASSWORD';
    CREATE PUBLICATION db_pub FOR ALL TABLES;
    GRANT ALL PRIVILEGES ON DATABASE borealstar TO replicator;
    ALTER USER replicator WITH LOGIN;
EOF

# cat $PGDATA/postgresql.conf | grep -n "wal_level"
# WALCHECK=$(cat $PGDATA/postgresql.conf | grep -n "wal_level")
# echo EOM

#     ${WALCHECK}

# EOM
# echo ${WALCHECK} 

# EOSQL
    # GRANT ALL PRIVILEGES ON DATABASE
    # SELECT pg_create_physical_replication_slot('rslot_testing_db');

#     CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'replicator_password';
#     SELECT pg_create_physical_replication_slot('replication_slot')
