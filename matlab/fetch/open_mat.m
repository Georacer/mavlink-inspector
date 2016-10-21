function [ filePath ] = open_mat( id )
%FIND_LOG Load a log .mat file
%   Given a log path

p = inputParser;
p.addRequired('id',@(x) (x>0)&(mod(x,1)==0));
p.parse(id);
opts = p.Results;
id = opts.id;

filePath = find_log(id);
evalin('base', sprintf('load(''%s'')',filePath));

end