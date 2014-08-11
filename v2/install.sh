#!/bin/bash

#initialization
if [[ "$(cat /etc/freeradius/clients.conf | grep '0.0.0.0')" != "" ]]; then
  exit 0
fi

#freeradius
sed -i -e "/client localhost/i client 0.0.0.0/0{\n\tsecret = $radpass\n}" \
  -e "/client localhost/i client ipv6{\n\tipv6addr = ::\n\tsecret = $radpass\n}" \
  -e "s/testing123/$radpass/" /etc/freeradius/clients.conf
sed -i -e 's/^#[ \t]\$INCLUDE sql.conf$/\t\$INCLUDE sql.conf/' \
  -e "1i listen {\n\tipv6addr = ::\n\tport = 0\n\ttype = auth\n}" \
  -e "1i listen {\n\tipv6addr = ::\n\tport = 0\n\ttype = acct\n}" /etc/freeradius/radiusd.conf
sed -i -e "s/server = \"localhost\"/server = \"$mysql_server\"/" \
  -e "s/login = \"radius\"/login = \"$mysql_login\"/" \
  -e "s/password = \"radpass\"/password = \"$mysql_passwd\"/" /etc/freeradius/sql.conf
sed -i 's/^#[ \t]sql$/\tsql/' /etc/freeradius/sites-available/default
sed -i 's/^#[ \t]sql$/\tsql/' /etc/freeradius/sites-available/inner-tunnel
sed -i '0,/md5/{s/md5/mschapv2/}' /etc/freeradius/eap.conf

#timezone
bash -c "echo $time_zone > /etc/timezone"
dpkg-reconfigure -f noninteractive tzdata