function [LTSpice_dir] = findLTSpice(filename)

%%%Search for the LTSpice path on C drive
LTSpice_filelist = dir(fullfile('C:','**',filename)); %Beware, slow AF
%%%Convert to path and return it
LTSpice_dir = [LTSpice_filelist.folder '\' LTSpice_filelist.name];

end