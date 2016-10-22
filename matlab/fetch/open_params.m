function [ param ] = open_params( id )
%OPEN_PARAMS Open and read param file
%   Given its path

p = inputParser;
p.addRequired('id',@(x) (x>0)&(mod(x,1)==0));
p.parse(id);
opts = p.Results;
id = opts.id;

filePath = find_param(id);
fid = fopen(filePath);
paramRaw = textscan(fid,'%s\t%f');
fclose(fid);

values = paramRaw{2};

param = struct();

for i=1:length(paramRaw{1})
    param.(paramRaw{1}{i}) = values(i);
end

end

