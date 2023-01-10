% Function for makeNetlis testing

%Provide values for composing the netlist

% Variant lite: no ICs from old sims
adapticString = ' .ic I(Lload)=10';
Rg = 10;

Dirs = setDirectories("XVIIx64.exe"); %In case the LTSPICE is not on drive C, you have to manually change it.  //maybe a drive name in input??
spicePath = char (Dirs(1)); % This is the path to your LT Spice installation
filePath = char(Dirs(2)); %This is the path where you want the netlist, functions and simulation outputs to reside
netPath = char(Dirs(3)); % This is same as file path but all \ are replaced by \\ because of some Matlab issue in writing Netlist.

fileName = 'TestNet_Lite';

components = componentsFcnRRL;
options = myOptions;
libraries = myLibs;
ICs = myICs;
Params(1) = makeParam('Name', 'Value');
Params(2) = makeParam('Name2', 'Value2');
endtime = 5e-6;
    maxstep = 1e-9;
    savingStart = 1e-9;
    analysisString = tranSim( maxstep, endtime, savingStart); %only tran supported
    pathString = sprintf('* %s%s.asc',netPath, fileName);
    
    makeNetlis_v2(components,options,libraries, ICs, analysisString, pathString, adapticString, Params, fileName); %use the existing objects to assemble a netlist

% Variant full: ICs from older sims present
%% 

%adapticString = ' .ic I(Lload)=10';
Rg = 10;

Dirs = setDirectories("XVIIx64.exe"); %In case the LTSPICE is not on drive C, you have to manually change it.  //maybe a drive name in input??
spicePath = char (Dirs(1)); % This is the path to your LT Spice installation
filePath = char(Dirs(2)); %This is the path where you want the netlist, functions and simulation outputs to reside
netPath = char(Dirs(3)); % This is same as file path but all \ are replaced by \\ because of some Matlab issue in writing Netlist.

fileName = 'TestNet_Lite';

adapticString = ".ic I(Lload)=40 "

components = componentsFcnRRL;
options = myOptions;
libraries = myLibs;
ICs = myICs;
Params(1) = makeParam('Name', 'Value');
Params(2) = makeParam('Name2', 'Value2');
endtime = 5e-6;
    maxstep = 1e-9;
    savingStart = 1e-9;
    analysisString = tranSim( maxstep, endtime, savingStart); %only tran supported
    pathString = sprintf('* %s%s.asc',netPath, fileName);
    
    makeNetlis_v2(components,options,libraries, ICs, analysisString, pathString, adapticString, Params, fileName); %use the existing objects to assemble a netlist

% IC pattern match check: Conflict between two ICs (adaptic vs hard coded)