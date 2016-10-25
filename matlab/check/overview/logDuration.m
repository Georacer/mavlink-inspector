function [ result ] = logDuration( msgs )
%LOGDURATION Duration between first and last timestamp
%   Detailed explanation goes here

names = fieldnames(msgs);

firstStamp= inf;
lastStamp = 0;

for i=1:length(names)
    if isempty(msgs.(names{i}))
        continue
    end
    stamps = msgs.(names{i})(:,1);
    if iscell(stamps)
        stamps = cell2mat(stamps);
    end
    
    if stamps(1)<firstStamp
        firstStamp = stamps(1);
    end
    
    if stamps(end)>lastStamp
        lastStamp=stamps(end);
    end
end

value = (lastStamp-firstStamp)/1000000;

%%
result = Result();

result.name = 'logDuration';
result.description = 'Duration of the log file, based on CPU timestamps';
result.id = idList(result.name);
result.generator_hash = gitHashShort(result.name);

result.value = value;
result.outcome = true;

end

