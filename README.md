## Requirement
+ Docker 0.11

## Usage
1. configure

    ```bash
    # edit Dockerfile
    ENV radpass      Your Radpass
    ENV mysql_server Your Mysql Server ip or Address
    ENV mysql_login  Your Mysql Username
    ENV mysql_passwd Your Mysql Password
    ENV time_zone    Asia/Shanghai
    ```
2. run ```build.sh``` to build container and then start it by running ```run-server.sh```

## Note
+ all remote freeradius clients (ipv4/ipv6) are allowed
+ ```default_eap_type = mschapv2 (default: md5)``` in ```/etc/freeradius/eap.conf```

## Reference
+ TBD


