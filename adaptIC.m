function [adapticString] = adaptIC(result, icTime)
%% Adapting initial conditions
% Assumption - starting new sim with .ic based on the end of old is same as
% resuming

%inputs: tss - expected steady state time (before expected transient)
%        results - result structure for finding the nodes
%        sub - to flag that subcircuits are to be considered too (?)

%outputs: adapticString
tss = icTime;

%% I: Find the node voltages and inductor currents at tss
%Take all the V() and I() if component starts with L
%What about the subcircuits // SOLVED -> SAVE SETTINGS IN LT

%GET THE VARIABLE LIST FROM result FILE and filter out stuff
V.name = '';
V.index = 0;
V.value = 0;
iv = 1;

Il.name = '';
Il.index = 0;
Il.value = 0;
il = 1;

for n = 1:length(result.variable_name_list)

    if startsWith(result.variable_name_list(n), 'V') == 1

            V(iv).name = result.variable_name_list(n);
            V(iv).index = n;
            iv = iv + 1;
    end

    if ((contains(result.variable_name_list(n), ':L') && startsWith(result.variable_name_list(n), 'I')) || startsWith(result.variable_name_list(n), 'I(L')) == 1
    %if (startsWith(result.variable_name_list(n), 'I')) == 1
        Il(il).name = result.variable_name_list(n);
        Il(il).index = n;
        il = il + 1;

    end

end

%Get index for time

tind = 0;
i = 1;
while result.time_vect(i) < tss

    tind = i;
    i = i+1;

end

%find the values for .ic (future: use the backwards average to avoid
%spikes)

for n = 1:length(V)

    V(n).value = result.variable_mat(V(n).index,tind);

end

for n = 1:length(Il)

    Il(n).value = result.variable_mat(Il(n).index,tind);

end
%% II: Check for derivatives to see if time was ok (tbd)

%% IV: Compose the .nodeset and .ic strings (nodeset just to check)
adapticString = sprintf('.option noopiter \r\n .ic');
%adapticString = sprintf('');
%adapticString = sprintf('.option noopiter \r\n .option gminsteps = 0 \r\n .option itl6 = 0 \r\n.ic');

for n = 1:length(V)

    adapticString = sprintf('%s %s = %s', adapticString, string(V(n).name), string(V(n).value));

end
nodesetString = adapticString;
for n = 1:length(Il)

    adapticString = sprintf('%s %s = %s', adapticString, string(Il(n).name), string(Il(n).value));

end
end