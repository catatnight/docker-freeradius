#!/bin/bash

# Configure
radpass='Your Radpass'
mysql_server='Your Mysql Server ip or Address'
mysql_login='Your Mysql Username'
mysql_passwd='Your Mysql Password'
time_zone='Asia/Shanghai'

### Dont't edit below
#clients.conf 
sed -i "/client localhost/i client 0.0.0.0/0{\n\tsecret = $radpass\n}" /etc/freeradius/clients.conf 
sed -i "/client localhost/i client ipv6{\n\tipv6addr = ::\n\tsecret = $radpass\n}" /etc/freeradius/clients.conf 
sed -i "s/testing123/$radpass/" /etc/freeradius/clients.conf 
#radiusd.conf 
sed -i 's/^#[ \t]\$INCLUDE sql.conf$/\t\$INCLUDE sql.conf/' /etc/freeradius/radiusd.conf
sed -i "1i listen {\n\tipv6addr = ::\n\tport = 0\n\ttype = auth\n}" /etc/freeradius/radiusd.conf
sed -i "1i listen {\n\tipv6addr = ::\n\tport = 0\n\ttype = acct\n}" /etc/freeradius/radiusd.conf
#sql.conf
sed -i "s/server = \"localhost\"/server = \"$mysql_server\"/" /etc/freeradius/sql.conf
sed -i "s/login = \"radius\"/login = \"$mysql_login\"/" /etc/freeradius/sql.conf
sed -i "s/password = \"radpass\"/password = \"$mysql_passwd\"/" /etc/freeradius/sql.conf
#other
sed -i 's/^#[ \t]sql$/\tsql/' /etc/freeradius/sites-available/default
sed -i 's/^#[ \t]sql$/\tsql/' /etc/freeradius/sites-available/inner-tunnel
sed -i '0,/md5/{s/md5/mschapv2/}' /etc/freeradius/eap.conf
#timezone
sudo bash -c 'echo "$time_zone" > /etc/timezone' 
dpkg-reconfigure -f noninteractive tzdata

