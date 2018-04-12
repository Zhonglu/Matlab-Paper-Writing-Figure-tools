clear all
markerset={
    '+'
    'o'
    '*'
    'x'
    'square'
    'diamond'
    '^'
    'v'
    '>'
    '<'
    'pentagram'
    'hexagram'};%'.'
lineset={
    '-'
    '--'
    '-.'
    ':'
    };
colorset={
    'r'
    'b'
    'm'
    'k'
    'g'
    'c'
    };
%set(h,'Color','Black');

h=findobj(gca,'Type','line');h=h(end:-1:1);
[hleg1, ~] = legend;
%set(hleg1,'position',[0.531696769550958,0.313200939927145,0.247644352166617,0.533411204257857])

%hmzeta=zeros(length(hleg1.String),2);
for i=1:length(hleg1.String)
    hmz(i,1:2)=str2num(regexprep(hleg1.String{i},'[_\\$^*=a-zA-Z]',' '));
end

%m
hmz1=hmz(:,1);
hmz2=hmz(:,2);
mi=[1.5,1.7,2.0,2.2,2.5];
zi=[0,0.05,0.1,0.2];
for i=1:length(mi)
    
    [row,~]=find(hmz1==mi(i));
    
    set(h(row),{'Marker'},markerset(i));
    
    
end
clear row
for j=1:length(zi)
    [row,~]=find(hmz2==zi(j));
    set(h(row),{'LineStyle'},lineset(j));
    set(h(row),{'Color'},colorset(j));
    
end
set(h,'markersize',7);

for i=1:length(h)
    legendInfo{i}=['$',regexprep(regexprep(hleg1.String{i},'[$]',' '),'[_]',','),'$'];
end
legend(legendInfo)

set(hleg1,'FontSize',12)
%printpdf(gcf,['m_many.eps']);


% [hleg1, ~] = legend;
% for i=1:length(hleg1)
%     legendInfo{i}=['$',regexprep(regexprep(hleg1.String{i},'[$]',' '),'[_]',','),', \zeta=0.2$'];
% end
% legend(legendInfo)