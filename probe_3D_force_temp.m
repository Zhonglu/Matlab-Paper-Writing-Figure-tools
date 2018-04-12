%clc

clear all
%close all
%cd 'C:\Users\Zhonglu Lin\OneDrive\PhDWorks\VIV\temp' %for windows
cd '/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/VIV'
cd ./temp/ %for mac
%v01=load([dirname,'VIV01.DAT']);
file1=fopen('FORCE01.DAT');
file2=fopen('FORCE02.DAT');
Ctemp1=textscan(file1,'%f %f %f %f %f %f %f');
Ctemp2=textscan(file2,'%f %f %f %f %f %f %f');
% T FXP FYP FZP FXS FYS FZS
fclose(file1)
%get minimum length of 5 columns
n=7;

for i=1:n
    L1(i)=numel(Ctemp1{1,i});
    L2(i)=numel(Ctemp2{1,i});
end
Lmin=min(min(L1),min(L2));


forces1=zeros(Lmin,n);forces2=zeros(Lmin,n);
for i=1:n
    forces1(1:Lmin,i)=Ctemp1{1,i}(1:Lmin);
    forces2(1:Lmin,i)=Ctemp2{1,i}(1:Lmin);
end
forces1=forces1(~any(isnan(forces1),2),:);%remove rows with NaN values
forces1=unique(forces1,'rows');
forces2=forces2(~any(isnan(forces2),2),:);%remove rows with NaN values
forces2=unique(forces2,'rows');
%forces
%T FXP FYP FZP FXS FYS FZS
forces1=forces1(1000:end,:);forces2=forces2(1000:end,:);

%t=forces1(:,1);% time

%Con=unique(Con,'rows');
%tn=length(v02)/5;%Number of lines plotted

%plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
%hold on;

fn={'T','FXP','FYP','FZP','FXS','FYS','FZS'};
for i=2:7
    figure(i)
    hold on
    plot(forces1(:,1),forces1(:,i)); % y displacement of cylinder 2 (free)
    plot(forces2(:,1),forces2(:,i));
    legend('C1','C2')
    title(fn{i})
end




%tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%mkdir(['plotting/',list0(j).name])
%cd (['plotting/',list0(j).name])
%print('-dpng','-r500',['Plotting_',tiname,'.png']);
cd ../