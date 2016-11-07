classdef Result < handle
    %RESULT Result class definition
    %   Detailed explanation goes here
    
    properties
        logName = '';
        generator_hash = '';
        outcome = 1; % -2: Not enough data, -1: Failed, 0: Warning, 1: Pass
        value = 'N/A';
        log = {};
        evidence = Evidence.empty;        
    end
    
    methods
        function setHash(this, ch)
            this.generator_hash = gitHashShort(ch.name);
        end
    end

end

