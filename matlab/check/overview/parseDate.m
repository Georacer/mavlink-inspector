classdef parseDate < Checker
    %parseDate Date when this result was extracted
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = parseDate()
            this.name = 'parseDate';
            this.description = 'Date when this result was extracted';
            this.id = idList(this.name);
        end
        % Tester
        function test(this,msgs,formats,env)
            value = datestr(datetime('now','Timezone','UTC'));
            
            this.result = Result();
                    
            this.result.value = value;
            this.result.outcome = 1;
            % this.result.evidence = 
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            output = sprintf('Current date and time is %s UTC\n',this.result.value);
        end
        % Plotter
        function plotResult(this)
            warning('Overload this function with a specialized plot with a subclass'); % Fill in here
        end
        
    end
    
end