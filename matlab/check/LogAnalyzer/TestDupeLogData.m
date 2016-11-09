classdef TestDupeLogData < Checker
    %TestDupeLogData Test for duplicated data in log, which has been happening on PX4/Pixhawk
    %   Detailed explanation goes here
    
    properties (Access = private)
    end
    
    methods
        % Constructor
        function this = TestDupeLogData()
            this.name = 'TestDupeLogData';
            this.description = 'Test for duplicated data in log, which has been happening on PX4/Pixhawk - Ported from ArduPilot LogAnalyzer';
            this.id = idList(this.name);
            this.result = Result();
        end
        % Tester
        function test(this,msgs,formats,env)
            %% Initialize the result
            this.result.setHash(this); % Pass the test object to generate the result hash
            this.result.logName = this.name;
            
            %% Check if the required data series are available
            
            ATTPitchIndex = getSeriesIndex(formats,msgs,'ATT','Pitch');
            
            if ATTPitchIndex < 0
                this.result.log{end+1} = 'ATT/Pitch data not found';
                this.MISS();                
                return
            end
            
            pitch = msgs.ATT(:,ATTPitchIndex);
            
            %% Main code body
            
            % Build the sample array
            sampleIndex = floor(linspace(1,length(pitch),11));
            samples = zeros(length(sampleIndex)-1,20);
            for i=1:length(sampleIndex)-1
                samples(i,:) = pitch(sampleIndex(i):(sampleIndex(i)+19));
            end
            
            for i=1:size(samples,1)
                % ignore if all data in sample is the same value
                if length(unique(samples(i,:)))==1
                    continue;
                else
                    % Scan the pitch array for identical data
                    for j=(sampleIndex(i)+1):(length(pitch)-20)
                        if pitch(j:j+19)'==samples(i,:)
                            this.FAIL();
                            return;
                        end
                    end
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
            
            %% Complete result
                    
            this.result.value = []; % Fill in here
            % this.result.evidence = evidence;
        end
        % Printer
        function output = printResult(this)
            switch this.result.outcome
                case -2
                    output = 'ERROR: The required data could not be procured';
                case -1
                    output = sprintf('FAILED: Duplicate data found in the log');
                case 0
                    output = sprintf('WARNING: ERROR: This test should not be able to WARN!');
                case 1
                    output = sprintf('PASSED: No duplicate data found');
                otherwise
                    output = [];
                    error('Unknown outcome code');
            end
        end
        % Plotter
        function gh = plotResult(this)
            warning('No plot available for this check');
        end
        
    end
    
end