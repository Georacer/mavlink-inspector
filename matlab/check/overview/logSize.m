function [ result ] = logSize(id)
%PARSEDATE Name of the current log
%   Detailed explanation goes here


filePath = find_log(id);
f = dir(filePath);
log_size = f.bytes;

%%
result = Result();

result.name = 'logSize';
result.description = 'Size of the processed log file';
result.id = idList(result.name);
result.generator_hash = gitHashShort(result.name);

result.value = log_size;
result.outcome = true;

end

