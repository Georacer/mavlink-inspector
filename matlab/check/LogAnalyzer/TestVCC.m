classdef TestVCC < Checker
    %TestVCC Test for VCC within recommendations, or abrupt end to log in flight
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = TestVCC()
            this.name = 'TestVCC';
            this.description = 'Test for VCC within recommendations, or abrupt end to log in flight - Ported from ArduPilot LogAnalyzer';
            this.id = idList(this.name);
            this.result = Result();
        end
        % Tester
        function test(this,msgs,formats,env)
            %% Initialize result
            this.result.logName = this.name;
            
            %% Check if the required data series are available
            
            check1DataOK = true;
            check2DataOK = true;
            
            [CURRVccIndex,logEntry] = getSeriesIndex(formats,msgs,'CURR','Vcc');
            if CURRVccIndex < 0
                this.writeLog(logEntry);
                check1DataOK = false;
            end
            
            % Vcc information moved here, at least from https://github.com/ArduPilot/ardupilot/commit/3ed2fafefa2981d9ea720b552ba405dbeae37eca
            [POWRVccIndex,logEntry] = getSeriesIndex(formats,msgs,'POWR','Vcc');
            if POWRVccIndex < 0
                this.writeLog(logEntry);
                check2DataOK = false;
            end
            
            if ~check1DataOK && ~check2DataOK
                this.MISS();
            end
            
            if this.result.outcome>-2
                
                if check1DataOK
                    vcc = msgs.POWR(:,POWRVccIndex);
                    time = msgs.POWR(:,1);
                    name = 'msgs.POWR.Vcc';
                    vccMin = min(vcc);
                    vccMax = max(vcc);
                elseif check2DataOK     
                    vcc = msgs.CURR(:,CURRVccIndex);
                    time = msgs.CURR(:,1);
                    name = 'mgss.CURR.Vcc';
                    vccMin = min(vcc)/1000;
                    vccMax = max(vcc)/1000;
                end
                
                vccDiff = vccMax - vccMin;
                vccMinThreshold = 4.6;
                vccMaxDiff = 0.3;
                
                value = [vccMax vccMin];
                
                if vccDiff > vccMaxDiff
                    this.WARN();
                end
                if vccMin < vccMinThreshold
                    this.FAIL();
                end
                
                %% Complete with series data
                data = Series();
                data.series = {vcc vccMinThreshold*[1 1] vccMin*[1 1] vccMax*[1 1]};
                data.x_axis = {time time([1 end]) time([1 end]) time([1 end]) };
                data.names = {name 'Vcc minimum Threshold' 'Vcc minimum' 'Vcc maximum'};
                % data.x_labels = {};
                
                %% Complete with evidence
                evidence = Evidence();
                evidence.stamp_start = time(1);
                evidence.stamp_stop = time(end);
                evidence.data = data;
                
                %% Complete result
                this.result.value = value;
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
            if this.result.outcome>-2
                
                orange = [1 0.5 0.2];
                gh = figure();
                plot(this.result.evidence.data.x_axis{1}, this.result.evidence.data.series{1});
                hold on;
                plot(this.result.evidence.data.x_axis{2}, this.result.evidence.data.series{2},'r');
                plot(this.result.evidence.data.x_axis{3}, this.result.evidence.data.series{3},'--','Color',orange);
                plot(this.result.evidence.data.x_axis{4}, this.result.evidence.data.series{4},'--','Color',orange);
                legend(this.result.evidence.data.names);
            else
                error('Cannot plot while missing data');
            end
        end
        
    end
    
end