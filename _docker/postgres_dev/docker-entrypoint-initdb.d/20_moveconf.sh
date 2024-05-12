set -e


# moveconf() {
#     $TMPCONF = $1
#     $CONF_DESTINATION = $2
#     cd $TMPCONF
#     echo "moving conf from $TMPCONF to $CONF_DESTINATION"
#     # for file in $(ls $TMPCONF) do  
#     for file in * do
#         echo "moving $file"
#         mv "$TMPCONF/$file $CONF_DESTINATION"
#     done
    
# }


# moveconf /tmp/pgconf $PGDATA

# moveconf() {
#     set TMPCONF $1
#     set CONF_DESTINATION $2
#     cd $TMPCONF
#     # for file in $TMPCONF/*; do
#     #     # echo "moving $file"
#     #     mv $file $CONF_DESTINATION
#     # done
#     mv * --target-directory=$CONF_DESTINATION
# }

cp /tmp/pgconf/* --target-directory=$PGDATA
