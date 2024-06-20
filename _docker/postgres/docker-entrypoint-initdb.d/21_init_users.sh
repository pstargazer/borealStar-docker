#!/bin/bash
set -e

function add_user {
    local table=$1
    local password=$2
    local dbname=$3

    psql \
    -v ON_ERROR_STOP=0 \
    -U $POSTGRES_USER \
    -d $dbname  <<-EOSQL 
    CREATE DATABASE $table;
    DO
    \$\$
    BEGIN
      IF EXISTS ( SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = '$table') THEN  
          RAISE NOTICE 'Role $table already exists. Skipping.';
      ELSE
          CREATE USER $table WITH PASSWORD '$password';
          GRANT ALL PRIVILEGES ON DATABASE $table TO $table;
          GRANT ALL PRIVILEGES ON DATABASE $dbname TO $table;
      END IF;
    END
    \$\$;
	EOSQL

}

add_user $PROCESS_USER $PROCESS_PASSWORD $POSTGRES_DB
add_user root $PROCESS_PASSWORD $POSTGRES_DB
# add_user admin $PROCESS_PASSWORD $POSTGRES_DB