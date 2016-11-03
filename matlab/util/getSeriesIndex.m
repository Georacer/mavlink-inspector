function [ index ] = getSeriesIndex( formats, message, column )
%GETSERIESINDEX Return the index of the Column in Message
%   Detailed explanation goes here

messageIndex = find(ismember(formats(:,3),message));
if isempty(messageIndex)
    index = -1;
    warning('Message %s not found',message);
    return;
end
columnIndex = find(ismember(formats{messageIndex,end},column));
if isempty(columnIndex)
    index = -2;
    warning('Data type %s in message %s not found',column, message);
    return;
end
index = columnIndex;
return

end

