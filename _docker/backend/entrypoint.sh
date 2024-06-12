

SRV_PATH=$CMD_PATH
export LOG_PATH=/var/log/server/
mkdir $LOG_PATH
export PHP_LOG_NAME=$LOG_PATH/php_$(date +"%d-%m-%Y")
export CRON_LOG_NAME=$LOG_PATH/cron_$(date +"%d-%m-%Y")
CROND_PATH=$CRON_LOG_NAME

cd $LOG_PATH
touch $CRON_LOG_NAME
touch $PHP_LOG_NAME
# chown $(whoami):users $LOG_PATH -R

cd ${SRV_PATH} 

# composer update
# composer install

if [ -d ./vendor ]; then
    echo "deps is okay"
else
    composer install
fi

# HTTP
cd ${SRV_PATH} && php artisan serve & 
# WS
php artisan reverb:start --debug &
php artisan queue:listen &
# crond
cd $LOG_PATH && busybox crond -f -l 0 -d 8 &
# nginx
nginx -g 'daemon off;' &
wait -n