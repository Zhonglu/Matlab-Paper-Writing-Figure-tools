
clear all
close all

sysdir

list0=dir('g*a*m*r141');
n0=length(list0);
s=0;
for j=1:n0
    cd (list0(j).name)
    listf1=dir('0*');
    n=length(listf1);
    cd ('../')
   
    str=list0(j).name;
    %str(str=='r')=[];
    str(str=='u')=[];
    str(str=='n')=[];
    str(str=='_')=[];
    str(str=='z')=[];
    str(str=='r')=[' '];
    %str1=str;
    str(str=='g')=' ';
    str(str=='a')=' ';
    str(str=='m')=' ';
    gam=str2num(str);
    
    G=gam(1);
    A1=gam(2);
    m=gam(3);
    %%
    %if G<0.6; continue; end
    
    
    %%
    for i=1:n % i=1:n
        f1=str2double(listf1(i).name);
        %if f1~=1.0; continue; end
        dirnamef=[list0(j).name,'/',listf1(i).name,'/'];
        %v01=load([dirname,'VIV01.DAT']);
        cd(dirnamef)
        disp(pwd);
        %[y,t]=loadv02yt(0);
        fdir=pwd;
        cd ../; cd ../;
        tempo=['plotting_both/',list0(j).name];
        mkdir(tempo)
        cd (tempo)
        disp(tempo)
        
        ttl=['G=',num2str(G),'  A_1=',num2str(A1),'  m=',num2str(m),'  f1=',listf1(i).name,'  Cylinder 2'];
        pdir=pwd;
        pname=[list0(j).name,'_',listf1(i).name];
        
        %if f1~=1.0; continue; end
        %plot_CY_and_Y(fdir,[],24000,pdir,[],pname,[],f1,4,[],A1,[],[])
        fdir=fdir;pname=pname;pdir=pdir;  
        zpf=[];ttl_p=[];
        start=24000;
        f1=f1;A1=A1;
        nT=4;%nT last periods will be outputed
        ylimfftl=[];ylimfftr=[];
        %ylimthl=[-1.5 1.5];ylimthr=[-0.04 0.04];
        ylimthl=[];ylimthr=[];
        checkplot_CY_and_Y(fdir,zpf,start,pdir,ttl_p,pname,ylimfftl,f1,nT,ylimthl,A1,ylimfftr,ylimthr)
        saveas(gcf,[ttl,'.fig'])

        cd ('../')
        cd ('../')
        close all
    end
    

    
end

%clc
function checkplot_CY_and_Y(fdir,zpf,start,pdir,ttl_p,pname,ylimfftl,f1,nT,ylimthl,A1,ylimfftr,ylimthr)
setlatex
if ~exist('pname','var') || isempty(pname)
    pname='';
end

%cd 'C:\Users\Zhonglu Lin\OneDrive\PhDWorks\VIV\temp' %for windows
% if exist('fdir','var')
%     cd(pwd)
% else
%     cd(fdir) %for mac
% end
if ~exist('fdir','var') || isempty(fdir)
  fdir=pwd;
end
cd(fdir)

%tn=length(v02)/5;%Number of lines plotted

%plot(v01(1:tn,1),v01(1:tn,4),'color','b') % v02 displacement of cylinder 1 (forced)
%hold on; 
hold off
figure(5)
%figure

if ~exist('start','var') || isempty(start)
  start=1;
end

[t1,y1]=textscan_ft(A1,f1);% 1 denotes force coefficient
dt1=t1(20)-t1(19);           
[t2,y2]=textscanty;         % 2 denotes displacement
dt2=t2(20)-t2(19);  
%% Auto cut by comparing amplitude
[t1,y1,t2,y2]=autocut(f1,t1,y1,t2,y2);
%%
note1='Cy02';
note2='Y';

%L = min([length(y1),length(y2),length(t1),length(t2)]);
L = length(y1);
if ~exist('nT','var') || isempty(nT)
    th1=t1(start:end);th2=t2(start:end);
    yh1=y1(start:end);yh2=y2(start:end);
else
    NnT1=ceil(1/f1*nT/dt1);NnT2=ceil(1/f1*nT/dt2);%NnT= number of steps for nT periods
     th1=t1(L-NnT1:end);th2=t2(L-NnT2:end);
     yh1=y1(L-NnT1:end);yh2=y2(L-NnT2:end);
%    th1=t1(1:NnT1);th2=t2(1:NnT1);
 %   yh1=y1(1:NnT1);yh2=y2(1:NnT1);
end

%% plot last few periods of time history
%% left for coefficient
h(1)=plot(th1,yh1,'color','black'); % v02 coefficient of cylinder 2 (free)
%xlabel('t*fn2');
xlabel('$tf_{n}$','Interpreter','LaTex','FontSize',20)
ylabel('$C_{Y2}$','Interpreter','LaTex','FontSize',20)

%% right for displacement
hold on
yyaxis right
%h(2)=plot(th2,yh2,'color','r','LineStyle','--');
h(2)=plot(th2,yh2,'color','r','LineStyle','--');
ylabel('$Y$','Interpreter','LaTex','FontSize',20)
axr = gca;axr.YColor = 'k';%set color of yaxis 

%% align zero for left and right
yyaxis right; ylimr = get(gca,'Ylim');ratio = ylimr(1)/ylimr(2);
yyaxis left; yliml = get(gca,'Ylim');
if yliml(2)*ratio<yliml(1)
    set(gca,'Ylim',[yliml(2)*ratio yliml(2)])
else
    set(gca,'Ylim',[yliml(1) yliml(1)/ratio])
end


%%
if ~exist('ylimthl','var') || isempty(ylimthl); else; yyaxis left; ylim(ylimthl); end
if ~exist('ylimthr','var') || isempty(ylimthr); else; yyaxis right; ylim(ylimthr); end
if ~exist('f1','var') || isempty(f1)
else
    temp=['$f_1=',num2str(f1),'$'];
    hl = legend(['$C_{Y2}$ ',temp],['$Y_2$\ \ \ ',temp]);
    set(hl,'Interpreter','latex','FontSize',15)
    %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
end

if ~exist('ttl','var') || isempty(ttl); else; title(ttl); end
if ~exist('pdir','var') || isempty(pdir); else; cd(pdir); 
    printpdf(gcf,[pname,'_',note1,'_Time_history.eps']);
end


hold off
%% Plot Entire time history for fft
figure(6)
%% left for coefficient
h(1)=plot(t1,y1,'color','black'); % v02 coefficient of cylinder 2 (free)
%xlabel('t*fn2');
xlabel('$tf_{n}$','Interpreter','LaTex','FontSize',20)
ylabel('$C_{Y2}$','Interpreter','LaTex','FontSize',20)

%% right for displacement
hold on
yyaxis right
%h(2)=plot(th2,yh2,'color','r','LineStyle','--');
h(2)=plot(t2,y2,'color','r','LineStyle','--');
ylabel('$Y$','Interpreter','LaTex','FontSize',20)
axr = gca;axr.YColor = 'k';%set color of yaxis 

%% align zero for left and right
yyaxis right; ylimr = get(gca,'Ylim');ratio = ylimr(1)/ylimr(2);
yyaxis left; yliml = get(gca,'Ylim');
if yliml(2)*ratio<yliml(1)
    set(gca,'Ylim',[yliml(2)*ratio yliml(2)])
else
    set(gca,'Ylim',[yliml(1) yliml(1)/ratio])
end

hold off
%%
if ~exist('ylimthl','var') || isempty(ylimthl); else; yyaxis left; ylim(ylimthl); end
if ~exist('ylimthr','var') || isempty(ylimthr); else; yyaxis right; ylim(ylimthr); end
if ~exist('f1','var') || isempty(f1)
else
    temp=['$f_1=',num2str(f1),'$'];
    hl = legend(['$C_{Y2}$ ',temp],['$Y_2$\ \ \ ',temp]);
    set(hl,'Interpreter','latex','FontSize',15)
    %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
end

if ~exist('ttl','var') || isempty(ttl); else; title(ttl); end
if ~exist('pdir','var') || isempty(pdir); else; cd(pdir); 
    printpdf(gcf,[pname,'_',note1,'_Time_history.eps']);
end
%% FTT plot below


figure(7)
         
%% Key
[f, P1]=fftzp2(t1,y1);
%%
plot(f,P1,'color','black') 
xlim([0 2.5]);
if ~exist('ylimfft','var') || isempty(ylimfftl)
else
    ylim(ylimfftl);
end

if ~exist('ttl','var') || isempty(ttl)
else
    title(ttl);
end

xlabel('$f_2$','Interpreter','LaTex','FontSize',20)
ylabel('$C_{YA2}$','Interpreter','LaTex','FontSize',20);

hold on
%% Right of yyaxis
yyaxis right
                        % Sampling period       
%% Key
%figure(7)
[f, P1]=fftzp2(t2,y2);


%%
plot(f,P1,'color','r','LineStyle','--') 
xlim([0 2.5]);
if ~exist('ylimfftr','var') || isempty(ylimfftr)
else
    ylim(ylimfftr);
end
axr = gca;axr.YColor = 'k';%set color of yaxis 
if ~exist('f1','var') || isempty(f1)
else
    temp=['$f_1=',num2str(f1),'$'];
    hl = legend(['$C_{Y2}$ ',temp],['$Y_2$\ \ \ ',temp]);
    set(hl,'Interpreter','latex','FontSize',15)
    %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
end

    
xlabel('$f$','Interpreter','LaTex','FontSize',20)
ylabel('$A_2$','Interpreter','LaTex','FontSize',20);




%%
if ~exist('pdir','var') || isempty(pdir)
else
    cd(pdir)
    printpdf(gcf,[pname,'_',note1,'_FFT_.eps']);

end


%tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%mkdir(['plotting/',list0(j).name])
%cd (['plotting/',list0(j).name])
%print('-dpng','-r500',['Plotting_',tiname,'.pdf']);
%cd('C:\Users\Zhonglu\OneDrive - University Of Cambridge\OneDrive\PhDWorks\VIV')

end

