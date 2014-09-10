#!/bin/bash

#initialization
if [[ "$(cat /etc/freeradius/dictionary | grep 'Max-Monthly-Traffic')" != "" ]]; then
  exit 0
fi

#freeradius
if [[ $readsqlclients == "no" ]]; then
  sed -i -e "/client localhost/i client 0.0.0.0/0{\n\tsecret = $radpass\n}" \
    -e "/client localhost/i client ipv6{\n\tipv6addr = ::\n\tsecret = $radpass\n}" \
    -e "s/testing123/$radpass/" /etc/freeradius/clients.conf
else
  sed -i "/readclients/ s/#//" /etc/freeradius/sql.conf
  sed -i "/clients.conf$/ s/^/#/" /etc/freeradius/radiusd.conf
fi
sed -i -e '/sql.conf$/ s/#//' \
  -e "1i listen {\n\tipv6addr = ::\n\tport = 0\n\ttype = auth\n}" \
  -e "1i listen {\n\tipv6addr = ::\n\tport = 0\n\ttype = acct\n}" /etc/freeradius/radiusd.conf
sed -i -e "s/server = \"localhost\"/server = \"$mysql_server\"/" \
  -e "s/login = \"radius\"/login = \"$mysql_login\"/" \
  -e "s/password = \"radpass\"/password = \"$mysql_passwd\"/" /etc/freeradius/sql.conf
sed -i "/simul_count_query =/,+3 s/#//" /etc/freeradius/sql/mysql/dialup.conf
sed -i 's/^#[ \t]sql$/\tsql/' /etc/freeradius/sites-available/default
sed -i 's/^#[ \t]sql$/\tsql/' /etc/freeradius/sites-available/inner-tunnel
sed -i '0,/md5/{s/md5/mschapv2/}' /etc/freeradius/eap.conf
#max monthly traffic
sed -i '/counter.conf/ s/#//' /etc/freeradius/radiusd.conf
cat >> /etc/freeradius/sql/mysql/counter.conf <<EOF
sqlcounter monthlytrafficcounter {
    counter-name = Monthly-Traffic
    check-name = Max-Monthly-Traffic
    reply-name = Monthly-Traffic-Limit
    sqlmod-inst = sql
    key = User-Name
    reset = monthly
    query = "SELECT SUM(acctinputoctets + acctoutputoctets) FROM radacct WHERE UserName='%{%k}' AND UNIX_TIMESTAMP(AcctStartTime) > '%b'"
}
EOF
sed -i '/^\tpap/a\\tmonthlytrafficcounter' /etc/freeradius/sites-available/default
cat >> /etc/freeradius/dictionary <<EOF
ATTRIBUTE Max-Monthly-Traffic 3003 integer
ATTRIBUTE Monthly-Traffic-Limit 3004 integer
EOF

#timezone
bash -c "echo $time_zone > /etc/timezone"
dpkg-reconfigure -f noninteractive tzdata
