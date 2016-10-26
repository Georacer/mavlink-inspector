classdef CheckerTemplate < Checker
    %CHECKERTEMPLATE Template class for Checker test sublcasses
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = Checker() % Fill in here
            this.name = 'testName'; % Fill in here
            this.description = 'Test Description'; % Fill in here
            this.id = idList(this.name);
        end
        % Tester
        function test(this,msgs,formats,env)
            warning('Overload this function with a specialized test with a subclass'); % Fill in here
            
            this.result = Result();
                    
            % this.result.value = 
            % this.result.outcome = 
            % this.result.evidence = 
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = print(this)
            warning('Overload this function with a specialized print with a subclass'); % Fill in here
        end
        % Plotter
        function plot(this)
            warning('Overload this function with a specialized plot with a subclass'); % Fill in here
        end
        
    end
    
end