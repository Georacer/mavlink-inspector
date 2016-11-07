classdef TestIMUMatch < Checker
    %CHECKERTEMPLATE Template class for Checker test sublcasses
    %   Detailed explanation goes here
    
    properties (Access = private)
    end
    
    methods
        % Constructor
        function this = TestIMUMatch()
            this.name = 'TestIMUMatch';
            this.description = 'Test compatibility between IMU1 and IMU2 - Ported from ArduPilot LogAnalyzer';
            this.id = idList(this.name);
            this.result = Result();
        end
        % Tester
        function test(this,msgs,formats,env)
            %% Initialize the result
            this.result.setHash(this); % Pass the test object to generate the result hash
            this.result.logName = this.name;
            
            %% Check if the required data series are available
            
            [IMUACCXIndex,logEntry] = getSeriesIndex(formats,msgs,'IMU','AccX');
            if IMUACCXIndex < 0
                this.writeLog(logEntry);
                this.MISS();
            end
            [IMUACCYIndex,logEntry] = getSeriesIndex(formats,msgs,'IMU','AccY');
            if IMUACCYIndex < 0
                this.writeLog(logEntry);
                this.MISS();
                return;
            end
            [IMUACCZIndex,logEntry] = getSeriesIndex(formats,msgs,'IMU','AccZ');
            if IMUACCZIndex < 0
                this.writeLog(logEntry);
                this.MISS();
                return;
            end
            [IMU2ACCXIndex,logEntry] = getSeriesIndex(formats,msgs,'IMU2','AccX');
            if IMU2ACCXIndex < 0
                this.writeLog(logEntry);
                this.MISS();
                return;
            end
            [IMU2ACCYIndex,logEntry] = getSeriesIndex(formats,msgs,'IMU2','AccY');
            if IMU2ACCYIndex < 0
                this.writeLog(logEntry);
                this.MISS();
                return;
            end
            [IMU2ACCZIndex,logEntry] = getSeriesIndex(formats,msgs,'IMU2','AccZ');
            if IMU2ACCZIndex < 0
                this.writeLog(logEntry);
                this.MISS();
                return;
            end            
            
            %% Main code body
            
            
            warn_threshold = 0.75;
            fail_threshold = 1.5;
            filter_tc = 5.0;
            
            imu = msgs.IMU(:,[1 IMUACCXIndex IMUACCYIndex IMUACCZIndex]);
            imu(:,1) = imu(:,1)/10^6; % Convert time to seconds
            imu2 = msgs.IMU2(:,[1 IMU2ACCXIndex IMU2ACCYIndex IMU2ACCZIndex]);
            imu2(:,1) = imu2(:,1)/10^6; % Convert time to seconds
            
            imu2Index = 0;
            last_t = 0;
            xDiffFiltered = 0;
            yDiffFiltered = 0;
            zDiffFiltered = 0;
            maxDiffFiltered = 0;
                        
            for i=1:length(imu)
                t = imu(i,1);
                if last_t==0
                    dt = 0;
                else
                    dt = t-last_t;
                end
                dt = min([dt 0.1]);
                
                imu2Index = find(imu2(:,1)>=t,1,'first');
                if ~imu2Index-1
                    imu2IndexPrev = imu2Index;
                    imu2TimePrev = imu2(imu2Index,1);
                else
                    imu2IndexPrev = imu2Index-1;
                    imu2TimePrev = imu2(imu2Index-1,1);
                end
                imu2TimeNext = imu2(imu2Index,1);
                % If the previous IMU2 sample was closer, select that
                if abs((imu2TimeNext-t))>=abs((imu2TimePrev-t))
                    imu2Index = imu2IndexPrev;
                end
                
                xDiff = imu(i,2) - imu2(imu2Index,2);
                yDiff = imu(i,3) - imu2(imu2Index,3);
                zDiff = imu(i,4) - imu2(imu2Index,4);
                
                xDiffFiltered = xDiffFiltered + (xDiff-xDiffFiltered)*dt/filter_tc;
                yDiffFiltered = yDiffFiltered + (yDiff-yDiffFiltered)*dt/filter_tc;
                zDiffFiltered = zDiffFiltered + (zDiff-zDiffFiltered)*dt/filter_tc;
                
                maxDiffFiltered = max( [maxDiffFiltered norm([xDiffFiltered yDiffFiltered zDiffFiltered])] );
                
                last_t = t;
            end
                        
            if maxDiffFiltered > fail_threshold
                this.writeLog('Difference above fail threshold');
                this.FAIL();
            end
            if maxDiffFiltered > warn_threshold
                this.writeLog('Difference above warn threshold');
                this.WARN();
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
                    
            this.result.value = {maxDiffFiltered, warn_threshold, fail_threshold};
            % this.result.evidence = evidence;
        end
        % Printer
        function output = printResult(this)
            message = sprintf('Mismatch: %g, WARN: %g, FAIL: %g',this.result.value{1}, this.result.value{2}, this.result.value{3});
            switch this.result.outcome
                case -2
                    output = 'ERROR: The required data could not be procured';
                case -1
                    output = sprintf('FAILED: Check vibration or accelerometer calibration (%s)',message);
                case 0
                    output = sprintf('WARNING: Check vibration or accelerometer calibration (%s)',message);
                case 1
                    output = sprintf('PASSED: %s',message);
                otherwise
                    output = [];
                    error('Unknown outcome code');
            end
        end
        % Plotter
        function gh = plotResult(this)
            warning('Replace this function content with a specialized plot'); % Fill in here
        end
        
    end
    
end