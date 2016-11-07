classdef TestCompass < Checker
    %TestCompass Test for compass offsets and throttle interference
    %   Detailed explanation goes here
    
    properties (Access = private)
        test1pass = true;
        test2pass = true;
        test3pass = true;
    end
    
    methods
        % Constructor
        function this = TestCompass()
            this.name = 'TestCompass';
            this.description = 'Test for compass offsets and throttle interference - Ported from ArduPilot LogAnalyzer';
            this.id = idList(this.name);
        end
        % Tester
        function test(this,msgs,formats,env)
            %% Initialize the result
            this.result.setHash(this); % Pass the test object to generate the result hash
            
            %% Check if the required data series are available
            
            compassOfsXParamValue = getParamValue(msgs,'COMPASS_OFS_X');
            compassOfsYParamValue = getParamValue(msgs,'COMPASS_OFS_Y');
            compassOfsZParamValue = getParamValue(msgs,'COMPASS_OFS_Z');
            
            if isnan([compassOfsXParamValue compassOfsYParamValue compassOfsZParamValue])
                warning('Could not find COMPASS_OFS_* parameter');
                this.result.outcome = -2;
                return;
            end
            
            MAGOfsXIndex = getSeriesIndex(formats,msgs,'MAG','OfsX');
            MAGOfsYIndex = getSeriesIndex(formats,msgs,'MAG','OfsY');
            MAGOfsZIndex = getSeriesIndex(formats,msgs,'MAG','OfsZ');
            MAGMagXIndex = getSeriesIndex(formats,msgs,'MAG','MagX');
            MAGMagYIndex = getSeriesIndex(formats,msgs,'MAG','MagY');
            MAGMagZIndex = getSeriesIndex(formats,msgs,'MAG','MagZ');
            
            if MAGOfsXIndex < 0
                warning('Missing XXX data');
                this.MISS();
            end
            if MAGOfsYIndex < 0
                warning('Missing XXX data');
                this.MISS();
            end
            if MAGOfsZIndex < 0
                warning('Missing XXX data');
                this.MISS();
            end
            if MAGMagXIndex < 0
                warning('Missing XXX data');
                this.MISS();
            end
            if MAGMagYIndex < 0
                warning('Missing XXX data');
                this.MISS();
            end
            if MAGMagZIndex < 0
                warning('Missing XXX data');
                this.MISS();
            end
            
            %% Main code body
            
            warnOffset = 300;
            failOffset = 500;
            
            %% Check the parameters
            paramOffsets = norm([compassOfsXParamValue compassOfsYParamValue compassOfsZParamValue]);
            
            if paramOffsets > failOffset
                this.FAIL();
                this.test1pass = false;
            end
            
            if paramOffsets > warnOffset
                this.WARN();
                this.test1pass = false;
            end
                
            %% Check the message offsets
            XArray = msgs.MAG(:,MAGOfsXIndex);
            YArray = msgs.MAG(:,MAGOfsYIndex);            
            ZArray = msgs.MAG(:,MAGOfsZIndex);
            norms = sqrt(sum([XArray YArray ZArray].^2,2));
            
            if max(norms) > failOffset
                this.FAIL();
                this.test2pass = false;
            end
            
            if max(norms) > warnOffset
                this.WARN();
                this.test2pass = false;
            end
            
            %% Check for magnetic field change in flight
            percentDiffThresholdWARN = 0.25;
            percentDiffThresholdFAIL = 0.35;
            minMagFieldThreshold = 120.0;
            maxMagFieldThreshold = 550.0;            
            
            XArray = msgs.MAG(:,MAGMagXIndex);
            YArray = msgs.MAG(:,MAGMagYIndex);            
            ZArray = msgs.MAG(:,MAGMagZIndex);
            norms = sqrt(sum([XArray YArray ZArray].^2,2));
            
            minMagField = min(norms);
            maxMagField = max(norms);
            
            percentDiff = (maxMagField - minMagField)/minMagField;
            
            if percentDiff > percentDiffThresholdWARN
                this.WARN();
                this.test3pass = false;
            end
            if percentDiff > percentDiffThresholdFAIL
                this.FAIL();
                this.test3pass = false;
            end
            
            if minMagField < minMagFieldThreshold || maxMagField > maxMagFieldThreshold
                this.WARN();
                this.test3pass = false;
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
                    text = '';
                    if ~this.test1pass
                        text = [text ' | Magnetic offset parameters out of bounds'];
                    end
                    if ~this.test2pass
                        text = [text ' | Magnetic offset message data out of bounds'];
                    end
                    if ~this.test3pass
                        text = [text ' | Measured magnetic field out of bounds'];
                    end
                    output = sprintf('FAILED:%s\n',text);
                case 0
                    text = '';
                    if ~this.test1pass
                        text = [text ' | Magnetic offset parameters out of bounds'];
                    end
                    if ~this.test2pass
                        text = [text ' | Magnetic offset message data out of bounds'];
                    end
                    if ~this.test3pass
                        text = [text ' | Measured magnetic field out of bounds'];
                    end
                    output = sprintf('WARNING:%s\n',text);
                case 1
                    output = sprintf('PASSED: Compass checks successful');
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