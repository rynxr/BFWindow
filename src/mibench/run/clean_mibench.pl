#!/bin/env perl

use strict;
use warnings;
use Cwd;


if ($#ARGV != 0) {
	print "Usage: clean_mibench.pl <sim_config>\n";
	exit(0);
}

my $sim_config = $ARGV[0];
print "sim_config: $sim_config\n";

my ($fid_config, $i, $cmd, $cur_dir, $run_dir, $res);
my @configs = ();
my @fields;

open($fid_config, "<$sim_config") or die $!;
@configs = <$fid_config>;
close($fid_config);

$run_dir = getcwd();
system("rm -f $run_dir/mibench_summary")  if (-e "$run_dir/mibench_summary");
for ($i=0; $i<=$#configs; $i++)
{
	chomp($configs[$i]);
	next if ($configs[$i] =~ m/(^\s*$)|(^\s*#)/);

	@fields = ();
	$configs[$i] =~ s/\s+//g;
	push(@fields, split(/:/, $configs[$i]));

	# testname:dataset:bfwmode:ssconfig:rptitems
	chdir($fields[0]);
	$cur_dir = getcwd();
	print "\nindex: $i<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n";
	print "dir: $cur_dir\n";
	system("rm -rf bfw") if (-e "bfw");
	$cmd = "make -f Makefile.bfw DATASET=$fields[1] BFW_MODE=$fields[2] CFG=$fields[3] clean";
	print "cmd: $cmd\n";
	system("$cmd");

	system("echo 'clean'");
	print "index: $i>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n";

	chdir($run_dir);
}

exit(0);
