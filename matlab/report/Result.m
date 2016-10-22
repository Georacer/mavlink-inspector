classdef Result
    %RESULT Result class definition
    %   Detailed explanation goes here
    
    properties
        name = '';
        description = '';
        id = '';
        outcome = '';
        value
        evidence = Evidence.empty;        
    end
    
    methods
        plot(this)
    end
    
end

