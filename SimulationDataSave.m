%% Function for spice simulation data mining
% Inputs: simulation time, convergence,filename
% Outputs(saved to the folder):
%         - .mat file containing netlist file name, log file name, sim
%         time, and convergence info
%         - renamed netlist
%         - renamed log file

function SimulationDataSave(simtime,convergence,filename)

%check for folder existing and if theres none, do the job without checking
%names
outputFolder = fullfile(pwd, 'SpiceData');

netName = sprintf('%s.net',filename);
logName = sprintf('%s.log',filename);
if ~exist(outputFolder, 'dir')
  mkdir(outputFolder);
  netNameN = "Net1.net";
  logNameN = "Log1.log";
  copyfile(netName,netNameN);
  movefile(netNameN, 'SpiceData')
  copyfile(logName,logNameN);
  movefile(logNameN, 'SpiceData')
  Info(1).netName = netNameN;
  Info(1).logName = logNameN;
  Info(1).runtime = simtime;
  Info(1).convergence = convergence;
  save('Info.mat', 'Info');
  movefile('Info.mat', 'SpiceData')
else
    %Find last number for the names in the folder
    oldpath = pwd;
    newpath = sprintf('%s%s',oldpath, '\SpiceData');
    cd(newpath);
    load('Info.mat', 'Info');
    n = length(Info) + 1;
    cd(oldpath)
    netNameN = sprintf('Net%d.net',n)
    logNameN = sprintf('Log%d.log',n)
    copyfile(netName,netNameN);
    movefile(netNameN, 'SpiceData')
    copyfile(logName,logNameN);
    movefile(logNameN, 'SpiceData')
    Info(n).netName = netNameN;
    Info(n).logName = logNameN;
    Info(n).runtime = simtime;
    Info(n).convergence = convergence;
    cd(newpath);
    save('Info.mat', 'Info');
    cd(oldpath);
end

end