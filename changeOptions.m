function noptionsString = changeOptions(optionsString, noptionsString)

%Make changes in the optionsString, based on noptionsString

%See if the option exists in the optionsString present

%if so, change the values

%if not, add to the structure


%Save options file

save('Opts', 'optionsString');

end