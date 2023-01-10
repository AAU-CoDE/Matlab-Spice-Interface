function [Dirs] = setDirectories(filename)

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

if (isfile('Dirs.mat') == 1)      %Check if directories are in ther
    load('Dirs.mat', 'Dirs');

    

if (strcmp(Dirs(2), {workingDir}) ~= 1)     % Check if working directory is correct

    Dirs(1) = {findLTSpice(filename)};
    Dirs(2) = {workingDir};           %Set the cd as working dir
    Dirs(3) = makeMWDir(workingDir);
end

if (isempty(Dirs(3)) && isempty(Dirs(1)))       %Check if LTSpice and modified working directories are there
    Dirs(1) = {findLTSpice(filename)};           %LTspice dir
    Dirs(3) = makeMWDir(workingDir);           %Matlab working dir modified

end

else
Dirs(1) = {findLTSpice(filename)};
Dirs(2) = {workingDir};           %Set the cd as working dir
Dirs(3) = makeMWDir(workingDir);
end
%%%Save the output

save('Dirs.mat', 'Dirs');

   
end