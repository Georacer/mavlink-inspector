classdef logSize < Checker
    %logSize Template class for Checker test sublcasses
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = logSize()
            this.name = 'logSize';
            this.description = 'Name of the current log';
            this.id = idList(this.name);
            this.result = Result(); % Keep this initialization here; Matlab seems to go haywire if it is dynamically allocated inside `test`
        end
        % Tester
        function test(this,msgs,formats,env)
            this.result.logName = this.name;
            
            filePath = find_log(env.logID);
            f = dir(filePath);
            log_size = f.bytes;
            
            this.result.value = log_size;
            this.result.outcome = 1;
            % this.result.evidence = 
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            output = sprintf('Log file size is %d kilobytes',this.result.value/1024);
        end
        % Plotter
        function plotResult(this)
            warning('Overload this function with a specialized plot with a subclass'); % Fill in here
        end
        
    end
    
end