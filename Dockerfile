From ubuntu:trusty
MAINTAINER Elliott Ye

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update

# Start editing
#install package here for cache
RUN apt-get -y install supervisor software-properties-common git-core wget unzip\
	&& add-apt-repository ppa:nginx/stable \
	&& apt-get update \
	&& apt-get -y install nginx \
	&& add-apt-repository ppa:chris-lea/php5.5 \
	&& apt-get update \
	&& apt-get -y install php5-common php5-fpm php5-cli php5-mysql php-pear \
	&& pear channel-update pear.php.net \
	&& pear install HTML_Template_Sigma
RUN git clone git://git.asn.pl/asn/ara && mkdir /var/www && ln -s /ara/src/htdocs/ /var/www/ara \
	&& wget http://wangyan.org/download/src/ara-0.6-cn.zip && unzip ara-0.6-cn.zip \
	&& cp -R ara-0.6-cn/* /ara/src/

# Add files
ADD assets/config.php /ara/src/config/config.php
ADD assets/admin.php /ara/src/config/users/admin.php
ADD assets/install.sh /opt/install.sh

# Run
CMD /opt/install.sh;/usr/bin/supervisord -c /etc/supervisor/supervisord.conf