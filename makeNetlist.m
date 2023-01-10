function netList = makeNetlist(components,options,libraries, ic1, analysisString, pathString, adapticString)

%%prepare strings from structures
global IL;
global V_dc;
global paramString;
global fileName

%Component string

length(components);
for i = 1:length(components)
components(i).string = sprintf('%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s', components(i).name,components(i).nodes{:}, components(i).type);
end

compString = components(1).string;
for i = 2:length(components)
    compString = sprintf('%s\r\n%s',compString,components(i).string);
end

%Option string

for i = 1:length(options)
option(i).string = sprintf('%s %s %s %s ', '.options', options(i).name, '=', string(options(i).value));
end

optionsString = option(1).string;
for i = 2:length(option)
    optionsString = sprintf('%s\r\n%s',optionsString,option(i).string);
end

%Libraries string

libString = sprintf('.include %s.%s', libraries(1).name, libraries(1).extension);
for i = 2:length(libraries)
    libString = sprintf('%s\r\n.include %s.%s',libString, libraries(i).name, libraries(i).extension);
end

%Parameter string

%paramString = sprintf('.params Rg = %d V_dc = %d Lload = %d Rgnd = %d Cg = %d', Rg, V_dc, L_load, R_ground, Cg);

%initial condition string <-- make extra function for detecting the type

icString = sprintf('.ic I(Lload)= %d \r\n .ic V(DCPLUS_SCAP)= %d \r\n .ic V(DCPLUS_BCAP)= %d', IL, V_dc, V_dc);

%analysis string

endString = sprintf('.backanno\r\n.end\r\n');

%% print the netlist

netList = sprintf('%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s',pathString,compString,paramString,analysisString,optionsString,libString,adapticString,sprintf('.model MyDiode D(+IS=1e-07 RS=0.0685826 N=0.776978 EG=0.6 XTI=3.94234 BV=35 IBV=0.665074 CJO=3.78999e-10 VJ=0.484208 M=0.480643 FC=0.5 TT=0 KF=0 AF=1'),endString); 
netName = sprintf('%s.net',fileName);
fileID = fopen(netName,'w');
fprintf(fileID,netList);
fclose('all');

end