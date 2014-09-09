## Requirement
+ Docker 0.11

## Installation
1. Build image (as root)

	```bash
	$ docker pull catatnight/freeradius:latest
	$ wget https://raw.githubusercontent.com/catatnight/docker-freeradius/master/v2/manage.py
	$ chmod +x manage.py
	```

## Usage
1. Create container and manage it (as root)

	```bash
	$ ./manage.py [create|start|stop|restart|delete]
	```
	a) all remote clients are allowed, and access restriction could be made by firewall rules

	```bash
	$ ./manage.py -s radpass --mysql_server 1.2.3.4 -u test -p test create
	```
	b) you've maintained the clients in `nas` table

	```bash
	$ ./manage.py --readsqlclients --mysql_server 1.2.3.4 -u test -p test create
	```

## Note
+ ```default_eap_type = mschapv2 (default: md5)```
+ The following attributes are available in table `radgroupcheck`

	| id | groupname | attribute | op | value |
	|---|:---:|---|---|:---:|
	| 1 | VIP | Simultaneous-Use | := | 3 |
	| 2 | VIP | Max-Monthly-Traffic | := | 1073741824* |
	| 3 | VIP | Acct-Interim-Interval | := | 60 |
	*\*1073741824 = 1G*

## Reference
+ TBD


