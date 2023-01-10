function [mwDir] = makeMWDir(workingDir)

%%%Create a modified matlab working directory path, for some reason all \
%%%have to be \\

index = 2;
wDir_parts(1, :) = {extractBefore(workingDir,'\')};
newStr = extractAfter(workingDir,'\');
while (newStr ~= 0)

    wDir_parts(index, :) = {extractBefore(newStr,'\')};
    newStr = extractAfter(newStr, '\');
    index = index + 1;

end

mwDir = append(wDir_parts(1, :), '\\');
for n = 2:length(wDir_parts)

    mwDir = append(mwDir,wDir_parts(n, :),'\\' );
end

end