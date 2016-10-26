function [ result_out ] = isUpdatedResult( result )
%ISUPDATEDRESULT Checks whether the input result is updated
%   i.e. it has been generated with the current version of its generator
%   checker function

p = inputParser;
p.addRequired('result',@(x) isa(result,'Result'));
p.parse(result);
opts = p.Results;
result = opts.result;

hashResult = result.generator_hash;

hashGenerator = gitHashShort(result.name);

if strcmp(hashResult,hashGenerator)
    reply = true;
else
    reply = false;
end

%%
result_out = Result();

result_out.name = 'isUpdatedResult';
result_out.description = 'Checks if the input result is generated with the latest generator function';
result_out.id = idList(result_out.name);
result_out.generator_hash = gitHashShort(result_out.name);

result_out.value = 'N/A';
result_out.outcome = reply;

end

