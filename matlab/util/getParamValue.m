function [ value ] = getParamValue( msgs, param )
%getParamValue Return the value of the parameter
%   Detailed explanation goes here

paramNames = msgs.PARM(:,2);
paramIndex = ismember(paramNames,param);
firstIndex = find(paramIndex,1,'first');

if isempty(firstIndex)
    value = nan;
else
    value = msgs.PARM{firstIndex,3};
end

end

