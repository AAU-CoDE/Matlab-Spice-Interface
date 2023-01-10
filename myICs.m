function ics = myICs()
global IL;
global V_dc;
IL = 1; %Testing only
V_dc = 2; %Testing only

ics(1) = makeIC('Lload', IL);
ics(length(ics) +1) = makeIC('DCPLUS_SCAP', V_dc);
ics(length(ics) +1) = makeIC('DCPLUS_BCAP', V_dc);

end