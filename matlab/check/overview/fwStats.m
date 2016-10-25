function [ result ] = fwStats( MSGS )
%UNTITLED Firmware related statistics
%   Detailed explanation goes here

types = {'ArduCopter', 'APM:Copter', 'ArduPlane', 'ArduRover'};
name = '';
value = [];
triplet = '';

outcome = false;

for i=1:size(MSGS,1)
    
    string = MSGS{i,2};
    swStringCell = strsplit(string,' ');
    
    word1 = swStringCell{1};
    
    if ismember(word1,types)
        name = word1;
        version = swStringCell{2};
        gitHash = swStringCell{3};
        gitHash = gitHash(2:end-1);
        
        value = {name, version, gitHash};
        outcome = true;
        triplet = string;
        stamp = MSGS{i,1};
        break;
    end      
    
end


%%
data = Series();
data.series = triplet;

%%
evidence = Evidence();
evidence.stamp_start = stamp;
evidence.stamp_stop = stamp;
evidence.data = data;

%%
result = Result();

result.name = 'fwStats';
result.description = 'Statistics on firmware';
result.id = idList(result.name);
result.generator_hash = gitHashShort(result.name);

result.value = value;
result.outcome = outcome;
result.evidence = evidence;


end

