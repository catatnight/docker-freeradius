From ubuntu:trusty
MAINTAINER Elliott Ye

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Upgrade base system packages
RUN apt-get update

### Start editing ###
# Install package here for cache
RUN apt-get -y install software-properties-common \
    && add-apt-repository ppa:freeradius/stable-3.0 \
    && apt-get update \
    && apt-get -y install freeradius freeradius-mysql openssl libssl1.0.0

# Add files

# Configure
ENV radpass      radpass
ENV sql_driver   mysql|sqlite
ENV mysql_server ip.O.R.hostname
ENV mysql_login  username
ENV mysql_passwd password
ENV sqlite_db    db.sqlite3
ENV time_zone    Asia/Shanghai

# Initialization 
ADD assets/install.sh /opt/install.sh
RUN /opt/install.sh 

# Run
CMD ["/usr/sbin/freeradius","-f"]
