function [ hash ] = gitHashShort( funcName )
%GITHASHSHORT Returns the hash of the input function
%   Returns the short git hash where the input function was last changed

fileName = which(funcName);
[~, reply] = system(sprintf('git --no-pager log --oneline -n 1 -- %s',fileName));

hash = strsplit(reply,' ');
hash = hash{1};

end