function [Out, New_IC, Info] = LTSM_v5 (A,adapticString,SweepInfo)

%%% LTSPICE MATLAB INTERFACE V5 %%%
% A - matrix of sweep parameter values
% adapticString - string of initial conditions based on former simulations
% SweepInfo - diagnostic info passed/modified during the sweep containing
% resimulation settings and simulation timeout value
% Out - matrix of calculated parameters based on simulation
% result - simulation result file in case if needed
% New_IC - the IC string based on this simulation run
% Info - extra diagnostic for this simulation for loading into SweepInfo

%% variable / sweep loading specification
sweepVariables = [{'RG1'}]; %needed for adaptComponents, otherwise can be ignored
RG1 = A(1);
%Cgd = A(2);

%%Global parameters used further
global fileName;
%global components;
%global options;
%global libraries;
global ic1;
fileName = 'Actual_netlist_try_217';

%% find paths
Dirs = setDirectories("XVIIx64.exe"); %In case the LTSPICE is not on drive C, you have to manually change it.  //maybe a drive name in input??
spicePath = char (Dirs(1)); % This is the path to your LT Spice installation
filePath = char(Dirs(2)); %This is the path where you want the netlist, functions and simulation outputs to reside
netPath = char(Dirs(3)); % This is same as file path but all \ are replaced by \\ because of some Matlab issue in writing Netlist.

%% component specification

components = componentsFcnQuadrat004; %or
%components(1) = makeComponent (compName,type, tolerance, Nodes); %or
%components = load(filename); %or
%[Libs, Options, ICs, Params, Extras, netlist, Components] = importNetlist()

%% Extra subcircuit specification

%components(length(components) + 1) = fetchSubcircuitNodenames(cirfilename); % to be prepared

%%options and simulation specification


options = myOptions; %just a function with current options
%options(1) = makeOptions(optName, optValue, optStep, optDescr); %or
%options = load(filename);

%% include libraries etc

%libraries= fetchLibraries(components);  %To be done
%libraries(1) = makelib(name, extension); % for now long extensions, maybe change cir to c, lib to l
libraries = myLibs; % just my current libraries

%setup initial conditions

%ic1(1) = makeIC(name, value); %

ICs = myICs;    % Hardcoded IC, they will always overwrite inherited IC values for specified components/nodes

%Set netlist parameters

Params(1) = makeParam('RG1', RG1);
Params(2) = makeParam('RS', A(2));
Params(3) = makeParam('ton', 100e-9);
Params(4) = makeParam('toff', 600e-9);
Params(5) = makeParam('tend', 1000e-9);


%Looping counter set

condition_for_resimulation = 1;
optcnt = 0;
compcnt = 0;
condition = 0;

%% Start looping
while (condition_for_resimulation)
    
    

    %global paramString;
    %paramString = sprintf('.params Rg = %d V_dc = %d Lload = %d Rgnd = %d', Rg, 200, 103e-6, 1e6);

    % netlist prep
    endtime = SweepInfo.endtime;
    maxstep = 1e-9;
    savingStart = 1e-9;
    startime = toc;
    analysisString = tranSim( endtime); %only tran supported
    pathString = sprintf('* %s%s.asc',netPath, fileName);
    
    makeNetlis_v2(components,options,libraries, ICs, analysisString, pathString, adapticString, Params); %use the existing objects to assemble a netlist
    %tic
    %simulate
    result = simulateModel(spicePath, fileName, filePath, endtime, SweepInfo.killtime);
    %toc
    %Output values/functions calculation
    
    
    %mysignal1 = fetchsignals(Element);
    %outVar1 = Esw(result);
    %[outVar2, overVar3] = maxVds(result);
    

    ind1 = find(strcmp(result.variable_name_list,'Ix(q1:D)'));
    ind2 = find(strcmp(result.variable_name_list,'Ix(q2:D)'));
    ind3 = find(strcmp(result.variable_name_list,'Ix(q3:D)'));
    ind4 = find(strcmp(result.variable_name_list,'Ix(q4:D)'));

    It1 = result.variable_mat(ind1,:);
    It2 = result.variable_mat(ind2,:);
    It3 = result.variable_mat(ind3,:);
    It4 = result.variable_mat(ind4,:);

    time = result.time_vect(:);

    %SetOutputs

    Out(1).sig = time.';
    Out(2).sig = It1;
    Out(3).sig = It2;
    Out(4).sig = It3;
    Out(5).sig = It4;

    %checkforNaNs and stuff
    
    

    if compcnt < SweepInfo.m1it
    condition = adaptComponents(Out, sweepVariables, components); %condition return 0 when no change
    compcnt = compcnt + 1;
    else
        condition = 0;
    end

    if optcnt < SweepInfo.m2it
    condition = adaptOptions(Out, options);
    optcnt = optcnt + 1;
    end

    

    %adaptIC if specified
    if (SweepInfo.m3 == 1)
        New_IC = adaptIC(result, 80e-9); %or nodes??
    else
        New_IC = adapticString;
    end


    %resim option
    condition_for_resimulation = condition;
    %condition_for_resimulation = 0;
    SimulationDataSave(startime-toc,~condition,fileName) %Diagnostic data generation, can be removed


end
Info = ' ';     %Empty for now, used for passing diagnostics to the layer up
end