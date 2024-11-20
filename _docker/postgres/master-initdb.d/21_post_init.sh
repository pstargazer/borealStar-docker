#!/bin/bash
# copy postgres configs to PGDATA

echo "COPYING CONF to PGDATA DIR"
# cp -r /tmp/pgconf/* --target-directory=$PGDATA
# cp -r /tmp/pgconf/ $PGDATA



echo "SETTING PERMISSIONS"


# GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO root;
# GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO root;
# GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO root;

psql \
-v ON_ERROR_STOP=1 \
-U $POSTGRES_USER \
-d $POSTGRES_DB  <<-EOSQL 
DO
\$\$
BEGIN
    GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO process;
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO process;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO process;
END
\$\$;
EOSQL

echo "SETTING PERMISSIONS END"
# psql -c "select pg_reload_conf();"
