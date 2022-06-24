#!/bin/ash
rm /home/container/logs/apache.pid
echo "Starting PHP-FPM..."
/usr/sbin/php-fpm8 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize

echo "Starting Apache..."
/usr/sbin/httpd -d /home/container/webroot/ -f /home/container/apache/apache.conf