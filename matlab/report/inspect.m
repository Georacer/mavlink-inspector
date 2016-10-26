function [ ] = inspect( id, profile )
%INSPECT Summary of this function goes here
%   Detailed explanation goes here

filePath = open_mat(id);

param = open_params(id);

result = parseDate();
disp(sprintf('Log parsed in %s',result.value));

result = logName(id);
disp(sprintf('Log filename: %s',result.value));

end

