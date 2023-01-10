function changed = adaptComponents(Out, Params, components)
% This is a function adapting the circuit element values if output parameters
% calculated are NaN
Check = isnan(Out); % find if there are any NaNs

if sum(Check) ~= 0 % if any parameter returned Nan, run the code

    changed = 1;
    for n = 1:length(Params)
    % Get the tolerances for parameters

    parameter = string(Params(n));
    fun = @(x) components(x).name == parameter; % useful for complicated fields
    tf2 = arrayfun(fun, 1:numel(components));
    index2 = find(tf2);
    tol = components(index2).tol;
    % Create random values from within
    maxVal = evalin('caller',(char(Params(n)))) + (evalin('caller',(char(Params(n)))))*tol;
    minVal = evalin('caller', (char(Params(n)))) - (evalin('caller',(char(Params(n)))))*tol;
    newVal(n) = minVal + rand*(maxVal-minVal);
    end
    
    % 'base' or 'caller'

    % Assign them to the variables
    for n = 1:length(Params)
    evalin('caller',([char(Params(n)),'= ', num2str(newVal(n)), ';'])); % Assign new value to a parameter
    end

else
    changed = 0;
end


end