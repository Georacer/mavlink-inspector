function [ result ] = isUpdatedMat( id )
%ISUPDATEDMAT check if the .mat file is up to date
%   regarding the log2mat generator

fileNameMat = find_mat(id);
[token, ~] = regexp(fileNameMat,'_(\w*).mat','tokens','match');
hashMat = token{1};

hash_log2mat = gitHashShort('log2mat');

outcome = true;
outcome = strcmp(hashMat,hash_log2mat);

result = Result();

result.name = 'isUpdatedMat';
result.description = 'Checks if the input .mat file is generated with the latest log2mat script';
result.id = idList(result.name);

result.value = 'N/A';
result.outcome = outcome;


end

