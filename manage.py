#!/usr/bin/python

import shlex, subprocess
import argparse

if __name__ == '__main__':
  app_name = 'freeradius'

  parser = argparse.ArgumentParser(description='Manage %s container' % app_name)
  parser.add_argument("execute", choices=['create','start','stop','restart','delete'], help='manage %s server' % app_name)
  parser.add_argument("-s", "--radius_secret", help="radius server secret ")
  parser.add_argument("--mysql_server", help="mysql server address ")
  parser.add_argument("-u", "--mysql_login", help="mysql server login username ")
  parser.add_argument("-p", "--mysql_passwd", help="mysql server login password ")
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
    signal_dict = {"create" : "docker run --net=host " \
                              "-e radpass={1} -e mysql_server={2} -e mysql_login={3} -e mysql_passwd={4} -e time_zone=Asia/Shanghai " \
                              "--name {0} -d catatnight/{0}" \
                              .format(app_name, args.radius_secret, args.mysql_server, args.mysql_login, args.mysql_passwd), \
                   "start"  : "docker start   %s" % app_name, \
                   "stop"   : "docker stop    %s" % app_name, \
                   "restart": "docker restart %s" % app_name, \
                   "delete" : "docker rm -f   %s" % app_name}
    if _sql :
      signal_dict['create'] = "docker run --net=host -e radpass={1} -e time_zone=Asia/Shanghai -v {2}:/opt/db --name {0} -d catatnight/{0}" \
                              .format(app_name, args.radius_secret, _sql)
    process = subprocess.Popen(shlex.split(signal_dict[signal]), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if process.stdout.readline():
      if signal == "create": signal += " and start"
      print bcolors.OKGREEN + signal + " %s successfully" % app_name + bcolors.ENDC
    else:
      _err = process.stderr.readline()
      if 'No such container' in _err:
        print bcolors.WARNING + "Please create %s container first" % app_name + bcolors.ENDC
      else: print bcolors.WARNING + _err + bcolors.ENDC
    output = process.communicate()[0]

  _execute(args.execute, args.db_path)
