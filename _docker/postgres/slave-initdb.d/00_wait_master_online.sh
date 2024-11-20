#!/bin/bash
set -e

CONNSTR=postgresql://$REPLICATION_USER:$REPLICATION_PASSWORD@bs_db:5432/borealstar
# wait until master online
until psql "$CONNSTR"  -c '\q'; do
#   >&2 echo "Ожидание запуска базы данных..."
  sleep 1
done

