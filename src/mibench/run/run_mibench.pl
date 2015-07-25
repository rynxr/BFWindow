#!/bin/env perl

use strict;
use warnings;
use Cwd;


if ($#ARGV != 0) {
	print "Usage: run_mibench.pl <sim_config>\n";
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
	system("cp -rf $run_dir/bfw_cfg ./bfw");
	$cmd = "touch bfw *.c &&  make -f Makefile.bfw DATASET=$fields[1] BFW_MODE=$fields[2] CFG=$fields[3] all " . "> run_info 2>&1";
	print "cmd: $cmd\n";
	system("$cmd");

	#$res = `tail -n $fields[4] run_info`;
	$res = `grep 'BFW_RES:' run_info`;
	system("cp -f run_info run_info_$fields[1]_$fields[2]");
	system("echo '$res' | tee -a $run_dir/mibench_summary");
	print "index: $i>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n";

	chdir($run_dir);
}

exit(0);
