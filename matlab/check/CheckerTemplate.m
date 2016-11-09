classdef CheckerTemplate < Checker
    %CHECKERTEMPLATE Template class for Checker test sublcasses
    %   Detailed explanation goes here
    
    properties (Access = private)
    end
    
    methods
        % Constructor
        function this = Checker() % Fill in here
            this.name = 'testName'; % Fill in here
            this.description = 'Test Description'; % Fill in here
            this.id = idList(this.name);
            this.result = Result(); % Keep this initialization here; Matlab seems to go haywire if it is dynamically allocated inside `test`
        end
        % Tester
        function test(this,msgs,formats,env)
            %% Initialize the result
            this.result.logName = this.name; % This is used for debugging purposes
            
            %% Check if the required data series are available
            
            % Example handling of data series absence
            
            % check1DataOK = true;
            % [MSGFieldIndex,logEntry] = getSeriesIndex(formats,msgs,'MSG','Field');
            % if MSGFieldIndex < 0
            %     this.writeLog(logEntry);
            %     this.MISS();
            %     check1DataOK = false;
            % end
            
            
            %% Main code body
            if check1DataOK
                warning('Add to this function content with a specialized test code'); % Fill in here
                %% Complete with series data
                % data = Series();
                % data.series = [];
                % data.x_axis = [];
                % data.names = {};
                % data.x_labels = {};

                %% Complete with evidence
                % evidence = Evidence();
                % evidence.stamp_start = [];
                % evidence.stamp_stop = [];
                % evidence.data = data;

                %% Complete result

                this.result.value = []; % Fill in here
                % this.result.evidence = evidence;
            end
            
            this.result.setHash(this); % Pass the test object to generate the result hash, last action before returning
        end
        % Printer
        function output = printResult(this)
            switch this.result.outcome
                case -2
                    output = 'ERROR: The required data could not be procured. See result.log for more details.';
                case -1
                    output = sprintf('FAILED: Placeholder message here'); % Fill in here
                case 0
                    output = sprintf('WARNING: Placeholder message here'); % FIll in here
                case 1
                    output = sprintf('PASSED: Placeholder message here'); % Fill in here
                otherwise
                    output = [];
                    error('Unknown outcome code');
            end
            warning('Replace this function content with a specialized print'); % Delete this
        end
        % Plotter
        function gh = plotResult(this)
            if this.result.outcome>-2
                warning('Replace this function content with a specialized plot'); % Fill in here
                
                % orange = [1 0.5 0.2];
                % gh = figure();
                % plot(this.result.evidence.data.x_axis{1}, this.result.evidence.data.series{1});
                % hold on;
                % plot(this.result.evidence.data.x_axis{2}, this.result.evidence.data.series{2},'r');
                % legend(this.result.evidence.data.names);
            else
                error('Cannot plot while missing data');
            end
        end
        
    end
    
end