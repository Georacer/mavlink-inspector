function [ testVector ] = profiles( profile )
%PROFILES Read an investigation profile and return the related checks
%   Detailed explanation goes here

p = inputParser;
p.addRequired('profile',@isstr);
p.parse(profile);
opts = p.Results;
profile = opts.profile;

switch profile
    case 'df-all'
        testVector = {gitBuild() logName() parseDate() logSize() logDuration() fwStats() isUpdatedMat() msgStats() };
    otherwise
        error('Unknown tests profile');
end

end

