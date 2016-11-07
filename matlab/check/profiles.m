function [ testVector ] = profiles( profile )
%PROFILES Read an investigation profile and return the related checks
%   Detailed explanation goes here

p = inputParser;
p.addRequired('profile',@isstr);
p.parse(profile);
opts = p.Results;
profile = opts.profile;

switch profile
    case 'df-overview'
        testVector = {logName() parseDate() logDate() logSize() logDuration() fwStats() msgStats()};
    case 'df-all'
        testVector = [{gitBuild() isUpdatedMat()} profiles('df-overview')];
    case 'log-analyzer-all'
        testVector = {TestBrownout() TestEmpty() TestGPSGlitch() TestVCC() TestCompass() TestDupeLogData() TestIMUMatch()};
    otherwise
        error('Unknown tests profile');
end

end

