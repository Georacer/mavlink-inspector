function [ id ] = idList( checkName )
%INSPECT Get the ID of a check
%   Detailed explanation goes here

p = inputParser;
p.addRequired('checkName',@isstr);
p.parse(checkName);
opts = p.Results;
checkName = opts.id;

switch checkName
    case 'parseDate'
        id = 1;        
    otherwise
        error('Unknown check');
end

end