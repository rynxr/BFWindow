#!/bin/env bash

# Description: This script setup the environment for BFWindow. The hierarchy of directory tree follows `README.md`.
#              Please export the BFW_INST before sourcing this script.
# Author: jlrao <ary.xsnow@gmail.com>

if [ -z "$BFW_INST" ]; then
    echo "ERROR: Please export BFW_INST"
    return
else
    echo "INFO: Set env based on BFW_INST=$BFW_INST"
fi

export ARMSS_HOME=$BFW_INST/simple-sim-arm-0.2
export ARMCC_HOME=$BFW_INST/gcc-arm/cc/gcc-2.95.3-glibc-2.1.3/arm-unknown-linux-gnu
export BFW_HOME=$ARMSS_HOME/libbfw
export MIBENCH_HOME=$BFW_INST/mibench

export PATH=$BFW_INST/bin:$ARMSS_HOME:$ARMCC_HOME/bin:$PATH
export LD_LIBRARY_PATH=$BFW_INST/lib:$ARMCC_HOME/lib:$LD_LIBRARY_PATH

echo "INFO: PATH=$PATH"
echo "INFO: LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
echo "INFO: arm-unknown-linux-gnu-gcc=`which arm-unknown-linux-gnu-gcc`"
echo "INFO: sim-outorder=`which sim-outorder`"
echo "INFO: cilly=`which cilly`"
