#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2018.3 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Wed Apr 24 14:18:48 PDT 2019
# SW Build 2405991 on Thu Dec  6 23:36:41 MST 2018
#
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep xelab -wto 19e17cd5c1c14c1baa3ee85d0e03626f --incr --debug typical --relax --mt 8 -d "SIM=" -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_fact_behav xil_defaultlib.tb_fact xil_defaultlib.glbl -log elaborate.log