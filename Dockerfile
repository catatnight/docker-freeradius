From ubuntu:latest
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
    && apt-get -y install freeradius freeradius-mysql 

# Add files

# Configure
ENV radpass      radpass
ENV sql_driver   mysql|sqlite
ENV mysql_server ip.O.R.hostname
ENV mysql_login  username
ENV mysql_passwd password
ENV sqlite_db    db_filename.db
ENV time_zone    Asia/Shanghai

# Initialization 
ADD assets/install.sh /opt/install.sh
RUN /opt/install.sh 

# Run
CMD ["/usr/sbin/freeradius","-f"]
