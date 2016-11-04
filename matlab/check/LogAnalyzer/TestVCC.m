classdef TestVCC < Checker
    %TestVCC Test for VCC within recommendations, or abrupt end to log in flight
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = TestVCC()
            this.name = 'TestVCC';
            this.description = 'Test for VCC within recommendations, or abrupt end to log in flight';
            this.id = idList(this.name);
        end
        % Tester
        function test(this,msgs,formats,env)
            %% Initialize result            
            this.result = Result();
                    
            this.result.setHash(this); % Pass the test object to generate the result hash
            
            %% Check if the required data series are available
            
            CURRVccIndex = getSeriesIndex(formats,msgs,'CURR','Vcc');
            
            % Vcc information moved here, at least from https://github.com/ArduPilot/ardupilot/commit/3ed2fafefa2981d9ea720b552ba405dbeae37eca
            POWRVccIndex = getSeriesIndex(formats,msgs,'POWR','Vcc');
            
            if POWRVccIndex>0
                vccMin = min(msgs.POWR(:,POWRVccIndex));
                vccMax = max(msgs.POWR(:,POWRVccIndex));  
            elseif CURRVccIndex>0
                vccMin = min(msgs.CURR(:,CURRVccIndex))/1000;
                vccMax = max(msgs.CURR(:,CURRVccIndex))/1000;             
            else
                this.result.outcome = -2;
                return;
            end
            
            vccDiff = vccMax - vccMin;
            vccMinThreshold = 4.6;
            vccMaxDiff = 0.3;
            
            value = [vccMax vccMin];
            
            if vccDiff > vccMaxDiff
                outcome = 0;
            end
            if vccMin < vccMinThreshold
                outcome = -1;
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
            
            %% Complete result
            this.result.value = value;
            this.result.outcome = outcome; % Fill in here
            % this.result.evidence = evidence;
        end
        % Printer
        function output = printResult(this)
            switch this.result.outcome
                case -2
                    output = 'ERROR: The required data could not be procured';
                case -1
                    output = sprintf('FAILED: Minimum Vcc is %gV with threshold %gV',this.result.value(2),4.6);
                case 0
                    output = sprintf('WARNING: Vcc min/max difference is %gV with threshold %gV',this.result.value(1)-this.result.value(2),0.3);
                case 1
                    output = sprintf('PASSED: Vcc is within bounds');
                otherwise
                    output = [];
                    error('Unknown outcome code');
            end
        end
        % Plotter
        function gh = plotResult(this)
            warning('Replace this function content with a specialized plot'); % Fill in here
        end
        
    end
    
end