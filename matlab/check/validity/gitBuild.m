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
            this.result = Result(); % Keep this initialization here; Matlab seems to go haywire if it is dynamically allocated inside `test`
        end
        % Tester
        function test(this,msgs,formats,env)
            [~,reply] = system(sprintf('git rev-parse HEAD'));
            hash = reply(1:7);
            
            %% Complete with series data
            data = Series();
            data.series = {reply};
            data.names = {'Response of "git rev-parse HEAD"'};
            % data.x_labels = {};
            
            %% Complete with evidence
            evidence = Evidence();
%             evidence.stamp_start = [];
%             evidence.stamp_stop = [];
            evidence.data = data;
                                
            this.result.value = reply(1:end-1); % Last character is EOL
            this.result.outcome = 1;
            this.result.evidence = evidence;
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            output = sprintf('The git hash of the mavlink-inspector test suite is %s',this.result.value);
        end
        % Plotter
        function plotResult(this)
            warning('No plot available for this check');
        end
        
    end
    
end