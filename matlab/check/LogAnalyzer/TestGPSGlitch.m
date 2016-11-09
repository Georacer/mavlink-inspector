classdef TestGPSGlitch < Checker
    %TestGPSGlitch Test for GPS glitch reporting or bad GPS data (satellite count, hdop)
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = TestGPSGlitch()
            this.name = 'TestGPSGlitch';
            this.description = 'Test for GPS glitch reporting or bad GPS data (satellite count, hdop) - Ported from ArduPilot LogAnalyzer';
            this.id = idList(this.name);
            this.result = Result();
        end
        % Tester
        function test(this,msgs,formats,env)
            %% Initialize the result            
            this.result.logName = this.name;
            
            %% Check if the required data series are available
            
            check1DataOK = true;
            
            [GPSNSatsIndex,logEntry] = getSeriesIndex(formats,msgs,'GPS','NSats');
            if GPSNSatsIndex < 0
                this.writeLog(logEntry);
                this.MISS();
                check1DataOK = false;
            end
            
            [GPSHDopIndex,logEntry] = getSeriesIndex(formats,msgs,'GPS','HDop');
            if GPSHDopIndex < 0
                this.writeLog(logEntry);
                this.MISS();
                check1DataOK = false;
            end

            if check1DataOK
                % NOTE: ERR message handling, provided by ArduCopter is not
                % supported

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
                
                %% Complete with series data
                GPSSpan = [msgs.GPS(1,1) msgs.GPS(end,1)];
                
                data = Series();
                data.series = {msgs.GPS(:,GPSNSatsIndex) minSatsWARN*[1 1] minSatsFAIL*[1 1] msgs.GPS(:,GPSHDopIndex) maxHDopWARN*[1 1] maxHDopFAIL*[1 1]};
                data.x_axis = {msgs.GPS(:,1) GPSSpan GPSSpan msgs.GPS(:,1) GPSSpan GPSSpan};
                data.names = {'Number of satellites', 'Satellite number WARN level', 'Satellite number FAIL level', 'HDOP', 'HDOP WARN level', 'HDOP FAIL level'};
                % data.x_labels = {};
                
                %% Complete with evidence
                evidence = Evidence();
                evidence.stamp_start = GPSSpan(1);
                evidence.stamp_stop = GPSSpan(2);
                evidence.data = data;
                
                %% Complete with result
                this.result.value = [minSats, maxHDop];
                this.result.outcome = outcome;
                this.result.evidence = evidence;
        end
            
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            switch this.result.outcome
                case -2
                    output = 'ERROR: The required data could not be procured';
                case -1
                    output = sprintf('FAILED: Min Satellites: %d | Max HDop: %g',this.result.value(1), this.result.value(2));
                case 0
                    output = sprintf('WARNING: Min Satellites: %d | Max HDop: %g',this.result.value(1), this.result.value(2));
                case 1
                    output = sprintf('PASSED: Min Satellites: %d | Max HDop: %g',this.result.value(1), this.result.value(2));
                otherwise
                    output = [];
                    error('Unknown outcome code');
            end
        end
        % Plotter
        function gh = plotResult(this)
            if this.result.outcome>-2  
                orange = [1 0.5 0.2];
                
                gh = figure();
                subplot(2,1,1)
                plot(this.result.evidence.data.x_axis{1}, this.result.evidence.data.series{1});                
                hold on;
                plot(this.result.evidence.data.x_axis{2}, this.result.evidence.data.series{2},'Color',orange);
                plot(this.result.evidence.data.x_axis{3}, this.result.evidence.data.series{3},'r');
                legend(this.result.evidence.data.names(1:3));
                
                subplot(2,1,2)
                plot(this.result.evidence.data.x_axis{4}, this.result.evidence.data.series{4});
                hold on;
                plot(this.result.evidence.data.x_axis{5}, this.result.evidence.data.series{5},'Color',orange);
                plot(this.result.evidence.data.x_axis{6}, this.result.evidence.data.series{6},'r');
                legend(this.result.evidence.data.names(4:6));
            else
                error('Cannot plot while missing data');
            end
        end
        
    end
    
end