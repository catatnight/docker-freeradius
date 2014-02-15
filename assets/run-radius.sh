#!/bin/bash

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
#note: replace $mysql_server by $<alias>_PORT_3306_TCP_ADDR if connected with a local docker mysql container 
sed -i "s/login = \"radius\"/login = \"$mysql_login\"/" /etc/freeradius/sql.conf
sed -i "s/password = \"radpass\"/password = \"$mysql_passwd\"/" /etc/freeradius/sql.conf
#other
sed -i 's/^#[ \t]sql$/\tsql/' /etc/freeradius/sites-available/default
sed -i 's/^#[ \t]sql$/\tsql/' /etc/freeradius/sites-available/inner-tunnel
sed -i '0,/md5/{s/md5/mschapv2/}' /etc/freeradius/eap.conf

# Run freeradius
/usr/sbin/freeradius -f
