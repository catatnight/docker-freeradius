From ubuntu:latest
MAINTAINER Elliott Ye

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# upgrade base system packages
RUN apt-get update

# Start editing
#install package here for cache
RUN apt-get -y install python-software-properties  \
    && add-apt-repository ppa:freeradius/stable \
    && apt-get update \
    && apt-get -y install freeradius freeradius-mysql 

# Add files

# Configure
ENV radpass      Your Radpass
ENV mysql_server Your Mysql Server ip or Address
ENV mysql_login  Your Mysql Username
ENV mysql_passwd Your Mysql Password
ENV time_zone    Asia/Shanghai

# Initialization 
ADD assets/install.sh /opt/install.sh
RUN chmod 755 /opt/*.sh && /opt/install.sh 

# Run
CMD ["/usr/sbin/freeradius","-f"]
