#!/bin/bash
/usr/sbin/service php8.1-fpm start
if ! [ -f /run/cloudboost ]; then
        echo "Composer not installed";
        cd /public_html;
        composer install;
        php artisan key:generate;
        touch /run/cloudboost;
		mysql -h$GLUE_D_HOST -u$GLUE_DATABASE_USER -p$GLUE_DATABASE_PASS $GLUE_DATABASE < /public_html/$DB_DUMP;
else
        echo "project already initialized";
fi

tail -f /dev/null
