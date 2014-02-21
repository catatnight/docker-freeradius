## Requirement
+ Docker 0.8

## Usage
1. configure

    ```bash
    # Dockerfile (NO double quotes)
    #Configure
    ENV radpass       Your Radpass   
    ENV mysql_server  Your Mysql Server ip or Address
    ENV mysql_login   Your Mysql Username
    ENV mysql_passwd  Your Mysql Password
    ```

2. run ```build.sh``` and ```run-server.sh``` 

3. if freeradius is linked to MySQL database ruuning on localhost, don't forget adding iptables rules like:
    ```ufw allow proto tcp from 172.17.0.0/16 to any port 3306```

4. if freeradius is linked to a local docker container running MySQL, just edit 

    ```bash
    # run-server.sh
    ... -name freeradius -d -link <container>:<alias> catatnight/freeradius-mysql

    # assets/run-radius.sh
    sed -i "s/server = \"localhost\"/server = \"$<alias>_PORT_3306_TCP_ADDR\"/" ...
    ```

## Note
+ all remote freeradius clients (ipv4/ipv6) are allowed
+ ```default_eap_type = mschapv2 (default: md5)``` in ```/etc/freeradius/eap.conf```

## Reference
+ [Link Containers - Docker Documentation](http://docs.docker.io/en/latest/use/working_with_links_names/)
+ TBD


