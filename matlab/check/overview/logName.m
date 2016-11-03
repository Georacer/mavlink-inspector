classdef logName < Checker
    %logName Name of the current log
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = logName()
            this.name = 'logName';
            this.description = 'Name of the current log';
            this.id = idList(this.name);
        end
        % Tester
        function test(this,msgs,formats,env)
            filePath = find_log(env.logID);
            [~,fileName,ext] = fileparts(filePath);
            log_name = sprintf('%s%s',fileName,ext);
            
            this.result = Result();
                    
            this.result.value = log_name;
            this.result.outcome = 1;
            % this.result.evidence = 
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            output = sprintf('Examining log %s\n',this.result.value);
        end
        % Plotter
        function plotResult(this)
            warning('Overload this function with a specialized plot with a subclass'); % Fill in here
        end
        
    end
    
end