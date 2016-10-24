function [ output_args ] = log2mat( id )
%LOG2MAT Parse a log file and save it as .mat
%   Detailed explanation goes here

% Remove this
evalin('base','clear');
profile on

p = inputParser;
p.addRequired('id',@(x) (x>0)&(mod(x,1)==0));
p.parse(id);
opts = p.Results;
id = opts.id;

key = sprintf('logs/%03d/*.log',id);
file = dir(key);

filePath = sprintf('logs/%03d/%s',id,file.name);

fh = fopen(filePath);

formats = cell(1,5);
% Specify the format line
formats{1,1} = 128;
formats{1,2} = 89;
formats{1,3} = 'FMT';
formats{1,4} = 'BBnNZ';
formats{1,5} = {'Type','Length','Name','Format','Columns'};

msgsSeen = cell(0,1);

[~,reply] = system(['wc -l ',which(filePath)]); % Number of lines in the log file
reply = strsplit(reply,' ');
fileLines = str2double(reply{1});
mh = waitbar(0,'Parsing log');
lineNum = 0;

waitbarPeriod = floor(fileLines/100)

while true
    
    newline = fgetl(fh);
    if (newline==-1)
        break;
    end    
    
    lineNum = lineNum + 1;
    if mod(lineNum,waitbarPeriod)==0
        waitbar(lineNum/fileLines,mh);
    end
    
    newline = strrep(newline,', ',',');
    
    data = textscan(newline,'%s','Delimiter',',');
    msgType = data{1}{1};
    
    if strcmp(msgType,'FMT')
        % This is a format specifier
        
        if strcmp(data{1}{4},'FMT')
            % This is the FMT specification, already got it
        else
            newrow = cell(1,5);
            newrow{1} = str2num(data{1}{2});
            newrow{2} = str2num(data{1}{3});
            newrow{3} = data{1}{4};
            newrow{4} = data{1}{5};
            newrow{5} = data{1}(6:end);
            formats(end+1,:) = newrow;
        end
        
    else
        msgIndexC = strfind(formats(:,3), msgType);
        msgIndex = find(not(cellfun('isempty', msgIndexC)));
        if msgIndex==0
            error(sprintf('Could not find format for message %s',msgType));
        end        
        format = formats{msgIndex,4};
        formatStr = genFormatStr(format);
        
        msgSize = length(formatStr)-1; % minus the initial msgType
        newrow = cell(1,msgSize);
        for i=2:length(formatStr)
            if (formatStr(i)=='d') || (formatStr(i)=='f')
                % field is numeric
                newrow{i-1} = str2double(data{1}{i});
            else
                % field is string
                newrow{i-1} = data{1}{i};
            end
        end       
        
        if (exist(msgType)~=1)
            eval(sprintf('%s=newrow;',msgType));
            msgsSeen(end+1) = {msgType};
        else
            eval(sprintf('%s(end+1,:) = newrow;',msgType));
        end
        
    end

end

fclose(fh);

assignin('base','formats',formats);
assignin('base','msgsSeen',msgsSeen);
for i=1:length(msgsSeen)
    eval(sprintf('assignin(''base'',''%s'',%s)',msgsSeen{i},msgsSeen{i}));
end

close(mh);

profile viewer
profile off

end

