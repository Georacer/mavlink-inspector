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
                                
            this.result.value = [datenum CPU_usec_lock];
            this.result.outcome = 1;
            % this.result.evidence = 
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            output = sprintf('The log was recorded on %s UTC',datestr(this.result.value(1)));
        end
        % Plotter
        function plotResult(this)
            warning('Overload this function with a specialized plot with a subclass'); % Fill in here
        end
        
    end
    
end