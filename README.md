# Matlab-Spice-Interface

This repository contains libraries and netlists used.
Actual_netlist_try_216.net is an example of a netlist used for benchmarking the proposed methods.
C3M0030089K contains SiC MOSFET model used.
DPT_PCB3_1MHz contains the circuit representaiton of layout parasitics extracted at 1MHz.

LTSpice-MATLAB interface is available in the Interface-Code branch of this repository.
In order to run the example,  simply download the branch and run TOP_LVL.m.
First run may take some time due to the search for LTSpice path over the drive.

Main functions of the interface:
- TOP_LVL.m 
- LTSM_v5.m
- make_Netlis_v2.m
- simulateModel.m
