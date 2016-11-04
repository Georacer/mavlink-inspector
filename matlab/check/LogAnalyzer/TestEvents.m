classdef TestEvents < Checker
    %TestEvents Test for erroneous events and failsafes
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = TestEvents()
            this.name = 'TestEvents';
            this.description = 'Test for erroneous events and failsafes';
            this.id = idList(this.name);
        end
        % Tester
        function test(this,msgs,formats,env)
            warning('This check only applies on ArduCopter, which is not supported');
            %% Check if the required data series are available
            
            ERRECCodeIndex = getSeriesIndex(formats,msgs,'ERR','ECode');
            % Add message dependencies here. Use the result to decide upon checking
            
            if msgSeriesIndex1 < 0
                outcome = -2;
            end
            
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
            
            %% Complete with result
            this.result = Result();
                    
            this.result.value = []; % Fill in here
            this.result.outcome = outcome; % Fill in here
            % this.result.evidence = evidence;
            this.result.setHash(this); % Pass the test object to generate the result hash
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