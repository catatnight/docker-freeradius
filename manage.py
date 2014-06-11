#!/usr/bin/python

import shlex, subprocess
import argparse

if __name__=="__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("execute", help="start|stop|restart spdyproxy server")
  args = parser.parse_args()
  if args.execute== "start":
    bashCommand = "docker run --net=host --name freeradius -d catatnight/freeradius-mysql"
    process = subprocess.Popen(shlex.split(bashCommand))
    output = process.communicate()[0]
  elif args.execute== "stop":
    bashCommand = "docker rm -f freeradius"
    process = subprocess.Popen(shlex.split(bashCommand))
    output = process.communicate()[0]
  elif args.execute== "restart":
    bashCommand = "docker rm -f freeradius"
    process = subprocess.Popen(shlex.split(bashCommand))
    output = process.communicate()[0]
    bashCommand = "docker run --net=host --name freeradius -d catatnight/freeradius-mysql"
    process = subprocess.Popen(shlex.split(bashCommand))
    output = process.communicate()[0]
