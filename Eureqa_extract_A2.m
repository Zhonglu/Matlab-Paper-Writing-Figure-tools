%compare across G, fix A1 mr
%cd G:\orange_backup % any dir
%cd /Volumes/GROUP_BLACK/orange_backup/
%output values
%gamr(1:4) f1(fi) Re A2(fi)
% G/D, A1/D, m^*, damp, f_1/f_n, Re, A2/D

close all
clear all

sysdir
%% undamped cases
lsgamr=dir(['g*a*m*r*']);

result=zeros(1,7);
resc=0;

Re=100;
zeta=0;

A2switch=1; % A2=1 or A2dA1=0 or both

mrswitch=0; %mass ratio is a variable or not

n1=1;%starting number of files
disp(['starting number= ',num2str(n1)])
if A2switch
    disp('drawing A2 graph')
else
    disp('drawing A2/A1 graph')
end

if mrswitch
    disp('dealing with mass ratios')
else
    disp('NOT dealing with mass ratios')
end

n0=length(lsgamr);
s=0;sp=0;
sleg=0;sgamall=0;

for j=n1:n0
    
    cd (lsgamr(j).name)
    lsf1=dir('0*');
    n=length(lsf1);
    cd ('../')
    if n==0; continue; end
    gamr=s2gamr(lsgamr(j).name);
    if gamr(1)==0.8; continue; end
    if length(gamr)~=4; continue; end
    %%
    cd(lsgamr(j).name)
    Lf1=length(lsf1);
    f1=zeros(1,Lf1);%A2=zeros(1,Lf1);A2dA1=zeros(1,Lf1);
    
    %%
    %if Lf1<30; cd ../; continue; end
    %%
    
    for fi=1:n
        [A2(fi), f1(fi)]=calA2(lsf1(fi).name);
        if isempty(A2(fi)); continue; end
        resc=resc+1;
        result(resc,:)=[gamr(1:3) zeta f1(fi) Re A2(fi)]; %write the text
        cd ../
    end
    
    cd ../
end
%% damped case

lsgamr=dir(['g*a*m*d*r*']);

% result=zeros(1,6);
% resc=0;

Re=100;
% zeta=0;

A2switch=1; % A2=1 or A2dA1=0 or both

mrswitch=0; %mass ratio is a variable or not

% n1=45;%starting number of files
% disp(['starting number= ',num2str(n1)])
if A2switch
    disp('drawing A2 graph')
else
    disp('drawing A2/A1 graph')
end

if mrswitch
    disp('dealing with mass ratios')
else
    disp('NOT dealing with mass ratios')
end

n0=length(lsgamr);
s=0;sp=0;
sleg=0;sgamall=0;

for j=1:n0
    
    cd (lsgamr(j).name)
    lsf1=dir('0*');
    n=length(lsf1);
    cd ('../')
    if n==0; continue; end
    gamr=s2gamr(lsgamr(j).name);
    if gamr(1)==0.8; continue; end %0.8 mesh is broken, skipped
    if length(gamr)~=5; continue; end %avoid picking up cases that are not targeted
    %%
    cd(lsgamr(j).name)
    Lf1=length(lsf1);
    f1=zeros(1,Lf1);%A2=zeros(1,Lf1);A2dA1=zeros(1,Lf1);
    
    %%
    %if Lf1<30; cd ../; continue; end
    %%
    
    for fi=1:n
        [A2(fi), f1(fi)]=calA2(lsf1(fi).name);
        if isempty(A2(fi)); continue; end
        resc=resc+1;
        result(resc,:)=[gamr(1:4) f1(fi) Re A2(fi)]; %write the text
        cd ../
    end
    
    cd ../
end

%%
%% Re verid damped case

lsgamr=dir(['g*a*m*d*e*r*']);

% result=zeros(1,6);
% resc=0;


% zeta=0;

A2switch=1; % A2=1 or A2dA1=0 or both

mrswitch=0; %mass ratio is a variable or not

% n1=45;%starting number of files
% disp(['starting number= ',num2str(n1)])
if A2switch
    disp('drawing A2 graph')
else
    disp('drawing A2/A1 graph')
end

if mrswitch
    disp('dealing with mass ratios')
else
    disp('NOT dealing with mass ratios')
end

n0=length(lsgamr);
s=0;sp=0;
sleg=0;sgamall=0;

for j=1:n0
    
    cd (lsgamr(j).name)
    lsf1=dir('0*');
    n=length(lsf1);
    cd ('../')
    if n==0; continue; end
    gamr=s2gamr(lsgamr(j).name);
    if gamr(1)==0.8; continue; end %0.8 mesh is broken, skipped
    if length(gamr)~=6; continue; end %avoid picking up cases that are not targeted
    %%
    cd(lsgamr(j).name)
    Lf1=length(lsf1);
    f1=zeros(1,Lf1);%A2=zeros(1,Lf1);A2dA1=zeros(1,Lf1);
    
    %%
    %if Lf1<30; cd ../; continue; end
    %%
    
    for fi=1:n
        [A2(fi), f1(fi)]=calA2(lsf1(fi).name);
        if isempty(A2(fi)); continue; end
        resc=resc+1;
        result(resc,:)=[gamr(1:4) f1(fi) gamr(5) A2(fi)]; %write the text
        cd ../
    end
    
    cd ../
end

%%
sysdir
result=result(~any(isnan(result),2),:);
csvwrite(['Eureqa_extract_',num2str(1+length(dir('Eureqa_extract*'))),'.dat'],result)
%%


