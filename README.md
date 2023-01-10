# Matlab-Spice-Interface

This repository contains libraries and netlists used.
Actual_netlist_try_216.net is an example of a netlist used for benchmarking the proposed methods.
C3M0030089K contains SiC MOSFET model used.
DPT_PCB3_1MHz contains the circuit representaiton of layout parasitics extracted at 1MHz.

LTSpice-MATLAB interface will also be uploaded here in the incoming weeks, once author is done with cleaning the code and writing documentation.

Interface-code branch contains the functions used to interface LTSpice with MATLAB environment.

Examples will be uploaded in separate branches.

Core functions:
LTSM_v5 - main function for single simulation
TOP_LVL - main function for sweeps/optimisation

First run takes a bit of time, due to LTSpice path search. You can always put it in manually.

Special thanks to Peter Feicht, whose LTspice2Matlab function was used to read the LTSpice result files.
https://github.com/PeterFeicht/ltspice2matlab
