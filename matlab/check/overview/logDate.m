classdef logDate < Checker
    %logDate Date when the log was recorded
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = logDate()
            this.name = 'logDate';
            this.description = 'Date when the log was recorded';
            this.id = idList(this.name);
            this.result = Result(); % Keep this initialization here; Matlab seems to go haywire if it is dynamically allocated inside `test`
        end
        % Tester
        function test(this,msgs,formats,env)
            %% Initialize the result
            this.result.logName = this.name;
            lockIndex = find(msgs.GPS(:,4),1,'first');
            
            GPS_week_lock = msgs.GPS(lockIndex,4);
            GPS_sec_lock = msgs.GPS(lockIndex,3)/1000;
            CPU_usec_lock = msgs.GPS(lockIndex,1);
            
            datenum = gps2utc(datetime(ws2gps(GPS_week_lock,GPS_sec_lock)));
            %% Complete with series data
            data = Series();
            data.series = msgs.GPS(lockIndex,:);
            data.names = 'msgs.GPS';
            % data.x_labels = {};
            
            %% Complete with evidence
            evidence = Evidence();
            evidence.stamp_start = CPU_usec_lock;
            evidence.stamp_stop = CPU_usec_lock;
            evidence.data = data;
                                
            this.result.value = [datenum CPU_usec_lock];
            this.result.outcome = 1;
            this.result.evidence = evidence;
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            output = sprintf('The log was recorded on %s UTC',datestr(this.result.value(1)));
        end
        % Plotter
        function plotResult(this)
            warning('No plot availale for this check');
        end
        
    end
    
end