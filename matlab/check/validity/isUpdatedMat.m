classdef isUpdatedMat < Checker
    %isUpdatedMat Check if the .mat file is up to date
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % Constructor
        function this = isUpdatedMat()
            this.name = 'isUpdatedMat';
            this.description = 'Check if the .mat file is up to date';
            this.id = idList(this.name);
            this.result = Result();
        end
        % Tester
        function test(this,msgs,formats,env)
            
            fileNameMat = find_mat(env.logID);
            [token, ~] = regexp(fileNameMat,'_(\w*).mat','tokens','match');
            hashMat = token{1};
            
            hash_log2mat = gitHashShort('log2mat');
            
            isUpdated = strcmp(hashMat,hash_log2mat); 
            if isUpdated
                outcome = 1;
            else
                outcome = -1;
            end
            %% Complete with series data
            data = Series();
            data.series = {hashMat hash_log2mat};
            data.names = {'Hash of the .mat file' 'Hash of the log2mat script'};
            % data.x_labels = {};
            
            %% Complete with evidence
            evidence = Evidence();
%             evidence.stamp_start = [];
%             evidence.stamp_stop = [];
            evidence.data = data;
            
            %% Complete result        
            % this.result.value = 
            this.result.outcome = outcome;
            this.result.evidence = evidence;
            this.result.setHash(this); % Pass the test object to generate the result hash
        end
        % Printer
        function output = printResult(this)
            output = '';
            if this.result.outcome==1
                output = sprintf('The stored .mat file is up-to-date with the current log2mat function.');
            else
                output = sprintf('The stored .mat file is NOT up-to-date with the current log2mat function.\nPlease re-generate it.');
            end
        end
        % Plotter
        function plotResult(this)
            warning('No plot available for this check');
        end
        
    end
    
end