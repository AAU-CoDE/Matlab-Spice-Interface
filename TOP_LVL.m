%% Top level for running optimisation, sweeps, data handling etc
% Interface related at this level:
% - getclosestIC function fetching the closest saved adaptICstring based on the
% parameter distance coming soon
% - SweepInfo settings if there's need for changes between simulations
%   - SweepInfo.killtime sets time limit per simulation
%   - SweepInfo.endtime sets the simulation length
%   - SweepInfo.m1it sets the iteration number for M1 convergence help
%   - SweepInfo.m2it sets the iteration number for M2 convergence help
%   - SweepInfo.m3 sets whether new initial conditions are returned
% - Info handling / for pushing straight into SweepInfo
%   - Any diagnostic needed for setting Sweep Infos
% - Waveform readout when not using resimulation options 
% - Saving initial conditions, useful for quick reruns when coming back to
% the project or verifying

%clear all;
%close all;
%clc;




Rs = 1.5;
Rg = 5e-3;
adapticString = ' ';    %starting .ic
SweepInfo.endtime = 1000e-9;  %Transient simulation end time
SweepInfo.killtime = 600;   %Maximum time allowed for a simulation run [s]
SweepInfo.m1it = 0; %Max iterations of first convergence improv. method
SweepInfo.m2it = 0; %Max iterations of second convergence improv. method
SweepInfo.m3 = 0;   %Enable ic. adaptation
tic %must have for functions depending on it for timeouts



[Out, newIC, Info] = LTSM_v5 ( [Rg,Rs],adapticString,SweepInfo);

        
figure
hold on
plot(Out(1).sig(:),Out(2).sig(:),Out(1).sig(:),Out(3).sig(:),Out(1).sig(:),Out(4).sig(:), Out(1).sig(:),Out(5).sig(:) )
xlabel('time, s')
ylabel('I_{d}, A')
legend('T1','T2','T3','T4')
time = toc;

%end


