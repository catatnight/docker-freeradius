From ubuntu:trusty
MAINTAINER Elliott Ye

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Upgrade base system packages
RUN apt-get update

### Start editing ###
# Install package here for cache
RUN apt-get -y install software-properties-common \
    && add-apt-repository ppa:freeradius/stable \
    && apt-get update \
    && apt-get -y install freeradius freeradius-mysql

# Add files
ADD install.sh /opt/install.sh

# Run
CMD /opt/install.sh;/usr/sbin/freeradius -f
