#!/usr/bin/perl 
use strict;
use warnings;

print "Hello, World\n";
#Comment
#
#Whitespace don't matter
print
"Whitespace don't matter\n
"
;

#put linebreak in middle
print "line 
break\n";

#quoting
print "Doubles";
print 'single';

my $name = "bob";
print "Hello, $name\n double";
print 'Hello, $name\n single';
print "\n";

#numbers don't need quotes
print 42;
print "\n";

#parentheses used for function args or precedence
print ("parentheses, in action\n");
print "parentheses free\n";
