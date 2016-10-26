function [ id ] = idList( checkName )
%INSPECT Get the ID of a check
%   Detailed explanation goes here

p = inputParser;
p.addRequired('checkName',@isstr);
p.parse(checkName);
opts = p.Results;
checkName = opts.checkName;

switch checkName
    case 'checker'
        id = 0;
    case 'parseDate'
        id = 1;
    case 'logName'
        id = 2;
    case 'gitBuild'
        id = 3;
        
    case 'isUpdatedMat'
        id = 5;
    
    case 'msgStats'
        id = 7;
    case 'fwStats'
        id = 8;
    case 'logSize'
        id = 9;
    case 'logDuration'
        id = 10;
        
    otherwise
        error('Unknown check');
end

end