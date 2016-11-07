function [  ] = generateReport( profile, msgs, formats, env )
%GENERATEREPORT Summary of this function goes here
%   Detailed explanation goes here

basePath = sprintf('logs/%03d/',env.logID);

fh = fopen([basePath 'report_' profile '.txt'],'w');

testVector = profiles(profile);

testVector = inspect(testVector, msgs, formats, env);

for i=1:length(testVector)
    testTitle = [testVector{i}.name ': ' testVector{i}.description];
    testResult = [testVector{i}.printResult()'];
    fprintf(fh,'%s\n%s\n\n',testTitle, testResult);
end

fclose(fh);

end

