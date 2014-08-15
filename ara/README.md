Docker-ARA
==========

 ARA - a FreeRADIUS web interface in Docker

## Requirement
+ Docker 1.0

## Installation
1. Pull image (as root)

	```bash
	$ docker pull catatnight/ara
	```

2. Import ```user-info``` table to ```radius``` database

	```bash
	$ wget https://raw.githubusercontent.com/catatnight/docker-ara/master/da.sql
	$ mysql -uradius -p radius < da.sql
	```

## Usage
1. Create container (as root)

	```bash
	docker run -p 8080:80 -e mysql_server=1.2.3.4 -e mysql_login=radius -e mysql_passwd=radius -e admin_passwd=123456 \
	 --name ara -d catatnight/ara
	```

2. You can visit web client on http://your.host.name:8080 with admin/`$admin_passwd`

## Note
+ TBD

## Reference
+ [ara - Trac](http://labs.asn.pl/ara/)
+ [ASN RADIUS Admin 安装指南 - WangYan Blog](http://wangyan.org/blog/ara-install-guide.html)
+ TBD
