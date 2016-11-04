classdef TestGPSGlitch < Checker
    %TestGPSGlitch Test for GPS glitch reporting or bad GPS data (satellite count, hdop)
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = TestGPSGlitch()
            this.name = 'TestGPSGlitch';
            this.description = 'Test for GPS glitch reporting or bad GPS data (satellite count, hdop)';
            this.id = idList(this.name);
        end
        % Tester
        function test(this,msgs,formats,env)
            outcome = 1;
            %% Check if the required data series are available
            
            GPSNSatsIndex = getSeriesIndex(formats,msgs,'GPS','NSats');
            GPSHDopIndex = getSeriesIndex(formats,msgs,'GPS','HDop');
            % Add message dependencies here. Use the result to decide upon checking
            
            if GPSNSatsIndex < 0
                warning('Missing GPS/NSats data');
                outcome = -2;
            end
            if GPSHDopIndex < 0
                warning('Missing GPS/HDop data');
                outcome = -2;
            end
            
            % NOTE: ERR message handling, provided by ArduCopter is not
            % supported
            
            if outcome==-2
                
            else
                minSatsWARN = 6;
                minSatsFAIL = 5;
                maxHDopWARN = 3.0;
                maxHDopFAIL = 10.0;
                minSats = min(msgs.GPS(:,GPSNSatsIndex));
                maxHDop = max(msgs.GPS(:,GPSHDopIndex));
                
                if minSats < minSatsWARN
                    outcome = 0;
                end
                if maxHDop > maxHDopWARN
                    outcome = 0;
                end
                if minSats < minSatsFAIL
                    outcome = -1;
                end
                if maxHDop > maxHDopFAIL
                    outcome = -1;
                end
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
                    
            this.result.value = [minSats, maxHDop];
            this.result.outcome = outcome;
            % this.result.evidence = evidence;
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            switch this.result.outcome
                case -2
                    output = 'ERROR: The required data could not be procured';
                case -1
                    output = sprintf('FAILED: Min Satellites: %d | Max HDop: %g',this.result.value(1), this.result.value(2)); % Fill in here
                case 0
                    output = sprintf('WARNING: Min Satellites: %d | Max HDop: %g',this.result.value(1), this.result.value(2)); % FIll in here
                case 1
                    output = sprintf('PASSED: Min Satellites: %d | Max HDop: %g',this.result.value(1), this.result.value(2)); % Fill in here
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