function [result, NoConv] = simulateModel(spicePath, fileName, filePath, endtime, killtime)
% SIMULATEMODEL is used to simulate a spice netlist. It takes the following
% Inputs: 
% spicePath: The path to the LT SPice installation start file
% for example 'C:\Program Files\LTC\LTspiceXVII\start.exe' This should be a
% string
% filename: Name of the netlist file to be simulated. Do not use .net
% extension. This can be a string / char or even an int or float
% filepath: Provide the complete file path to the netlist and end it with a
% backslash (\). This has to be a string.
% REQUIRED: TIC before running this function

if ischar(fileName)
    filename = fileName;
else
    filename = num2str(fileName);
end
outputfile = sprintf('%s.raw', filename);
if isfile(outputfile)
    delete(outputfile)
else
end

string = sprintf('start "LTSpice" "%s" -b "%s%s.net" -alt',spicePath, filePath, filename);

dos(string); %running starts

z=1;
killcheck = toc;
tokill = 0;

while (isfile(outputfile) == 0) && (tokill == 0) % Wait until result file shows up or timeout
     % File does not exists.
pause (0.5) %0.5 working well
   
    [~,b] = system('tasklist');
    IsRunning = contains(b, 'XVIIx64.exe');

    if (IsRunning == 0) &&  (tokill == 0)
        dos(string);
        pause (0.5);
    
    end

    killcheck1 = toc - killcheck;
    if killcheck1 > killtime
        tokill = 1;
    end

end

%% At this point either file appeared or we reached a timeout
% Now it's time to wait until the endtime is reached in simulation
% Or timeout appears

NoConv = 1;

while (tokill==0)

    pause(0.1)
    try
        result = LTspice2Matlab(outputfile);

        if result.time_vect(length(result.time_vect)) == endtime
            tokill = 1;
            NoConv = 0;
        else
            NoConv = 1;
        end
    catch 
        
    end

    killcheck1 = toc - killcheck;
    if killcheck1 > killtime
        tokill = 1;
    end
    
end


%% At this point, the simulation finished or timeout was reached
[~,b] = system('tasklist');
IsRunning = contains(b, 'XVIIx64.exe');
if IsRunning && (~tokill == 0)
    %KillSrvProcess('XVIIx64.exe');
    system('taskkill /IM XVIIx64.exe /f /t');
end

if isfile(outputfile) %Get rid of a file after loading so it's not mistaken for a new one
   delete(outputfile)
else
end