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
        end
        % Tester
        function test(this,msgs,formats,env)
            
            outcome = false;
            value = [];
            
            %% Check based on EV message
            % EV message is no longer supported by DF, replacing by ARM
            
            %% Check based on ARM message
            if ismember('ARM',env.msgsSeen)
                lastArmState = msgs.ARM(end,2);
            end            
            
            index =  getSeriesIndex(formats,'BARO','Alt');
            
            % BarAlt no longer a member of CTUN, replacing by BARO
            if index<1
                value = 'No BARO log data, cannot decide';
                outcome = -1;
            else 
                finalAlt = msgs.BARO(end,index);
                finalAltMax = 3;
                
                if lastArmState==1 && (finalAlt>finalAltMax)
                    value = sprintf('Log ends while armed and altitude %.2f',finalAlt);
                    outcome = 0;
                else
                    value = 'No brownout detected';
                    outcome = 1;
                end
            end
            
            %% Complete with evidence data series
            data = Series();
            data.series = msgs.BARO(end,:);
            % data.names = {};
            % data.x_labels = {};
            
            %% Complete with evidence
            evidence = Evidence();
            evidence.stamp_start = msgs.BARO(end,2);
            evidence.stamp_stop = msgs.BARO(end,2);
            evidence.data = data;
            
            %% Complete with result
            this.result = Result();
                    
            this.result.value = value;
            this.result.outcome = outcome;
            this.result.evidence = evidence;
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        
        % Printer
        function output = printResult(this)
            output = [this.result.value ' | Warning: This check is discouraged - barometer drift may affect results'];
        end
        % Plotter
        function gh = plotResult(this)
            warning('Overload this function with a specialized plot with a subclass'); % Fill in here
        end
        
    end
    
end