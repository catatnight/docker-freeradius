#!/usr/bin/python

import shlex, subprocess
import argparse

if __name__ == '__main__':
  parser = argparse.ArgumentParser('Manage freeradius container')
  parser.add_argument("execute", choices=['create','start','stop','restart','delete'], help="create|start|stop|restart|delete freeradius server")
  parser.add_argument("-d", "--db_path", help="specify directory path stored sqlite .db file ")
  args = parser.parse_args()

  class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

  def _execute(signal,_sql):
    signal_dict = {"create" : "docker run --net=host --name freeradius -d catatnight/freeradius", \
                   "start"  : "docker start   freeradius", \
                   "stop"   : "docker stop    freeradius", \
                   "restart": "docker restart freeradius", \
                   "delete" : "docker rm -f   freeradius" }
    if _sql : signal_dict['create'] = "docker run --net=host -v " + _sql + ":/opt/db --name freeradius -d catatnight/freeradius"
    process = subprocess.Popen(shlex.split(signal_dict[signal]), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if process.stdout.readline():
      if signal == "create": signal += " and start"
      print bcolors.OKGREEN + signal + " freeradius successfully" + bcolors.ENDC
    else:
      _err = process.stderr.readline()
      if 'No such container' in _err:
        print bcolors.WARNING + "Please create freeradius container first" + bcolors.ENDC
      else: print bcolors.WARNING + _err + bcolors.ENDC
    output = process.communicate()[0]

  _execute(args.execute, args.db_path)
