function [ reply ] = hasStr( formatStr )
%HASSTR Check if a message has a string field
%   Detailed explanation goes here

reply=false;

for i=1:length(formatStr)
    
    switch formatStr(i)
        case {'n', 'N', 'Z', 'M'}
            reply = true;
            return
        otherwise
            continue;
    end

end


end

