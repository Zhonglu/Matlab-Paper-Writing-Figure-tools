%clc
function plotviv2(fdir)


%cd 'C:\Users\Zhonglu Lin\OneDrive\PhDWorks\VIV\temp' %for windows
cd(fdir) %for mac
%v01=load([dirname,'VIV01.DAT']);
v02=load(['VIV02.DAT']);
v02=unique(v02,'rows');
%tn=length(v02)/5;%Number of lines plotted

%plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
%hold on; 
hold off
h(1)=plot(v02(:,1),v02(:,4),'color','b'); % y displacement of cylinder 2 (free)
xlabel('t*fn2');
ylabel('Y/D');



%tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%mkdir(['plotting/',list0(j).name])
%cd (['plotting/',list0(j).name])
%print('-dpng','-r500',['Plotting_',tiname,'.png']);
cd('C:\Users\Zhonglu\OneDrive - University Of Cambridge\OneDrive\PhDWorks\VIV')

end