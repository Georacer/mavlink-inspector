function [ output, index] = getFormat( msgString, formats )
%GETFORMAT Return the format definition of the input message type
%   Detailed explanation goes here

output = '';

index = find(ismember(formats(:,3),msgString));

if ~isempty(index)
    for i=1:length(formats(index,:))
        value = formats{index,i};
        if ~iscell(value)
            if isstr(value)
                output = [output sprintf('%s,',value)];
            elseif isnumeric(value)
                output = [output sprintf('%d,',value)];
            else
                error('Unexpected field format');e
            end
        else
            output = [output '{'];
            for j=1:length(value)
                output = [output sprintf('%s,',value{j})];
            end
            output(end) = '}';
        end
    end
else
    warning('No such message type found in message format definition');
end

end

