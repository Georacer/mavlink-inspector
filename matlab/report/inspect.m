function [ testVector ] = inspect( testVector, msgs, formats, env )
%INSPECT Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(testVector)
    if testVector{i}.isUpToDate()
        fprintf('%s result already available and up-to-date\n',testVector{i}.name);
    else
        fprintf('Testing for %s check\n',testVector{i}.name);
        testVector{i}.test(msgs,formats,env);
    end
%     testVector{i}.printResult()
end