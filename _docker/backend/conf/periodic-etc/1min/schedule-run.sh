echo $(whoami) > /var/log/server/cron_02-06-2024
cd $CMD_PATH && php artisan schedule:run
# touch /var/log/server/test
