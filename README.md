## Requirement
+ Docker 0.8

## Usage
1. configure

    ```bash
    # Dockerfile (NO double quotes)
    #Configure
    ENV radpass       Your Radpass   
    ENV mysql_server  Your Mysql Server ip or Address
    ENV mysql_login   radius
    ENV mysql_passwd  Your Password
    ```

2. run ```build.sh``` and ```run-server.sh``` 
3. if freeradius is linked to a local docker container running MySQL, just edit 

    ```bash
    # run-server.sh
    docker run -p 1812:1812/udp -p 1813:1813/udp -name freeradius -d -link <container>:<alias> catatnight/freeradius-mysql

    # assets/run-radius.sh
    sed -i "s/server = \"localhost\"/server = \"$<alias>_PORT_3306_TCP_ADDR\"/" /etc/freeradius/sql.conf
    ```

## Note
+ all remote freeradius clients (ipv4/ipv6) are allowed
+ ```default_eap_type = mschapv2 (default: md5)``` in ```/etc/freeradius/eap.conf```

## Reference
+ [Link Containers - Docker Documentation](http://docs.docker.io/en/latest/use/working_with_links_names/)
+ TBD


