## Requirement
+ Docker 0.11

## Usage
1. Clone the git repo
	
	```bash
	$ git clone https://github.com/catatnight/docker-freeradius-mysql.git
	$ cd docker-freeradius-mysql
	```
2. Configure

	```bash
	$ vim Dockerfile 
	# edit Dockerfile
	ENV radpass      Your Radpass
	ENV mysql_server Your Mysql Server Address
	ENV mysql_login  Your Mysql Username
	ENV mysql_passwd Your Mysql Password
	```
3. Build container and then manage it as root
	
	```bash
	$ sudo ./build.sh
	$ sudo ./manage.py [start|stop|restart]
	```

## Note
+ all remote clients (ipv4/ipv6) are allowed by freeradius, and access restriction could be specified by firewall rules.
+ ```default_eap_type = mschapv2 (default: md5)``` in ```/etc/freeradius/eap.conf```

## Reference
+ TBD


