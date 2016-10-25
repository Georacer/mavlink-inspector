function [ result ] = msgStats( msgs )
%MSGSETSEEN Statistics on parsed messages
%   Detailed explanation goes here

names = fieldnames(msgs);

nonzero = zeros(1,length(names));

for i=1:length(names)
    if ~isempty(msgs.(names{i}))
        nonzero(i) = 1;
    end
end

data = Series();
data.x_labels = names;
data.series = zeros(1,length(names));
for i=1:length(data.series)
    data.series(i)=size(msgs.(names{i}),1);
end
data.names = {'Message Counter'};
data.plot_cmd = ['bar(this.series);'...
                'ax = gca;'...
                'ax.XTick = 1:length(this.series);'...
                'ax.XTickLabels = this.x_labels;'...
                'ax.XTickLabelRotation = 90;'...
                'legend(this.names)'...
                ];

evidence = Evidence();
evidence.outcome = true;
evidence.data = data;

%%
result = Result();

result.name = 'msgStats';
result.description = 'Statistics on parsed messages';
result.id = idList(result.name);
result.generator_hash = gitHashShort(result.name);

result.value = sum(nonzero);
result.outcome = true;
result.evidence = evidence;


end

