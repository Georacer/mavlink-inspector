classdef logDate < Checker
    %logDate Date when the log was recorded
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = logDate()
            this.name = 'logDate';
            this.description = 'Date when the log was recorded'; % Fill in here
            this.id = idList(this.name);
        end
        % Tester
        function test(this,msgs,formats,env)
            lockIndex = find(msgs.GPS(:,4),1,'first');
            
            GPS_week_lock = msgs.GPS(lockIndex,4);
            GPS_sec_lock = msgs.GPS(lockIndex,3)/1000;
            CPU_usec_lock = msgs.GPS(lockIndex,1);
            
            datenum = gps2utc(datetime(ws2gps(GPS_week_lock,GPS_sec_lock)));
            
            this.result = Result();
                    
            this.result.value = [datenum CPU_usec_lock];
            this.result.outcome = true;
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