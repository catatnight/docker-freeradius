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
    && apt-get -y install freeradius freeradius-mysql \
    && sudo bash -c 'echo "Asia/Shanghai" > /etc/timezone' && dpkg-reconfigure -f noninteractive tzdata
    
# Add files
#freeradius
ADD assets/install.sh /opt/install.sh
RUN chmod 755 /opt/*.sh && /opt/install.sh

# Ports
EXPOSE 1812/udp
EXPOSE 1813/udp

CMD ["/usr/sbin/freeradius","-f"]
