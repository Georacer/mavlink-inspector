classdef TestEmpty < Checker
    %TestEmpty Test for empty or near-empty logs
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = TestEmpty()
            this.name = 'TestEmpty';
            this.description = 'Test for empty or near-empty logs';
            this.id = idList(this.name);
        end
        % Tester
        function test(this,msgs,formats,env)
            
            throttleThreshold = 20;
            
            platformTest = fwStats();
            platformTest.test(msgs,formats,env);
            if strcmp(platformTest.result.value{1},'ArduCopter')
                throttleThreshold = 200;
            end            
            
            index = getSeriesIndex(formats,'CTUN','ThrOut');
            
            if index>1
                maxThrottle = max(msgs.CTUN(:,index));
                if maxThrottle<throttleThreshold
                    outcome = -1;
                    value = maxThrottle;
                else
                    outcome = 1;
                    value = maxThrottle;
                end
            else
                outcome = -2;
                value = [];
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
                    
            this.result.value = value;
            this.result.outcome = outcome;
            % this.result.evidence = evidence;
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            switch this.result.outcome
                case -2
                    output = 'No CTUN/ThrOut data found';
                case -1
                    output = sprintf('Throttle never above 20% (%g)',this.result.value);
                case 1
                    output = sprintf('Throttle maximum value is %g',this.result.value);
                otherwise
                    output = [];
                    error('Undefined result code');
            end
        end
        % Plotter
        function gh = plotResult(this)
            warning('Overload this function with a specialized plot with a subclass'); % Fill in here
        end
        
    end
    
end