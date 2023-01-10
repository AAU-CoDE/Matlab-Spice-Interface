function optionsString = importOptions(optFilename)

%Import default options for all LTSpice parameters
if (isfile('Opts.mat') == 1)      %Check if directories are in ther
    load(optFilename, 'optionsString');
else
    disp('Option file not found, simulation options not modified in makeOptions will be the default LTSpice settings')
end


end