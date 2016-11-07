classdef msgStats < Checker
    %msgStats Statistics on parsed messages
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = msgStats()
            this.name = 'msgStats';
            this.description = 'Statistics on parsed messages';
            this.id = idList(this.name);
            this.result = Result(); % Keep this initialization here; Matlab seems to go haywire if it is dynamically allocated inside `test`
        end
        % Tester
        function test(this,msgs,formats,env)
            this.result.logName = this.name;
            
            names = fieldnames(msgs);
            
            nonzero = zeros(1,length(names));
            
            for i=1:length(names)
                if ~isempty(msgs.(names{i}))
                    nonzero(i) = 1;
                end
            end
            
            data = Series();
            data.x_labels = names;
            data.series = zeros(1,length(names));
            for i=1:length(data.series)
                data.series(i)=size(msgs.(names{i}),1);
            end
            data.names = {'Message Counter'};
            
            evidence = Evidence();
            evidence.outcome = 1;
            evidence.data = data;
            
            this.result.value = sum(nonzero);
            this.result.outcome = 1;
            this.result.evidence = evidence;
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            output = sprintf('Log contains %d different message types',this.result.value);
        end
        % Plotter
        function gh = plotResult(this)
            gh = bar(this.result.evidence.data.series);
            ax = gca;
            ax.XTick = 1:length(this.result.evidence.data.series);
            ax.XTickLabels = this.result.evidence.data.x_labels;
            ax.XTickLabelRotation = 90;
            legend(this.result.evidence.data.names)
        end
        
    end
    
end