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
            this.result = Result(); % Keep this initialization here; Matlab seems to go haywire if it is dynamically allocated inside `test`
        end
        % Tester
        function test(this,msgs,formats,env)
            this.result.logName = this.name;
            
            filePath = find_log(env.logID);
            [~,fileName,ext] = fileparts(filePath);
            log_name = sprintf('%s%s',fileName,ext);
            %% Complete with series data
            data = Series();
            data.series = {env.logID filePath};
            data.names = {'Requested ID' 'Filepath'};
            % data.x_labels = {};
            
            %% Complete with evidence
            evidence = Evidence();
            evidence.data = data;
            
                    
            this.result.value = log_name;
            this.result.outcome = 1;
            this.result.evidence = evidence;
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            output = sprintf('Examining log %s',this.result.value);
        end
        % Plotter
        function plotResult(this)
            warning('No plot available for this check');
        end
        
    end
    
end