classdef fwStats < Checker
    %CHECKERTEMPLATE Firmware related statistics
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = fwStats()
            this.name = 'fwStats';
            this.description = 'Firmware related statistics';
            this.id = idList(this.name);
        end
        % Tester
        function test(this,msgs,formats,env)
            types = {'ArduCopter', 'APM:Copter', 'ArduPlane', 'ArduRover'};
            name = '';
            value = [];
            evidenceLine = '';
            
            outcome = false;
            
            for i=1:size(msgs.MSG,1)
                
                string = msgs.MSG{i,2};
                swStringCell = strsplit(string,' ');
                
                word1 = swStringCell{1};
                
                if ismember(word1,types)
                    name = word1;
                    version = swStringCell{2};
                    gitHash = swStringCell{3};
                    gitHash = gitHash(2:end-1);
                    
                    value = {name, version, gitHash};
                    outcome = true;
                    evidenceLine = string;
                    stamp = msgs.MSG{i,1};
                    break;
                end
                
            end
            
            %%
            data = Series();
            data.series = evidenceLine;
            
            %%
            evidence = Evidence();
            evidence.stamp_start = stamp;
            evidence.stamp_stop = stamp;
            evidence.data = data;
            
            %%
            this.result = Result();
            
            this.result.value = value;
            this.result.outcome = outcome;
            this.result.evidence = evidence;
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            if this.result.outcome
                output = sprintf(['Platform: %s\n'...
                                  'Version: %s\n'...
                                  'Git hash: %s\n'
                                  ]...
                                 ,this.result.value{1},this.result.value{2},this.result.value{3});
            else
                output = sprintf('Could not find platform and version information');
            end
        end
        % Plotter
        function plotResult(this)
            warning('Overload this function with a specialized plot with a subclass'); % Fill in here
        end
        
    end
    
end