#!/bin/bash

#judgement
if [[ -a /etc/supervisor/conf.d/nginx-php5.conf ]]; then
  exit 0
fi

#ara
sed -i -e "s/localhost/$mysql_server/" -e "s/usrname/$mysql_login/" -e "s/passwd2/$mysql_passwd/" /ara/src/config/config.php
sed -i "s/expass2/$admin_passwd/" /ara/src/config/users/admin.php
