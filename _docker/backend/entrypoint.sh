

SRV_PATH=$CMD_PATH
mkdir /var/log/server
export PHP_LOG_NAME=/var/log/server/php_$(date +"%d-%m-%Y")
export CRON_LOG_NAME=/var/log/server/cron_$(date +"%d-%m-%Y")
CROND_PATH=$CRON_LOG_NAME

cd /var/log/server
touch $CRON_LOG_NAME
touch $PHP_LOG_NAME

cd ${SRV_PATH} 


if [ -d ./vendor ]; then
    echo "deps is okay"
else
    composer install
fi


cd ${SRV_PATH} && php artisan serve & 
cd /var/log/server && crond -f -l 0 -d 0  &
wait -n