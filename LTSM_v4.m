%%% LTSPICE MATLAB INTERFACE V5 %%%
% A - matrix of sweep parameter values
% adapticString - string of initial conditions based on former simulations
% SweepInfo - diagnostic info passed/modified during the sweep containing
% resimulation settings and simulation timeout value
% Out - matrix of calculated parameters based on simulation
% result - simulation result file in case if needed
% New_IC - the IC string based on this simulation run
% Info - extra diagnostic for this simulation for loading into SweepInfo

function [Out, result, New_IC, Info] = LTSM_v4 (A,adapticString,SweepInfo)

%% variable / sweep loading specification
Params = [{'Rg'}];
Rg = A(1);
%Cgd = A(2);

%%Global parameters used
global fileName;
global components;
global options;
global libraries;
global ic1;
fileName = 'Actual_netlist_try_216';

%% find paths
Dirs = setDirectories("XVIIx64.exe"); %In case the LTSPICE is not on drive C, you have to manually change it.  //maybe a drive name in input??
spicePath = char (Dirs(1)); % This is the path to your LT Spice installation
filePath = char(Dirs(2)); %This is the path where you want the netlist, functions and simulation outputs to reside
netPath = char(Dirs(3)); % This is same as file path but all \ are replaced by \\ because of some Matlab issue in writing Netlist.
global fileName;
fileName = 'Actual_netlist_try_216';
%% component specification

global components;
components = componentsFcnRRL; %or
%components(1) = makeComponent (compName,type, tolerance, Nodes); %or
%components = load(filename);

%% subcircuit specification
components(length(components) + 1) = makeComponent('XParas', 'DPT_PCB3_1_800kHz', {0}, {'DCPLUS_LLOAD','DCPLUS_SCAP', 'DCPLUS_TOPFET', 'Source_GDOUT', 'ISHUNT_SINK',...
    'DCMIN_SCAP', 'Kelvin_Source', 'ISHUNT_SOURCE', 'Source_TG', 'L_SOURCE', 'LOWDRN_SOURCE', 'VMEAS_SOURCE',...
     'GDH_Source', 'DCPLUS_BCAP', 'GDH_Source', 'DCMIN_BIGCAP', '0', 'ISHUNT_SINK', 'Sink_TG', 'TOPSRC_SINK', 'GDH_SINK'} );

%components(length(components) + 1) = fetchSubcircuitNodenames(cirfilename); % to be prepared

%%options and simulation specification


%options = defaultOptions;
global options;
options = myOptions; %just a function with current options
%options(1) = makeOptions(optName, optValue, optStep, optDescr); %or
%options = load(filename);

%% include libraries etc

%libraries= fetchLibraries(components);  %To be done
%libraries(1) = makelib(name, extension); % for now long extensions, maybe change cir to c, lib to l
global libraries;
libraries = myLibs; % just my current libraries

%setup initial conditions

%ic1(1) = makeIC(name, value); %
global ic1;
ic1 = myICs;
%ic2 = checkforinheritedic;  %important to be made

%Looping counter set

condition_for_resimulation = 1;
optcnt = 0;
compcnt = 0;
condition = 0;

%% Start looping
while (condition_for_resimulation)
    
    %parameter set <-- detect the parameters

    global paramString;
    paramString = sprintf('.params Rg = %d V_dc = %d Lload = %d Rgnd = %d', Rg, V_dc, 103e-6, 1e6);

    % netlist prep
    endtime = 5e-6;
    maxstep = 1e-9;
    savingStart = 1e-9;
    analysisString = tranSim( maxstep, endtime, savingStart); %only tran supported
    pathString = sprintf('* %s%s.asc',netPath, fileName);
    
    makeNetlist( components,options,libraries, ic1, analysisString, pathString, adapticString); %use the existing objects to assemble a netlist
    %tic
    %simulate
    result = simulateModel(spicePath, fileName, filePath, endtime);
    %toc
    %Parameter calculation
    

    %mysignal1 = fetchsignals(Element);
    %param1 = Esw(result);
    [param2, param3] = maxVds(result);

    %set output

    Out (1) = 1;
    Out (2) = param2;
    Out (3) = param3;

    %checkforNaNs and stuff

    if ~select(2) == 1
        compcnt = 6
    end

    if ~select(1) == 1 
        compcnt = 3;
    end

    if compcnt < 3
    condition = adaptComponents(Out, Params, components); %condition return 0 when no change
    compcnt = compcnt + 1
    else
        condition = 0;
    end

    if ((compcnt + optcnt < 5) && (compcnt == 3))
    condition = adaptOptions(Out, options);
    optcnt = optcnt + 1;
    else 
    if (compcnt + optcnt == 5)
        iterationcap = 0;
    end
    end

    

    %adaptIC if specified
    if (select(3) && (sum(isnan(Out))== 0)) == 1
    New_IC = adaptIC(result); %or nodes??
    else
        New_IC = adapticString;
    end


    %resim option
    condition_for_resimulation = condition;
    %condition_for_resimulation = 0;


end
end