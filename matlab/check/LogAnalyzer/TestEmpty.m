classdef TestEmpty < Checker
    %TestEmpty Test for empty or near-empty logs
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = TestEmpty()
            this.name = 'TestEmpty';
            this.description = 'Test for empty or near-empty logs - Ported from ArduPilot LogAnalyzer';
            this.id = idList(this.name);
            this.result = Result();
        end
        % Tester
        function test(this,msgs,formats,env)            
            %% Initialize the result
            this.result.logName = this.name;
            %% Check if the required data series are available
                       
            check1DataOK = true;
            [CTUNThrOutIndex,logEntry] = getSeriesIndex(formats,msgs,'CTUN','ThrOut');
            if CTUNThrOutIndex < 0
                this.writeLog(logEntry);
                this.MISS();
                check1DataOK = false;
            end
            
            %% Main code body
            if check1DataOK            
            
                throttleThreshold = 20;
                
                platformTest = fwStats();
                platformTest.test(msgs,formats,env);
                if strcmp(platformTest.result.value{1},'ArduCopter')
                    throttleThreshold = 200;
                end
                
                maxThrottle = max(msgs.CTUN(:,CTUNThrOutIndex));
                if maxThrottle<throttleThreshold
                    outcome = -1;
                    value = maxThrottle;
                else
                    outcome = 1;
                    value = maxThrottle;
                end
                
                %% Complete with series data
                data = Series();
                data.series = {msgs.CTUN(:,CTUNThrOutIndex) throttleThreshold*[1 1]};
                data.x_axis = {msgs.CTUN(:,1) [msgs.CTUN(1,1) msgs.CTUN(end,1)]};
                data.names = {'msgs.CTUN.ThrOut' 'Minimum throttle threshold'};
                % data.x_labels = {};
                
                %% Complete with evidence
                evidence = Evidence();
                evidence.stamp_start = msgs.CTUN(1,1);
                evidence.stamp_stop = msgs.CTUN(end,1);
                evidence.data = data;
                
                %% Complete with result
                
                this.result.value = value;
                this.result.outcome = outcome;
                this.result.evidence = evidence;
            end
            
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            switch this.result.outcome
                case -2
                    output = 'ERROR: No CTUN/ThrOut data found';
                case -1
                    output = sprintf('FAILED: Throttle never above 20% (%g)',this.result.value);
                case 1
                    output = sprintf('PASSED: Throttle maximum value is %g',this.result.value);
                otherwise
                    output = [];
                    error('Undefined result code');
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
                error('Cannot plot while missing data');
            end
        end
        
    end
    
end