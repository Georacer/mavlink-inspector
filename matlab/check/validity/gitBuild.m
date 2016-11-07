classdef gitBuild < Checker
    %GITBUILD Short git hash of the current branch
    %   Used for stamping of test results
    
    properties
    end
    
    methods
        % Constructor
        function this = gitBuild()
            this.name = 'gitBuild';
            this.description = 'Short git hash of the current branch';
            this.id = idList(this.name);
        end
        % Tester
        function test(this,msgs,formats,env)
            [~,reply] = system(sprintf('git rev-parse HEAD'));
            hash = reply(1:7);
            
            this.result = Result();
                    
            this.result.value = reply(1:end-1); % Last character is EOL
            this.result.outcome = 1;
            % result.evidence = 
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            output = sprintf('The git hash of the mavlink-inspector test suite is %s',this.result.value);
        end
        % Plotter
        function plotResult(this)
            warning('Overload this function with a specialized plot with a subclass');
        end
        
    end
    
end