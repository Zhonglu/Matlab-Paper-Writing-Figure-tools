%clc
clear all
%close all
%cd 'C:\Users\Zhonglu Lin\OneDrive\PhDWorks\VIV\temp' %for windows
%sysdir
%cd 'E:\Independent_part_2\g0.9a0.477m1.5d0.05e10.0r1402\00.500'
%cd './temp/' %for mac
cd '/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/VIV/temp/'

f1=1;
auto_cut_or_not=1;

[t02,y02]=textscanty;
v01=load(['VIV01.DAT']);
v01=unique(v01,'rows');
%tn=length(v02)/5;%Number of lines plotted

%plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
%hold on;
%figure
figure
hold on
h(1)=plot(t02,y02,'color','r');% y displacement of cylinder 2 (free)
h(2)=plot(v01(:,1),v01(:,4),'color','b');
% [t,ia] = unique(t);y=y(ia);%make every time step unique
% if length(t)<20
%     t=0;y=0;disp('error t too small')
% else
%     dt=t(20)-t(19);
%     xq = t(1):dt:t(end);
%     y = interp1(t,y,xq,'spline');
%     t=xq;
% end
legend({'v02','v01'})
xlabel('t*fn2');
ylabel('Y/D');
title('displacement')

f02=load(['F002.DAT']);f02=unique(f02,'rows');%f02=f02(1:50);
f01=load(['F001.DAT']);f01=unique(f01,'rows');%f01=f01(1:50);
figure
hold on
h(1)=plot(f02(:,1),f02(:,3),'color','r');% y displacement of cylinder 2 (free)
h(2)=plot(f01(:,1),f01(:,3),'color','b');
legend({'f02','f01'})
xlabel('t*fn2');
ylabel('F');
title('total force')

figure
hold on
h(1)=plot(f02(:,1),f02(:,5),'color','r');% y displacement of cylinder 2 (free)
h(2)=plot(f01(:,1),f01(:,5),'color','b');
legend({'f02','f01'})
xlabel('t*fn2');
ylabel('F');
title('pressure force')

figure
hold on
h(1)=plot(f02(:,1),f02(:,7),'color','r');% y displacement of cylinder 2 (free)
h(2)=plot(f01(:,1),f01(:,7),'color','b');
legend({'f02','f01'})
xlabel('t*fn2');
ylabel('F');
title('shear force')

ft02=f02(:,1);
fy02=f02(:,3); % third column is the total force

if auto_cut_or_not
    [t02,y02,ft02,fy02,info3]=autocut(f1,t02,y02,ft02,fy02);
end

[f, P1]=fftzp2(t02,y02);
figure
plot(f,P1)
xlim([0 2.4])
title('fft displacement of cylinder 2')

[f, P1]=fftzp2(ft02,fy02);
figure
plot(f,P1)
xlim([0 2.4])
title('fft total force upon Cylinder 2')


% 
% f1=0.78;
% [~, ~, yphsc2, yphsc2f1,yphsc2f2]=fftphase(t,y,f1);%plot(f,P1,'color','r','LineStyle','--');
% v01=load(['VIV01.DAT']);
% v01=unique(v01,'rows');
% [~, ~, yphsc2, yphsc1f1,yphsc2f2]=fftphase(v01(:,1),v01(:,4),f1);%plot(f,P1,'color','r','LineStyle','--');
% 
% result=yphsc2f1-yphsc1f1

%tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%mkdir(['plotting/',list0(j).name])
%cd (['plotting/',list0(j).name])
%print('-dpng','-r500',['Plotting_',tiname,'.png']);
cd ../