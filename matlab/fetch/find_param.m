function [ filePath ] = find_param( id )
%FIND_PARAM Find the path of a param file
%   Given its ID

p = inputParser;
p.addRequired('id',@(x) (x>0)&(mod(x,1)==0));
p.parse(id);
opts = p.Results;
id = opts.id;

key = sprintf('logs/%03d/*.param',id);
file = dir(key);
if ~isempty(file)
    filePath = sprintf('logs/%03d/%s',id,file.name);
    return
end

key = sprintf('logs/%03d/*.parm',id);
file = dir(key);
if ~isempty(file)
    filePath = sprintf('logs/%03d/%s',id,file.name);
    return
end

error('Param file not found');

end

