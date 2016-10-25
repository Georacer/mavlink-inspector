function [ result ] = parseDate( )
%PARSEDATE Date when the check is carried out
%   Detailed explanation goes here

result = Result();

result.name = 'parseDate';
result.description = 'Date when this result was extracted';
result.id = idList(result.name);
result.generator_hash = gitHashShort(result.name);

result.value = date();
result.outcome = true;

end

