#!/usr/bin/python

import argparse
import shlex
import subprocess

class bcolors:
	HEADER = '\033[95m'
	OKBLUE = '\033[94m'
	OKGREEN = '\033[92m'
	WARNING = '\033[93m'
	FAIL = '\033[91m'
	ENDC = '\033[0m'

app_name = 'freeradius'

parser = argparse.ArgumentParser(description='Manage %s container' % app_name)
parser.add_argument("execute", choices=['create','debug','start','stop','restart','delete'], help='manage %s server' % app_name)
parser.add_argument("-s", "--radius_secret", help="radius server secret ")
parser.add_argument("--mysql_server", help="mysql server address ")
parser.add_argument("-u", "--mysql_login", help="mysql server login username ")
parser.add_argument("-p", "--mysql_passwd", help="mysql server login password ")
parser.add_argument("--readsqlclients", action="store_true", help="read clients from nas table ")
args = parser.parse_args()

cmd_dict = { \
	"create": \
		"docker run --net=host -e radpass={1} -e mysql_server={2} -e mysql_login={3} -e mysql_passwd={4} " \
		"-e readsqlclients={5} -e time_zone=Asia/Shanghai --name {0} -d catatnight/{0}" \
		.format(app_name, args.radius_secret, args.mysql_server, args.mysql_login, args.mysql_passwd, "yes" if args.readsqlclients else "no"), \
	"debug": \
		"docker run --net=host -e radpass={1} -e mysql_server={2} -e mysql_login={3} -e mysql_passwd={4} " \
		"-e readsqlclients={5} -e time_zone=Asia/Shanghai --name {0} -it catatnight/{0} /bin/bash" \
		.format(app_name, args.radius_secret, args.mysql_server, args.mysql_login, args.mysql_passwd, "yes" if args.readsqlclients else "no"), \
	"start": "docker start %s" % app_name, \
	"stop": "docker stop %s" % app_name, \
	"restart": "docker restart %s" % app_name, \
	"delete" : "docker rm -f %s" % app_name }
cmd_key = args.execute

if cmd_key == 'debug':
	process = subprocess.call(shlex.split(cmd_dict[cmd_key]))
	exit(0)

process = subprocess.Popen(shlex.split(cmd_dict[cmd_key]), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
if process.stdout.readline():
	print bcolors.OKGREEN + cmd_key + " %s successfully" % app_name + bcolors.ENDC
else:
	stderr = process.stderr.readline()
	if 'No such container' in stderr:
		print bcolors.WARNING + "Please create %s container first" % app_name + bcolors.ENDC
	else:
		print bcolors.WARNING + stderr + bcolors.ENDC
output = process.communicate()[0]
