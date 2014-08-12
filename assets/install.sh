#!/bin/bash

#judgement
if [[ -a /etc/supervisor/conf.d/supervisord.conf ]]; then
  exit 0
fi

#supervisor
cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[supervisord]
nodaemon=true

[program:nginx]
command=/usr/sbin/nginx -c /etc/nginx/nginx.conf

[program:php]
command=/usr/sbin/php5-fpm -c /etc/php5/fpm

[program:rsyslog]
command=/usr/sbin/rsyslogd -n -c3
EOF

#ara
sed -i -e "s/localhost/$mysql_server/" -e "s/usrname/$mysql_login/" -e "s/passwd2/$mysql_passwd/" /ara/src/config/config.php
sed -i "s/expass2/$admin_passwd/" /ara/src/config/users/admin.php

#nginx
echo "daemon off;" >> /etc/nginx/nginx.conf

#PHP
sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini
