#!/bin/bash
set -e

function add_user {
    local table=$1
    local password=$2
    local dbname=$3

    psql \
    -v ON_ERROR_STOP=1 \
    -U $POSTGRES_USER \
    -d $dbname  <<-EOSQL 
		CREATE USER $table WITH PASSWORD '$password';
		CREATE DATABASE $table;
		GRANT ALL PRIVILEGES ON DATABASE $table TO $table;
		GRANT ALL PRIVILEGES ON DATABASE $dbname TO $table;
	EOSQL

}

add_user $PROCESS_USER $PROCESS_PASSWORD $POSTGRES_DB
add_user root $PROCESS_PASSWORD $POSTGRES_DB