From catatnight/nginx-php5
MAINTAINER Elliott Ye

# Install package here for cache
RUN apt-get -y install git wget unzip php5-mysql \
	&& pear channel-update pear.php.net && pear install HTML_Template_Sigma
RUN git clone git://git.asn.pl/asn/ara && ln -s /ara/src/htdocs /data \
	&& wget http://wangyan.org/download/src/ara-0.6-cn.zip && unzip ara-0.6-cn.zip \
	&& cp -R ara-0.6-cn/* /ara/src/ \
	&& rm -rf ara-0.6-cn ara-0.6-cn.zip

# Add files
ADD assets/config.php /ara/src/config/config.php
ADD assets/admin.php /ara/src/config/users/admin.php
ADD assets/install.sh /opt/install.sh

# Run
CMD /opt/install.sh;/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
