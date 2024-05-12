# crond -bS # -L logs
crond -bS & # & -L logs
cd /var/www/html/$BRANCH
php artisan serve