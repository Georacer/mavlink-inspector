function [ index, logMessage ] = getSeriesIndex( formats, msgs, message, field )
%GETSERIESINDEX Return the index of the Field in Message
%   INPUT:
%   formats: The DataFlash formats declarations
%   msgs: The messages container
%   message: (string) the requested message type
%   field: (string) the requested field name
%   OUTPUT:
%   index:  -1, message not found
%           -2, field not found in message
%           -3, message array is empty
%           (positive integer), the field index on the message array/cell

messageIndex = find(ismember(formats(:,3),message));
if isempty(messageIndex)
    index = -1;
    warning('Message %s not declared in formats',message);
    logMessage = sprintf('Message %s not declared in formats',message);
    return;
end
fieldIndex = find(ismember(formats{messageIndex,end},field));
if isempty(fieldIndex)
    index = -2;
    warning('Data type %s in message %s not found',field, message);
    logMessage = sprintf('Data type %s in message %s not found',field, message);
    return;
end
if isempty(msgs.(message))
    index = -3;
    warning('%s message array is empty',message);
    logMessage = sprintf('%s message array is empty',message);
    return;
end
index = fieldIndex;
logMessage = '';
return

end

