function [ result ] = logName(id)
%PARSEDATE Name of the current log
%   Detailed explanation goes here

result = Result();

result.name = 'logName';
result.description = 'Name of the processed log file';
result.id = idList(result.name);
result.generator_hash = gitHashShort(result.name);

filePath = find_log(id);
[~,fileName,ext] = fileparts(filePath);
log_name = sprintf('%s%s',fileName,ext);

result.value = log_name;
result.outcome = true;

end

