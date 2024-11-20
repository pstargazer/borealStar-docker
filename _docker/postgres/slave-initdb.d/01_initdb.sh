#!/bin/bash

echo "ensure-initdb.sh"

# /usr/local/bin/docker-enforce-initdb.sh
/usr/local/bin/docker-ensure-initdb.sh
# cp -r /tmp/pgconf/* $PGDATA
