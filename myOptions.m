function options = myOptions()

options(1) = makeOptions('method', 'gear', 0, 'non');
options(2) = makeOptions('gmin', 1e-12, 0, 'non');
options(3) = makeOptions('abstol', 1e-12, 0, 'non');
options(4) = makeOptions('reltol', 0.0005, 0.1, 'non');
%options(5) = makeOptions('chgtol', 1e-14, 0, 'non');
%options(6) = makeOptions('trtol', 1, 0, 'non');
%options(7) = makeOptions('vntol', 1e-7, 0, 'non');
%options(8) = makeOptions('sstol', 0.001, 0, 'non');
%options(9) = makeOptions('cshunt', 1e-17, 0, 'non');
%options(10) = makeOptions('mindeltagmin', 0.00001, 0, 'non');


end