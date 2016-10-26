classdef Result < handle
    %RESULT Result class definition
    %   Detailed explanation goes here
    
    properties
        generator_hash = '';
        outcome = false;
        value = 'N/A';
        evidence = Evidence.empty;        
    end
    
    methods
        function setHash(this, ch)
            this.generator_hash = gitHashShort(ch.name);
        end
    end

end

