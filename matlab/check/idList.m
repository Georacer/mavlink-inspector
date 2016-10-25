function [ id ] = idList( checkName )
%INSPECT Get the ID of a check
%   Detailed explanation goes here

p = inputParser;
p.addRequired('checkName',@isstr);
p.parse(checkName);
opts = p.Results;
checkName = opts.checkName;

switch checkName
    case 'parseDate'
        id = 1;
    case 'logName'
        id = 2;
    case 'gitBuild'
        id = 3;
    case 'gitHashShort'
        id = 4;
    case 'isUpdatedMat'
        id = 5;
    otherwise
        error('Unknown check');
end

end