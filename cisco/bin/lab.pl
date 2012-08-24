#!/usr/bin/perl
#
#
#
#
use strict;
use warnings;
use local::lib;
use IO::Prompt;
use Net::SSH::Expect;
#use local::lib "$IO::Prompt";
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

####Actual code
my $username = prompt('Username: ');
my $password = prompt('Password: ', -echo => '*');
my $device = prompt('Device to connect: ');
my $tftphost = "";
#
my $ssh = Net::SSH::Expect-> new (
    host => $device,
    password=> $password,
    user => $username,
#    exp_debug => 1,
    ssh_option => '-o StrictHostKeyChecking=no',
    timeout => 10,
    log_file => "$device.ssh.log",
    raw_pty => 1
);
eval {my $login_output = $ssh->login()};
if ($@) {
    print "SSH error\n$@\n";
    print LOG "SSH error \n";
}
#
eval {codeupgrade()};
eval {backup()};
#
sub codeupgrade
{
    print "connected to $device\n";
    my $text = $ssh ->exec("sh ver | include image");
    $ssh ->waitfor('#', 5, -ex);
    print $text;
    return;
}
sub backup 
{
    $ssh->send("copy run tftp://$tftphost/$device-conf");
    $ssh->waitfor('?', 5, -ex);
    $ssh->send("\n");
    $ssh->waitfor('?', 5, -ex);
    $ssh->send("\n");
    $ssh->waitfor('#', 5, -ex);
    return;
}
sub pushnewconfig
{
    my $newconfig = prompt("Path to newconfig: ");
    $ssh->send("copy tftp://$tftphost/$newconfig run");
    return;
}
