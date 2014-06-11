#!/usr/bin/python

import shlex, subprocess
import argparse

if __name__=="__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("execute", help="start|stop|restart freeradius server")
  args = parser.parse_args()

  def _start():
    bashCommand = "docker run --net=host --name freeradius -d catatnight/freeradius-mysql"
    process = subprocess.Popen(shlex.split(bashCommand))
    output = process.communicate()[0]

  def _stop():
    bashCommand = "docker rm -f freeradius"
    process = subprocess.Popen(shlex.split(bashCommand))
    output = process.communicate()[0]

  if args.execute== "start":
    _start()
  elif args.execute== "stop":
    _stop()
  elif args.execute== "restart":
    _stop()
    _start()
