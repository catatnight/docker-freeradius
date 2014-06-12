#!/bin/bash

#freeradius
sed -i "s/allow_vulnerable_openssl.*/allow_vulnerable_openssl = yes/" /etc/freeradius/radiusd.conf
sed -i -e "/client localhost/i client 0.0.0.0/0{\n\tsecret = $radpass\n}" \
  -e "/client localhost/i client ipv6{\n\tipv6addr = ::\n\tsecret = $radpass\n}" \
  -e "s/testing123/$radpass/" /etc/freeradius/clients.conf 
sed -i -e "s/driver =.*/driver = \"rlm_sql_mysql\"/" \
  -e "/driver =.*/ a\ \n\tserver = \"$mysql_server\"\n\tlogin = \"$mysql_login\"\n\tpassword = \"$mysql_passwd\"" /etc/freeradius/mods-available/sql
ln -s /etc/freeradius/mods-available/sql /etc/freeradius/mods-enabled/sql
sed -i '0,/md5/{s/md5/mschapv2/}' /etc/freeradius/mods-available/eap

#timezone
bash -c "echo $time_zone > /etc/timezone" 
dpkg-reconfigure -f noninteractive tzdata

