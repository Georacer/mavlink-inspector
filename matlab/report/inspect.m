function [ testVector ] = inspect( testVector, msgs, formats, env )
%INSPECT Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(testVector)
    if testVector{i}.isUpToDate()
        % Skip this test; Result is already available
    else
        testVector{i}.test(msgs,formats,env);
    end
    testVector{i}.printResult()
end