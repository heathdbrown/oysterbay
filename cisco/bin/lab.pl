#!/usr/bin/perl
#
#
#
#
use strict;
use warnings;

#   - Ask how we want to connect
#	- ssh
#	- console
#	- snmp
#   - Set variable for how to connect
#
#   - If SSH	
#	- Ask for username TACACS
#	- Ask for password TACACS
#	- Store username
#	- Store password
#   - If console
#	- Readin username for console from config file
#	- Readin password for console from config file
#	- Store username
#	- Store password
#   - If snmp
#	- Readin snmp string from config file
#	- Store snmp string
#   - What task do we want to perform?
#	- backup
#		- Copy running configuration to server via tftp
#	- codeupgrade
#		- Upgrade code from tftp, http, scp, or ftp server
#	- pushnewconfig
#		- Push a new configuration from server
#	- testlab
#		- Test to make sure lab is working correctly
#	- labreset
#		- backup
#		- overwrite old config
#			- Use original configuraiton to overwrite
