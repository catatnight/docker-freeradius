## Requirement
+ Docker 0.11

## Usage
1. configure

    ```bash
    # Dockerfile (NO double quotes)
    ENV radpass      Your Radpass
    ENV mysql_server Your Mysql Server ip or Address
    ENV mysql_login  Your Mysql Username
    ENV mysql_passwd Your Mysql Password
    ENV time_zone    Asia/Shanghai
    ```

2. run ```build.sh``` and ```run-server.sh``` 

3. if freeradius is linked to MySQL on localhost, maybe you'd like to add an iptables rule like:
    ```ufw allow proto tcp from 172.17.0.0/16 to any port 3306```

## Note
+ all remote freeradius clients (ipv4/ipv6) are allowed
+ ```default_eap_type = mschapv2 (default: md5)``` in ```/etc/freeradius/eap.conf```

## Reference
+ TBD


