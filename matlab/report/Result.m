classdef Result
    %RESULT Result class definition
    %   Detailed explanation goes here
    
    properties
        name = '';
        description = '';
        id = 0;
        generator_hash = '';
        outcome = false;
        value
        evidence = Evidence.empty;        
    end
    
    methods
        plot(this)
    end
    
end

