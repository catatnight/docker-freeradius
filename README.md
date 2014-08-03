## Requirement
+ Docker 0.11

## Installation
1. Build image (as root)

	```bash
	$ docker pull catatnight/freeradius
	$ curl https://raw.githubusercontent.com/catatnight/docker-freeradius/master/manage.py -o manage.py
	$ chmod +x manage.py
	```

## Usage
1. Create container and manage it (as root)

	```bash
	$ ./manage.py [create|start|stop|restart|delete]
	# mysql support
	$ ./manage.py -s radpass --mysql_server 1.2.3.4 -u test -p test create
	# sqlite support
	# Warning:
	#   1. db file ext. should be .sqlite or .sqlite3
	#   2. no other db file in /path/to/db
	$ ./manage.py -s radpass -d /path/to/db create
	```

## Note
+ all remote clients (ipv4/ipv6) are allowed by freeradius, and access restriction could be specified by firewall rules.
+ ```default_eap_type = mschapv2 (default: md5)```

## Reference
+ TBD


