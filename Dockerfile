From ubuntu:latest
MAINTAINER Elliott Ye

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# upgrade base system packages
RUN apt-get update

# Start editing
#install package here for cache
RUN apt-get -y install supervisor
RUN apt-get -y install python-software-properties  \
    && add-apt-repository ppa:freeradius/stable \
    && apt-get update \
    && apt-get -y install freeradius freeradius-mysql

# Add files
#freeradius
ADD assets/run-radius.sh /opt/run-radius.sh
#supervisor
ADD assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod 755 /opt/*.sh

# Configure
ENV radpass Your Radpass   
ENV mysql_server Your Mysql Server ip or Address
ENV mysql_login  Your Mysql Username
ENV mysql_passwd Your Mysql Password

# Ports
EXPOSE 1812/udp
EXPOSE 1813/udp

CMD ["/usr/bin/supervisord"]
