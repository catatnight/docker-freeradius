docker-nginx-php5
==========

 A Dockerfile which produces a docker image that runs Nginx with PHP5.

## Requirement
+ Docker 1.0

## Features
+ Ubuntu Trusty
+ Nginx 1.6
+ PHP 5.5
+ PHP Modules: php5-common php5-fpm php5-cli php5-dev php-apc php-pear

## Usage
1. Run directly

	```bash
	docker pull catatnight/nginx-php5
	docker run -p 80:80 -v <data-dir>:/data --name app -d catatnight/nginx-php5
	```
2. As base image in `Dockerfile`

	```bash
	From catatnight/nginx-php5
	RUN apt-get -y install php5-mysql ...
	...
	```

## Note
+ The Nginx server is configured to host a website from the `/data` folder inside the container.

## Reference
+ [Painted-Fox/docker-nginx-php5](https://github.com/Painted-Fox/docker-nginx-php5)
+ TBD
