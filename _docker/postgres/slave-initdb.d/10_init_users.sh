#!/bin/bash
set -e

# cat /etc/passwd

function add_user {
    local dbname=$1
    local password=$2
# -d $dbname
    psql \
    -v ON_ERROR_STOP=1 \
    -U $POSTGRES_USER <<-EOSQL 
    CREATE DATABASE $dbname;
    DO
    \$\$
    BEGIN
      IF EXISTS ( SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = '$dbname') THEN  
          RAISE NOTICE 'Role $dbname already exists. Skipping.';
      ELSE
          CREATE USER $dbname WITH PASSWORD '$password';
          GRANT ALL PRIVILEGES ON DATABASE $dbname TO $dbname;
      END IF;
    END
    \$\$;
	EOSQL

}

function add_su {
    local name=$1
    local dbname=$2

    # if postgres
    if [ -z "$dbname" ]; then
        psql \
            -v ON_ERROR_STOP=1 \
            -c "CREATE DATABASE ${dbname};"
    fi

    psql \
    -v ON_ERROR_STOP=1 \
    -d $dbname  <<-EOSQL 
    DO
    \$\$
    BEGIN
      IF EXISTS ( SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = '$name') THEN  
          RAISE NOTICE 'Role $name already exists. Skipping.';
      ELSE
          CREATE USER $name SUPERUSER;
          GRANT ALL PRIVILEGES ON DATABASE $name TO $name;
      END IF;
    END
    \$\$;
	EOSQL
}


# CREATE USER postgres SUPERUSER;
# CREATE DATABASE postgres WITH OWNER postgres;

# TODO:
#  make permissions with separate func
#  replication script
# add_su postgres
# add_su $POSTGRES_USER $POSTGRES_USER

add_user $PROCESS_USER $PROCESS_PASSWORD 
# add_user process $PROCESS_PASSWORD
# add_user docker $PROCESS_PASSWORD



# psql \
# -v ON_ERROR_STOP=1 \
# -U $POSTGRES_USER \
# <<-EOSQL 
# CREATE DATABASE replicator;
# DO
# \$\$
# BEGIN
#     CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'replicator_password';
#     SELECT pg_create_physical_replication_slot('replication_slot');
# END
# \$\$;
# EOSQL


