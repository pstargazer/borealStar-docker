

SRV_PATH=$CMD_PATH
mkdir /var/log/server
export PHP_LOG_NAME=/var/log/server/php_$(date +"%d-%m-%Y")
export CRON_LOG_NAME=/var/log/server/cron_$(date +"%d-%m-%Y")
CROND_PATH=$CRON_LOG_NAME

cd /var/log/server
touch ${CRON_LOG_NAME}
touch ${PHP_LOG_NAME}

# crond -fS -L 0 -d 0 -c ${CROND_PATH} > ${LOG_NAME} &
crond -fS -L 0 -d 0 & #${CRON_LOG_NAME} &
cd ${SRV_PATH} 

pwd 
ls -l

if [ -d ./vendor ]; then
    echo "deps is okay"
else
    su 1000 -c "composer install"
fi

php artisan serve && fg > ${PHP_LOG_NAME} 
# nohup crond -bS -L 0 -d 0 -c "/etc/periodic" & nohup php artisan serve  && fg