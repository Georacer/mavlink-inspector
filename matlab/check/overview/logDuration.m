classdef logDuration < Checker
    %logDuration Duration between first and last timestamp
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = logDuration()
            this.name = 'logDuration';
            this.description = 'Duration between first and last timestamp';
            this.id = idList(this.name);
            this.result = Result(); % Keep this initialization here; Matlab seems to go haywire if it is dynamically allocated inside `test`
        end
        % Tester
        function test(this,msgs,formats,env)
            this.result.logName = this.name;
            
            names = fieldnames(msgs);
            
            firstStamp= inf;
            lastStamp = 0;
            
            firstStampEvidence = '';
            firstStampMsg = '';
            lastStampEvidence = '';
            lastStampMessage = '';
            
            for i=1:length(names)
                if isempty(msgs.(names{i}))
                    continue
                end
                stamps = msgs.(names{i})(:,1);
                if iscell(stamps)
                    stamps = cell2mat(stamps);
                end
                
                if stamps(1)<firstStamp
                    firstStamp = stamps(1);
                    firstStampEvidence = msgs.(names{i})(1,:);
                    firstStampMsg = sprintf('msgs.%s',names{i});
                end
                
                if stamps(end)>lastStamp
                    lastStamp=stamps(end);
                    lastStampEvidence = msgs.(names{i})(end,:);
                    lastStampMsg = sprintf('msgs.%s',names{i});
                end
            end
            
            value = (lastStamp-firstStamp)/1000000;
            %% Complete with series data
            data = Series();
            data.series = {firstStampEvidence lastStampEvidence};
            data.names = {firstStampMsg lastStampMsg};
            % data.x_labels = {};
            
            %% Complete with evidence
            evidence = Evidence();
            evidence.stamp_start = firstStamp;
            evidence.stamp_stop = lastStamp;
            evidence.data = data;
            
            %% Complete result
                                
            this.result.value = value;
            this.result.outcome = 1;
            this.result.evidence = evidence;
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            output = sprintf('The duration of the log file, based on CPU timestamps is %g seconds',this.result.value);
        end
        % Plotter
        function plotResult(this)
            warning('No plot available for this check');
        end
        
    end
    
end