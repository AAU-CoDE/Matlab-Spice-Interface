function netList = makeNetlis_v2(components,options,libraries, ICs, analysisString, pathString, adapticString, Params, fileName)
%% Function to compose a netlist from interface objects
%  Part 1: Translate interface objects into strings
%  Part 2: Check the ICs
%  Part 3: Compose and save the netlist.

%%prepare strings from structures
%global paramString;
global fileName

%Component string

length(components);
for i = 1:length(components)
    components(i).string = sprintf('%s',components(i).name);
    for j = 1:length(components(i).nodes)
        components(i).string = sprintf('%s %s ',components(i).string,string(components(i).nodes(j)));
    end
    components(i).string = sprintf('%s %s',components(i).string, components(i).type);
%components(i).string = sprintf('%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s', components(i).name,components(i).nodes{:}, components(i).type);
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

for i = 1:length(Params)
param(i).string = sprintf('%s %s %s ', Params(i).name, '=', Params(i).value);
end

paramString = param(1).string;
for i = 2:length(param)
    paramString = sprintf('%s %s',paramString,param(i).string);
end

paramString = sprintf('.params %s', paramString);

%paramString = sprintf('.params Rg = %d V_dc = %d Lload = %d Rgnd = %d Cg = %d', Rg, V_dc, L_load, R_ground, Cg);

%%initial condition string <-- make extra function for detecting the type

%icString = sprintf('.ic I(Lload)= %d \r\n .ic V(DCPLUS_SCAP)= %d \r\n .ic V(DCPLUS_BCAP)= %d', IL, V_dc, V_dc);

%IC handling part 1: check if adaptic string is empty and if so, print ICs
if isempty(adapticString)
    %print ICs (if any)
    if ~isempty(ICs)
        for i = 1:length(ICs)
            adapticString = sprintf('%s/r/n %s = %s', adapticString, ICs(i).Element, num2str(ICs(i).value));
        end
    end
else
%IC handling part 2: else, check for doubles with ICs and replace
    for i = 1:length(ICs)
        pattern = string(ICs(i).Element) + ")="  + digitsPattern; %debug this bastard
        adapticString = replace(adapticString,pattern,sprintf("%s)=%d",ICs(i).Element,ICs(i).Value));

        pattern = string(ICs(i).Element) + ") = "  + digitsPattern; %debug this bastard
        adapticString = replace(adapticString,pattern,sprintf("%s)=%d",ICs(i).Element,ICs(i).Value));

        pattern = string(ICs(i).Element) + ")= "  + digitsPattern; %debug this bastard
        adapticString = replace(adapticString,pattern,sprintf("%s)=%d",ICs(i).Element,ICs(i).Value));

        pattern = string(ICs(i).Element) + ") ="  + digitsPattern; %debug this bastard
        adapticString = replace(adapticString,pattern,sprintf("%s)=%d",ICs(i).Element,ICs(i).Value));
    end
end
%IC handling part 3: check if all the ICs were used for replacement,
%IC handling part 4: if they weren't, print unused at the end of adaptic
%IC handling part 5: if any was printed more than once, raise an
%error/warning

%analysis string
extrasString = " ";

endString = sprintf('.backanno\r\n.end\r\n');

%% print the netlist

netList = sprintf('%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s'...
    ,pathString,compString,paramString,analysisString,optionsString,libString,adapticString,extrasString,endString); 
netName = sprintf('%s.net',fileName);
fileID = fopen(netName,'w');
fprintf(fileID,netList);
fclose('all');

end