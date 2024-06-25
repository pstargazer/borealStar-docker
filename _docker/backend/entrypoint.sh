

SRV_PATH=$CMD_PATH
export LOG_PATH=/var/log/server/
mkdir $LOG_PATH
export PHP_LOG_NAME=$LOG_PATH/php_$(date +"%d-%m-%Y")
export CRON_LOG_NAME=$LOG_PATH/cron_$(date +"%d-%m-%Y")
CROND_PATH=$CRON_LOG_NAME

# echo $USERNAME_int $USERGROUP

# internal username
USERNAME_int=$(whoami)

cd $LOG_PATH
touch $CRON_LOG_NAME
touch $PHP_LOG_NAME

cd $SRV_PATH 

# if [ -d ./composer.lock ]; then
#     rm composer.lock
# fi

if composer check | grep "missing"; then
    echo "composer check failed:"
    composer check | grep "missing"
    # exit 1
fi

if [ -d ./vendor ]; then
    echo "deps is okay"
    chown $USERNAME_int:$USERGROUP ./vendor -R
else
    composer update
    composer install
    chown $USERNAME_int:$USERGROUP ./vendor -R
fi


# HTTP
cd ${SRV_PATH} && php artisan route:cache && php artisan serve & 
# WS
php artisan reverb:start --debug &
php artisan queue:listen &
# crond
cd $LOG_PATH && busybox crond -f -l 0 -d 8 &
# nginx
nginx -g 'daemon off;' &
wait -n