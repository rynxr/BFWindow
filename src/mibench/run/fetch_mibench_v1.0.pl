#!/bin/env perl
#================================================================
# Desc  : This script is going to fetch MiBench from MiBench home
#         to current local directory for simulation.
# Author: jlrao <ary.xsnow@gmail.com>
# Date  : Sat May 23 10:12:51 CST 2015
#================================================================

use strict;
use warnings;

my @targets = ("office", "network", "consumer", "automotive", "telecomm", "security");
my $web = "http://wwweb.eecs.umich.edu/mibench/";
my ($cmd, $target, $addr);
my ($i);

for ($i=0; $i<=$#targets; $i++) {

	# source
	$target = $targets[$i] . ".tar.gz";
	$addr = $web . $target;
	$cmd = "wget $addr";
	print "INFO: get $target from $addr...\n";
	print "      cmd = $cmd\n";
	system("$cmd") == 0 or die "ERROR: $cmd FAIL!\n";

	#output
	$target = $targets[$i] . "_output.tar.gz";
	$addr = $web . $target;
	$cmd = "wget $addr";
	print "INFO: get $target from $addr...\n";
	print "      cmd = $cmd\n";
	system("$cmd") == 0 or die "ERROR: $cmd FAIL!\n";
}

print "INFO: Done! Good Luck!\n";

exit(0);
