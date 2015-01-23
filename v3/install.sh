#!/bin/bash

#initialization
if [[ -h /etc/freeradius/mods-enabled/sql ]]; then
  exit 0
fi

#freeradius
sed -i "s/allow_vulnerable_openssl = no/allow_vulnerable_openssl = 'CVE-2014-0160'/" /etc/freeradius/radiusd.conf
sed -i -e "/client localhost/i client 0.0.0.0/0{\n\tsecret = $radpass\n}" \
  -e "/client localhost/i client ipv6{\n\tipv6addr = ::\n\tsecret = $radpass\n}" \
  -e "s/testing123/$radpass/" /etc/freeradius/clients.conf
if [[ ! -z "$mysql_server" ]]; then
  sql_driver='mysql'
  sed -i "/driver =.*/ a\ \n\tserver = \"$mysql_server\"\n\tlogin = \"$mysql_login\"\n\tpassword = \"$mysql_passwd\"" /etc/freeradius/mods-available/sql
else
  sql_driver='sqlite'
  sqlite_db=`ls /opt/db | grep sqlite`
  sed -i "/driver =.*/ a\ \n\tsqlite {\n\t\tfilename = \"/opt/db/$sqlite_db\"\n\t}" /etc/freeradius/mods-available/sql
fi
sed -i -e "s/driver =.*/driver = \"rlm_sql_$sql_driver\"/" -e "s/dialect =.*/dialect = \"$sql_driver\"/" /etc/freeradius/mods-available/sql
ln -s /etc/freeradius/mods-available/sql /etc/freeradius/mods-enabled/sql
sed -i '0,/md5/{s/md5/mschapv2/}' /etc/freeradius/mods-available/eap

#timezone
bash -c "echo $time_zone > /etc/timezone"
dpkg-reconfigure -f noninteractive tzdata
