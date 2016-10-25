function [ result ] = gitBuild( allCommits )
%GITBUILD Return the number of commits in the repo
%   For use in versioning control

if nargin<1
    allCommits = false;
end

if allCommits
    branch = '--all';
else
    branch = 'HEAD';
end    

[~,reply] = system(sprintf('git rev-list --count %s',branch));
commits = str2num(reply);

result = Result();

result.name = 'gitBuild';
result.description = 'Number of commits on the specified branch';
result.id = idList(result.name);
result.generator_hash = gitHashShort(result.name);

result.value = commits;
result.outcome = true;

end

