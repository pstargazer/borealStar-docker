#!/bin/bash
set -e


moveconf() {
    echo "moving conf from $TMPCONF to $DEST"
    for file in $(ls $TMPCONF) do  
        mv $file $DEST
    done
    
}


clustersinit(){
    echo "=========CLUSTER INIT============"
    
                                # -d $PGCONF \
    su postgres -c "pg_createcluster \
                                data \
                                -l $PG_LOG/init.log"

    # su postgres -c "pg_createcluster data "
}

echo "===========INITDB.D RUNNING=============="

# clustersinit
moveconf /tmp/pgconf $PGDATA