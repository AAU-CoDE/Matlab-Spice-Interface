function changed = adaptOptions(Out, options)
% This is a function adapting the circuit element values if output parameters
% calculated are NaN
Check = isnan(Out); % find if there are any NaNs

if sum(Check) ~= 0 % if any parameter returned Nan, run the code

    changed = 1;
    for n = 1:length(options)
    
    % Get the tolerances for options and randomize a new value
    if (isnumeric(options(n).value))
    newVal = options(n).value * options(n).step;

    if newVal > 0

        options(n).value = newVal;
        evalin('caller',(['options(',num2str(n),').value','= ', num2str(newVal), ';']));
    end
    
    end
    end
    % 'base' or 'caller'

    % Assign them to the variables
   

else
    changed = 0;
end


end