#!/bin/bash

echo COPYING THE CONFIGS INTO PGDATA DIR 

# copy files 
# sudo -u postgres mv /tmp/pgconf/* $PGDATA
cp -r /tmp/pgconf/ $PGDATA
# cp /tmp/pgconf/conf.d $PGDATA
chown postgres:postgres -R $PGDATA

# reload the configs
# pg_ctl restart -D $PGDATA
pg_ctl reload -D $PGDATA