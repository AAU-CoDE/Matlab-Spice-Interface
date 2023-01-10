%% Top level for running optimisation, sweeps, data handling etc
% Interface related at this level:
% - getclosestIC function fetching the closest saved adaptICstring based on the
% parameter distance
% - SweepInfo settings if there's need for changes between simulations
% - Info handling / pushing straight into SweepInfo
% - Waveform readout when not using resimulation options
% - Saving initial conditions, useful for quick reruns when coming back to
% the project or verifying

%clear all;
%close all;
%clc;


Rg = [10,30];
Rg2 = 2:10:100;

I_Load = 10 ;

% for x = 1:10
%     Rg2 = Rgat2(x);
adapticString = ' .ic I(Lload)=10';
%adapticString = EzRerun(10).IC;
SweepInfo.endtime = 5e-6;
SweepInfo.killtime = 120;
tic %must have for functions depending on it for timeouts


for i = 1:length(Rg)
    Rgat = Rg(i);
        if ((i == 1)) == 1
            select = [0 1 1];
        else
            select = [0 1 1];
        end
        [Out, newIC, Info] = LTSM_v4 ( [Rgat],adapticString,SweepInfo);
        tr(i) = Out(1);
        max_Vds(i) = Out(2);
        min_Vds(i) = Out(3);
        ind_Vd = find(strcmp(result.variable_name_list,'V(vmeas_source)' ));
        Vds(i).v = result.variable_mat(ind_Vd,:);
        Vds(i).t = result.time_vect;
        EzRerun(i).IC = newIC;

        adapticString = newIC;




        count_it = ['I finished iteration for ', num2str(Rg(i)), ' Rg value '];
        disp(count_it)

end
time = toc;

%end


