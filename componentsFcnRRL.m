function components = componentsFcnRRL()

% Function specifying default components

components(1) = makeComponent('Rgnd', '{Rgnd}', {0},{'0', 'T1MID'});
%components(2) = makeComponent('Rg2', '{Rg2}', 0.1, {'Source_GDOUT','Rgp'});
%components(3) = makeComponent('Vg', 'PWL(0 0 605n 0 645n 15 1365n 15 1405n 0)', {0}, {'GDH_SINK','0'});
components(3) = makeComponent('Vg', 'PWL(0 0 605n 0 645n 15 1365n 15 1405n 0)', {0}, {'GDH_SINK','0'});
%components(4) = makeComponent('Vdc', '{V_dc}', {'DCPLUS_SRC','DCMIN_Source'});
components(34) = makeComponent('Vdc1', '{V_dc}', {0}, {'DCPLUS_BCAP','DCMIN_BIGCAP'});
%components(5) = makeComponent('Ludc', '{Ludc}', {'3','Udc'});
%components(6) = makeComponent('Lddc', '{Lddc}', {'0','7'});
components(7) = makeComponent('Lload', '{Lload}', {0}, {'DCPLUS_LLOAD', 'L_SOURCE'});
components(8) = makeComponent('Vtemp', '25', {0}, {'Utmp','0'});
%components(9) = makeComponent('Ld', '{Ld}', {'Ut1','5'});
%components(10) = makeComponent('Ls1', '{Ls1}', {'Ust1','0'});
%components(11) = makeComponent('Ls2', '{Ls2}', {'6','0'});
%components(12) = makeComponent('Lg_ext', '{Lg_ext}', {'2','Ug'});
%components(13) = makeComponent('D', 'MyDiode',  {0}, {'Rgp1','Rgp'});
components(14) = makeComponent('Rg', '{Rg}', 0.1, {'Rgp','Source_GDOUT'});
%components(15) = makeComponent('Cgat', '40n', {0}, {'GDH_Source','0'});
components(16) = makeComponent('XTL', 'C3M0030090K', {0}, {'LOWDRN_SOURCE', 'Source_TG', 'Kelvin_Source', 'ISHUNT_SOURCE', 'Utmp', 'Utmp'});
components(17) = makeComponent('XTU', 'C3M0030090K', {0}, {'DCPLUS_TOPFET', 'Ts', 'Ts', 'TOPSRC_SINK', 'Utmp', 'Utmp'});
components(18) = makeComponent('Cdc1', '4.7u', {0}, {'DCPLUS_BCAP1', 'DCMIN_BIGCAP'}); %4.7u +/-10%
components(25) = makeComponent('Cdc2', '100n', {0}, {'DCPLUS_SCAP1', 'DCMIN_SCAP'}); %100n +/-10%
components(19) = makeComponent('Lgext', '0.1n', {0}, {'Rgp', 'Sink_TG'}); %original Lg 5n
components(20) = makeComponent('Rvp', '7m', {0}, {'DCPLUS_BCAP','DCPLUS_BCAP1'}); % p15m,m10m originally
components(21) = makeComponent('Rvm', '70m', {0}, {'DCPLUS_SCAP', 'DCPLUS_SCAP1'}); %500m good
components(22) = makeComponent('Rprobe', '10MEG', {0}, {'VMEAS_SOURCE','0'});
components(23) = makeComponent('Cprobe', '10p', {0}, {'VMEAS_SOURCE','0'});
%components(26) = makeComponent('Rload', '0.1',{0}, {'L_SOURCE1','L_SOURCE'});

components = components(all(~cellfun(@isempty,struct2cell(components))));


end