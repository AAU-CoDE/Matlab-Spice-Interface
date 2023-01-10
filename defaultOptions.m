function optionsString = defaultOptions()

optionsString(1) = makeOptions('abstol', 1e-12, 0, 'Absolute current error tolerance');
optionsString(2) = makeOptions('chgtol', 1e-15, 0, 'Absolute charge tolerance');
optionsString(3) = makeOptions('cshunt', 0, 0, 'Optional capacitance added from every node to ground');
optionsString(4) = makeOptions('cshuntintern', optionsString(3).value, 0, 'Optional capacitance added from every device internal node to ground.');
optionsString(5) = makeOptions('Gmin', 1e-12, 0, 'Conductance added to every PN junction to aid convergence.');
optionsString(6) = makeOptions('gminsteps', 25, 0, 'Set to zero to prevent gminstepping for the initial DC solution.');
optionsString(7) = makeOptions('gshunt', 0, 0, 'Optional conductance added from every node to ground.');
optionsString(8) = makeOptions('itl1', 100, 0, 'DC iteration count limit');
optionsString(9) = makeOptions('itl2', 50, 0, 'DC transfer curve iteration count limit.');
optionsString(10) = makeOptions('itl4', 10, 0, 'Transient analysis time point iteration count limit');
optionsString(11) = makeOptions('itl6', 25, 0, 'Set to zero to prevent source stepping for the initial DC solution.');
optionsString(12) = makeOptions('maxstep', 1, 0, 'Maximum step size for transient analysis');
optionsString(13) = makeOptions('method', 'trap', 0, 'Numerical integration method, either trapezoidal or Gear');
optionsString(14) = makeOptions('MinDeltaGmin', 1e-4, 0, 'Sets a limit for termination of adaptive gmin stepping.');
optionsString(15) = makeOptions('noopiter', 'false', 0, 'Go directly to gmin stepping.');
optionsString(16) = makeOptions('numdgt', 6, 0, 'Historically "numdgt" was used to set the number of significant figures used for output data. In LTspice, if "numdgt" is set to be > 6, double precision is used for dependent variable data.');
optionsString(17) = makeOptions('reltol', 0.001, 0, 'Relative error tolerance.');
optionsString(18) = makeOptions('srcstepmethod', 0, 0, 'Which source stepping algorithm to start with.');
optionsString(18) = makeOptions('sstol', 0.001, 0, 'Relative error for steady-state detection.');
optionsString(19) = makeOptions('topologycheck', 1, 0, 'Set to zero to skip check for floating nodes, loops of voltage sources, and non-physical transformer winding topology');
optionsString(20) = makeOptions('trtol', 1, 0, 'Set the transient error tolerance. This parameter is an estimate of the factor by which the actual truncation error is overestimated.');
end