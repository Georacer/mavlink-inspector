classdef TestBrownout < Checker
    %TestBrownout Test for a log that has been truncated in flight
    %   Ported from ArduPilot's LogAnalyzer
    
    properties
    end
    
    methods
        % Constructor
        function this = TestBrownout()
            this.name = 'TestBrownout';
            this.description = 'Test for a log that has been truncated in flight - Ported from ArduPilot LogAnalyzer';
            this.id = idList(this.name);
            this.result = Result();
        end
        % Tester
        function test(this,msgs,formats,env)            
            this.result.setHash(this); % Pass the test object to generate the result hash
            this.result.logName = this.name;
            
            value = [];
            lastArmState = 0;
            
            %% Check if the required data series are available
            
            [ARMArmStateIndex, logEntry] = getSeriesIndex(formats,msgs,'ARM','ArmState');
            if ARMArmStateIndex < 0
                this.writeLog(logEntry);
                this.MISS();
            end
            [BAROAltIndex, logEntry] = getSeriesIndex(formats,msgs,'BARO','Alt');
            if BAROAltIndex < 0
                this.writeLog(logEntry);
                this.MISS();
            end
            
            if this.result.outcome == -2
                return;
            end
            
            %% Check based on EV message
            % EV message is no longer supported by DF, replacing by ARM
            
            %% Check based on ARM message
            lastArmState = msgs.ARM(end,ARMArmStateIndex);
            
            finalAlt = msgs.BARO(end,BAROAltIndex);
            finalAltMax = 3;
            
            maxAlt = max(msgs.BARO(:,BAROAltIndex));
            maxArm = max(msgs.ARM(:,ARMArmStateIndex));
            
            value = finalAlt;
            
            if lastArmState==1 && (finalAlt>finalAltMax)
                this.FAIL();
            end
            
            %% Complete with evidence data series
            data = Series();
            data.series = {msgs.BARO(:,BAROAltIndex) [msgs.ARM(1,ARMArmStateIndex)*maxAlt/maxArm msgs.ARM(:,ARMArmStateIndex)*maxAlt/maxArm msgs.ARM(end,ARMArmStateIndex)*maxAlt/maxArm]};
            data.names = {'msgs.BARO.Alt' 'msgs.ARM.ArmState (normalized to Alt)'};
            data.x_axis = {msgs.BARO(:,1) [msgs.BARO(1,1) msgs.ARM(:,1) msgs.BARO(end,1)]};
            
            %% Complete with evidence
            evidence = Evidence();
            evidence.stamp_start = msgs.BARO(1,1);
            evidence.stamp_stop = msgs.BARO(end,1);
            evidence.data = data;
            
            %% Complete with result                    
            this.result.value = value;
            this.result.evidence = evidence;
        end
        
        % Printer
        function output = printResult(this)
            switch this.result.outcome
                case -2
                    output = 'ERROR: The required data could not be procured. See result.log for more details.';
                case -1
                    output = sprintf('FAILED: Log ends while armed and altitude %.2f | Warning: This check is discouraged - barometer drift may affect results',this.result.value);
                case 0
                    output = sprintf('WARNING: Placeholder message here'); % FIll in here
                case 1
                    output = sprintf('PASSED: No brownout detected | Warning: This check is discouraged - barometer drift may affect results');
                otherwise
                    output = [];
                    error('Unknown outcome code');
            end
        end
        % Plotter
        function gh = plotResult(this)
            if this.result.outcome>-2
                gh = figure();
                plot(this.result.evidence.data.x_axis{1}, this.result.evidence.data.series{1});
                hold on;
                stairs(this.result.evidence.data.x_axis{2}, this.result.evidence.data.series{2},'r');
                legend(this.result.evidence.data.names);
            else
                error('Cannot plot while missing data')
            end
        end
        
    end
    
end