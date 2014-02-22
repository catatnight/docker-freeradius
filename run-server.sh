#!/bin/bash

docker run -p 1812:1812/udp -p 1813:1813/udp -name freeradius -d catatnight/freeradius-mysql
