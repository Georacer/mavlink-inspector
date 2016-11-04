function [ index ] = getSeriesIndex( formats, msgs, message, field )
%GETSERIESINDEX Return the index of the Field in Message
%   Detailed explanation goes here

messageIndex = find(ismember(formats(:,3),message));
if isempty(messageIndex)
    index = -1;
    warning('Message %s not declared in formats',message);
    return;
end
fieldIndex = find(ismember(formats{messageIndex,end},field));
if isempty(fieldIndex)
    index = -2;
    warning('Data type %s in message %s not found',field, message);
    return;
end
if isempty(msgs.(message))
    index = -3;
    warning('%s message array is empty',message);
    return;
end
index = fieldIndex;
return

end

