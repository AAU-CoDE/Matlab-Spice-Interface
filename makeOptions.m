function noptionsString = makeOptions(optName, optValue, optStep, optDescr)

%Create an option object by specifying the .options command type, value and
%allowed range of variation
noptionsString.name = optName;
noptionsString.value = optValue;
noptionsString.step = optStep;
if exist('optDescr', 'var')
     % third parameter does not exist, so default it to something
      noptionsString.descr = optDescr;
else
    noptionsString.descr = {};
end

end