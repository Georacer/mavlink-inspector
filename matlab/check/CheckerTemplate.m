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
            %% Initialize the result
            this.result = Result();
            this.result.setHash(this); % Pass the test object to generate the result hash
            
            %% Check if the required data series are available
            
            % msgSeriesIndex = getSeriesIndex(formats,msgs,reqMsg1,reqFld1);
            % Add message dependencies here. Use the result to decide upon checking
            
            % Example handling of data series absence
            % if msgSeriesIndex1 < 0
            %     warning('Missing XXX data');
            %     outcome = -2;
            % end
            
            %% Main code body
            warning('Add to this function content with a specialized test code'); % Fill in here
            %% Complete with series data
            % data = Series();
            % data.series = [];
            % data.names = {};
            % data.x_labels = {};
            
            %% Complete with evidence
            % evidence = Evidence();
            % evidence.stamp_start = [];
            % evidence.stamp_stop = [];
            % evidence.data = data;
            
            %% Complete result
                    
            this.result.value = []; % Fill in here
            this.result.outcome = outcome; % Fill in here
            % this.result.evidence = evidence;
        end
        % Printer
        function output = printResult(this)
            switch this.result.outcome
                case -2
                    output = 'ERROR: The required data could not be procured';
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
            warning('Replace this function content with a specialized plot'); % Fill in here
        end
        
    end
    
end