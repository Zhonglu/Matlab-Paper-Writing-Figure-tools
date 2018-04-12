%clc
clear all
close all
%close all
%cd 'C:\Users\Zhonglu Lin\OneDrive\PhDWorks\VIV\temp' %for windows
sysdir
setfigure
setlatex
cd '/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/VIV/anime/g0.4a0.075m1.5r141/00.740_2/' %for mac
%v01=load([dirname,'VIV01.DAT']);
% f02=load(['F002.DAT']);
% f02=unique(f02,'rows');
%tn=length(v02)/5;%Number of lines plotted
A1=0.075
f1=0.74
[t,cyt]=textscan_ft(A1,f1);% %total
[~,cyp]=textscan_ft(A1,f1,25); %pressure
[~,cys]=textscan_ft(A1,f1,27); %shear
%plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
%hold on; 
%figure
h(1)=plot(t,cyt,'k-');legendin{1}='$C_y\ total$'; hold on % 
h(2)=plot(t,cyp,'r--');legendin{2}='$C_y\ pressure$'; hold on % 
h(3)=plot(t,cys,'b-.');legendin{3}='$C_y\ shear$'; hold on % 

xlim([t(1) t(end)])
xlabel('$tf_n$','Interpreter','LaTex');
ylabel('$C_y$','Interpreter','LaTex');
legend(legendin)
[m1, i1]=max(cyp)
[m2, i2]=min(cyp)
abs(t(i1)-t(i2))/(t(end)-t(1))
ihalf=abs(i1-i2)
(i1+6)/10
(i2+6)/10
(i2+ihalf/2+6)/10
(i2-ihalf/2+6)/10
% 0233884+i1-1
% 0233884+i2-1
% 
% [f, P1]=fftzp2(f02(:,1),f02(:,4));
% figure
% plot(f,P1)
% 
% f1=0.78;
% [~, ~, yphsc2, yphsc2f1,yphsc2f2]=fftphase(v02(:,1),v02(:,4),f1);%plot(f,P1,'color','r','LineStyle','--');
% v01=load(['VIV01.DAT']);
% v01=unique(v01,'rows');
% [~, ~, yphsc2, yphsc1f1,yphsc2f2]=fftphase(v01(:,1),v01(:,4),f1);%plot(f,P1,'color','r','LineStyle','--');
% 
% result=yphsc2f1-yphsc1f1

%tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%mkdir(['plotting/',list0(j).name])
%cd (['plotting/',list0(j).name])
%print('-dpng','-r500',['Plotting_',tiname,'.png']);

setlatex