classdef Checker < handle
    %CHECKER Superclass for test functionality
    %   Detailed explanation goes here
    
    properties
        name = 'checker';
        description = '';
        id = [];
        result = Result();
    end
    
    methods
        % Constructor
        function this = Checker()
        end
        % Tester
        function test(this,msgs,formats,env)
            warning('Overload this function with a specialized test with a subclass');
        end
        % Printer
        function output = printResult(this)
            output = '';
            warning('Overload this function with a specialized print with a subclass');
        end
        % Plotter
        function gh = plotResult(this)
            warning('Overload this function with a specialized plot with a subclass');
        end
        
        % Check is test result is up to date with latest check function
        function resp = isUpToDate(this)
            if isempty(this.result)
                resp = false;
            else
                hashResult = this.result.generator_hash;
                hashGenerator = gitHashShort(this.name);
                resp = strcmp(hashResult,hashGenerator);
            end
        end
        
        % Set the result of the test to WARNING
        function WARN(this)
            if this.result.outcome>-1
                this.result.outcome=0;
            end
        end
        % Set the result of the test to FAILED
        function FAIL(this)
            if this.result.outcome>-2
                this.result.outcome=-1;
            end
        end
        % Set the result of the test to MISSING DATA
        function MISS(this)
            this.result.outcome=-2;
        end
    end
    
end