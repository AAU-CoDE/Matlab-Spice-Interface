function [Dirs] = setDirectories(filename, useCurrent)

%Dirs - a vector of directory paths for LTSpice, Matlab working, and
%modified Matlab working directory
%filename - name of LTSpice executive file
%useCurrent - for always using current matlab working directory set to 1,
%otherwise it might try to change directories

workingDir = [cd '\'];

%%% Checking for directories
%check if a file with directory names is present
%if so, check if the working directory for matlab checks out
    %if not see if it exists on the PC and switch the working dir to it if so
    %if it doesn't set the current working directory
%if so, check if the rest of fields contain anything
    %if so, drop out
    %if not, proceed further

if (isfile('Dirs.mat')==1)      %Check if directories are in ther
    Dirs = load('Dirs.mat');

if strcmp(Dirs(2), workingDir) ~= 1     % Check if working directory is correct

    
end

if (isempty(Dirs(3)) && isempty(Dirs(1)))       %Check if LTSpice and modified working directories are there
    
end
end


%%%Create output and save it

Dirs(1,:) = {LTdir};           %LTspice dir  
Dirs(2,:) = {workingDir};           %Matlab working dir normal
Dirs(3,:) = mwDir;           %Matlab working dir modified

save('Dirs.mat', 'Dirs');

   
end