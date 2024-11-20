#!/bin/bash
set -e

source /usr/local/bin/docker-entrypoint.sh


# see also "_main" in "docker-entrypoint.sh"

docker_setup_env
# setup data directories and permissions (when run as root)
docker_create_db_directories
if [ "$(id -u)" = '0' ]; then
	# then restart script as postgres user
	exec gosu postgres "$BASH_SOURCE" "$@"
fi

# only run initialization on an empty data directory
if [ -z "$DATABASE_ALREADY_EXISTS" ]; then
	docker_verify_minimum_env

	# check dir permissions to reduce likelihood of half-initialized database
	ls /docker-entrypoint-initdb.d/ > /dev/null

	docker_init_database_dir
	pg_setup_hba_conf "$@"

	# PGPASSWORD is required for psql when authentication is required for 'local' connections via pg_hba.conf and is otherwise harmless
	# e.g. when '--auth=md5' or '--auth-local=md5' is used in POSTGRES_INITDB_ARGS
	export PGPASSWORD="${PGPASSWORD:-$POSTGRES_PASSWORD}"
	docker_temp_server_start "$@"

	docker_setup_db
	docker_process_init_files /docker-entrypoint-initdb.d/*

	docker_temp_server_stop
	unset PGPASSWORD
else
	self="$(basename "$0")"
	case "$self" in
		docker-ensure-initdb.sh)
			echo >&2 "$self: note: database already initialized in '$PGDATA'!"
			exit 0
			;;

		docker-enforce-initdb.sh)
			echo >&2 "$self: error: (unexpected) database found in '$PGDATA'!"
			exit 1
			;;

		*)
			echo >&2 "$self: error: unknown file name: $self"
			exit 99
			;;
	esac
fi

# wait until bs_db will be online
CONNSTR=postgresql://$REPLICATION_USER:$REPLICATION_PASSWORD@bs_db:5432/borealstar
primary_conninfo='host=primary_host port=5432 user=replicator password=password sslmode=require'


# cat $PGDATA/pg_hba.conf

# GET CURRENT CHECKPOINT AND OUTPUT IT
QUERY_GET_CHECKPOINT="SELECT pg_current_wal_flush_lsn();"
CHECKPOINT_LOCATION=$(psql "$CONNSTR"  -t -c "$QUERY_GET_CHECKPOINT")
echo "CURRENT CHECKPOINT: $CHECKPOINT_LOCATION"

# GET BACKUP 
pg_basebackup -d "$CONNSTR"  \
              -D "$PGDATA" \
              -W --password \
              --target=client -Fp -P -X stream <<< "$REPLICATION_PASSWORD"
# pg_basebackup -h <IP_сервера-источника> -U <пользователь> -D /path/to/data_directory -P -X stream

# BACKGROUND PROCESS GOES OFFLINE 
pg_ctl stop -m smart
cat "$PGDATA"/pg_hba.conf
postgres -c config_file='/etc/postgres/conf/'
# postgres -D /etc/postgres/conf/
# RETURN TO MAIN 
# exec "$@"