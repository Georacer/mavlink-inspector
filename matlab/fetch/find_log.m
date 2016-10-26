function [ filePath ] = find_log( id )
%FIND_LOG Find the path of the .mat file
%   Given a log id

p = inputParser;
p.addRequired('id',@(x) (x>0)&(mod(x,1)==0));
p.parse(id);
opts = p.Results;
id = opts.id;

key = sprintf('logs/%03d/*.BIN',id);
file = dir(key);

filePath = sprintf('logs/%03d/%s',id,file.name);

end

