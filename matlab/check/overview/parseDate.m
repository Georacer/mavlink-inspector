function [ result ] = parseDate( GPS )
%PARSEDATE Date and time of the first GPS lock
%   Detailed explanation goes here

lockIndex = find(GPS(:,4),1,'first');

GPS_week_lock = GPS(lockIndex,4);
GPS_sec_lock = GPS(lockIndex,3)/1000;
CPU_usec_lock = GPS(lockIndex,1);

datenum = gps2utc(datetime(ws2gps(GPS_week_lock,GPS_sec_lock)));

%%
result = Result();

result.name = 'parseDate';
result.description = 'Date when this result was extracted';
result.id = idList(result.name);
result.generator_hash = gitHashShort(result.name);

result.value = [datenum CPU_usec_lock];
result.outcome = true;

end

