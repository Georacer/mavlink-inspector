function [ result ] = fwStats( MSGS )
%UNTITLED Firmware related statistics
%   Detailed explanation goes here

stamp = MSGS{1,1};
string = MSGS{1,2};
swStringCell = strsplit(string,' ');

name = swStringCell{1};
version = swStringCell{2};
gitHash = swStringCell{3};
gitHash = gitHash(2:end-1);

value = {name, version, gitHash};

%%
data = Series();
data.series = string;

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
result.outcome = true;
result.evidence = evidence;


end

