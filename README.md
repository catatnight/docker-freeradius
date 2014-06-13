## Requirement
+ Docker 0.11

## Usage
1. Clone the git repo
	
	```bash
	$ git clone https://github.com/catatnight/docker-freeradius.git
	$ cd docker-freeradius
	```
2. Configure

	```bash
	$ vim Dockerfile 
	# edit Dockerfile
	ENV radpass      radpass
	# choose mysql or sqlite support and set related ENV values
	ENV sql_driver   mysql|sqlite
	ENV mysql_server ip.O.R.hostname
	ENV mysql_login  username
	ENV mysql_passwd password
	ENV sqlite_db    db_filename.db
	```
3. Build container and then manage it as root
	
	```bash
	$ sudo ./build.sh
	$ sudo ./manage.py [create|start|stop|restart|delete]
	# when creating container with sqlite support, 
	#   please specify the path of folder stored .db file as followed:
	$ sudo ./manage.py -d /path/to/db create
	```

## Note
+ all remote clients (ipv4/ipv6) are allowed by freeradius, and access restriction could be specified by firewall rules.
+ ```default_eap_type = mschapv2 (default: md5)```

## Reference
+ TBD


