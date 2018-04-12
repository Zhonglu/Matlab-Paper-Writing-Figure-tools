
clear all
close all

sysdir

list0=dir('g*a*m*r141');
n0=length(list0);
s=0;resc=0;Re=100;
%result(resc,:)=['G','A','m*','f1','r_task_ID','Re','steady_periods','more than 10 periods or not'];
for j=1:n0 %1:n0
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
    gamr=str2num(str);
    
    G=gamr(1);
    A1=gamr(2);
    m=gamr(3);
    %%
    if G==0.8; continue; end %cases of G==0.8's simulations are not successful
    %if G<0.3; continue; end
    %%
    for i=1:n % i=1:n
        f1=str2double(listf1(i).name);
        %if f1<=0.7||f1>=0.8; continue; end
        if f1~=1.0; continue; end
        close all
        dirnamef=[list0(j).name,'/',listf1(i).name,'/'];
        %v01=load([dirname,'VIV01.DAT']);
        cd(dirnamef)
        disp(pwd);
        %[y,t]=loadv02yt(0);
        fdir=pwd;
        cd ../; cd ../;
        tempo=['Plot_pressure_shear_force_Coef/',list0(j).name];
        mkdir(tempo)
        cd (tempo)
        disp(tempo)
        
        ttl=['G=',num2str(G),'  A_1=',num2str(A1),'  m=',num2str(m),'  f1=',listf1(i).name,'  Cylinder 2'];
        pdir=pwd;
        pname=[list0(j).name,'_',listf1(i).name];
        
        if f1~=1.0; continue; end
        %plot_CY_and_Y(fdir,[],24000,pdir,[],pname,[],f1,4,[],A1,[],[])
        fdir=fdir;pname=pname;pdir=pdir;  
        zpf=[];ttl_p=[];
        start=0;
        f1=f1;A1=A1;
        nT=4;%nT last periods will be displayed
        ylimfftl=[];ylimfftr=[];
        %ylimthl=[-1.5 1.5];ylimthr=[-0.04 0.04];
        ylimthl=[];ylimthr=[];
        [err,stperiods]=checkplot_CY_and_Y(fdir,zpf,start,pdir,ttl_p,pname,ylimfftl,f1,nT,ylimthl,A1,ylimfftr,ylimthr);
        if err~=-1
            %saveas(gcf,[ttl,'.fig'])
        end
        resc=resc+1;
        result(resc,:)=[gamr(1:3) f1 gamr(4) Re stperiods -1];
        cd ('../')
        cd ('../')
        %csvwrite(['gamfr_Re_stperiods.dat'],result)
    end
    

    
end




%%
%clc
function [err,stperiods]=checkplot_CY_and_Y(fdir,zpf,start,pdir,ttl_p,pname,ylimfftl,f1,nT,ylimthl,A1,ylimfftr,ylimthr)
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

%figure

if ~exist('start','var') || isempty(start)
  start=1;
end

[t1,y1]=textscan_ft(A1,f1);% 1 denotes force coefficient
[t5,y5]=textscan_ft(A1,f1,25);% pressure force coefficient
[t7,y7]=textscan_ft(A1,f1,27);% shear force coefficient
dt1=t1(20)-t1(19);
dt5=t5(20)-t5(19);
dt7=t1(20)-t7(19);

[t2,y2]=textscanty;         % 2 denotes displacement
dt2=t2(20)-t2(19);  
%% Auto cut by comparing amplitude
[t1,y1,t2,y2,t5,y5,t7,y7]=autocut4(f1,t1,y1,t2,y2,t5,y5,t7,y7);

%%
note1='Cy02';
note2='Y';

%L = min([length(y1),length(y2),length(t1),length(t2)]);
L = length(y1); %total points after cut
stperiods=floor(L/(1/f1/dt1));% number of steady periods
if L-ceil(1/f1*10/dt1)<=0 
    disp('less than 10 steady periods') ;err=-1;
    return;
else
    err=1;
end
if ~exist('nT','var') || isempty(nT)
    th1=t1(start:end);th2=t2(start:end);
    yh1=y1(start:end);yh2=y2(start:end);
else
    NnT1=ceil(1/f1*nT/dt1);NnT2=ceil(1/f1*nT/dt2);%NnT= number of steps for nT periods
    NnT5=ceil(1/f1*nT/dt5);NnT7=ceil(1/f1*nT/dt7);

     th1=t1(L-NnT1:end);yh1=y1(L-NnT1:end);
     th5=t5(L-NnT5:end);yh5=y5(L-NnT5:end);
     th7=t7(L-NnT7:end);yh7=y7(L-NnT7:end);
     
     th2=t2(L-NnT2:end);yh2=y2(L-NnT2:end);

%    th1=t1(1:NnT1);th2=t2(1:NnT1);
%    yh1=y1(1:NnT1);yh2=y2(1:NnT1);
end

%hold off

figure(5)
hold on
%% plot last few periods of time history
%% left for coefficient
h(1)=plot(th1,yh1,'color','black'); % v02 coefficient of cylinder 2 (free)
h(2)=plot(th5,yh5,'color','black','LineStyle','-.');
h(3)=plot(th7,yh7,'color','black','LineStyle',':');
%xlabel('t*fn2');
xlabel('$tf_{n}$','Interpreter','LaTex','FontSize',20)
ylabel('$C_{Y2}$','Interpreter','LaTex','FontSize',20)

%% right for displacement
%hold on
yyaxis right
%h(2)=plot(th2,yh2,'color','r','LineStyle','--');
h(4)=plot(th2,yh2,'color','r','LineStyle','--');
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
    temp=['$f_1/f_n=',num2str(f1),'$'];
    hl = legend(['$C_{Y2}$ ',temp],['$C_{pressure,Y2}$ ',temp],['$C_{shear,Y2}$ ',temp],['$Y_2$\ \ \ ',temp]);
    set(hl,'Interpreter','latex','FontSize',15)
    %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
end

if ~exist('ttl','var') || isempty(ttl); else; title(ttl); end
if ~exist('pdir','var') || isempty(pdir); else; cd(pdir); 
    printpdf(gcf,[pname,'_',note1,'_Time_history_last_periods_total_pressure_shear.eps']);
end


hold off
%{
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
    printpdf(gcf,[pname,'_',note1,'_Time_history_all_used.eps']);
end
%}

%% FTT plot below  ======================================================
figure(7)
%% Key
hold on
%[f, P1]=fftzp2(t1,y1);plot(f,P1,'color','black') %total force
[f, P1]=fftzp2(t5,y5);plot(f,P1,'color','black','LineStyle','-') %pressure force
[f, P1]=fftzp2(t7,y7);plot(f,P1,'color','red','LineStyle','--')    %shear force
%%
xlim([0 2.5]);
if ~exist('ylimfft','var') || isempty(ylimfftl);else;    ylim(ylimfftl);end
if ~exist('ttl','var') || isempty(ttl); else;    title(ttl);end
xlabel('$f/f_n$','Interpreter','LaTex','FontSize',20)
ylabel('$C_{AY2}$','Interpreter','LaTex','FontSize',20);
hold on
%{ 
%% Right of yyaxis
yyaxis right % Sampling period       
%% Key

%[f, P1]=fftzp2(t2,y2);  plot(f,P1,'color','r','LineStyle','--') 
%%
xlim([0 2.5]);
if ~exist('ylimfftr','var') || isempty(ylimfftr)
else
    ylim(ylimfftr);
end
axr = gca;axr.YColor = 'k';%set color of yaxis 

xlabel('$f$','Interpreter','LaTex','FontSize',20)
ylabel('$C_{shear,Y2}$','Interpreter','LaTex','FontSize',20);
%}
if ~exist('f1','var') || isempty(f1)
else
    temp=['$f_1/f_n=',num2str(f1),'$'];
    hl = legend(['$C_{pressure,Y2}$ ',temp],['$C_{shear,Y2}$ ',temp],['$Y_2$\ \ \ ',temp]);%['$C_{Y2}$ ',temp],
    set(hl,'Interpreter','latex','FontSize',15)
    %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
end
%xlabel('$f$','Interpreter','LaTex','FontSize',20)
%%
if ~exist('pdir','var') || isempty(pdir)
else
    cd(pdir)
    printpdf(gcf,[pname,'_',note1,'_FFT_total_pressure_shear.eps']);
end

%tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%mkdir(['plotting/',list0(j).name])
%cd (['plotting/',list0(j).name])
%print('-dpng','-r500',['Plotting_',tiname,'.pdf']);
%cd('C:\Users\Zhonglu\OneDrive - University Of Cambridge\OneDrive\PhDWorks\VIV')

end

function [t1,y1,t2,y2,t5,y5,t7,y7]=autocut4(f1,t1,y1,t2,y2,t5,y5,t7,y7)
    errlim=10e-4;
    cut1=findcut(f1,t1,y1,errlim);
    cut2=findcut(f1,t2,y2,errlim);
    cut5=findcut(f1,t5,y5,errlim);
    cut7=findcut(f1,t7,y7,errlim);
    cutp=min([cut1 cut2 cut5 cut7]);
    if cutp==0;cutp=1;end
    %Lmin=min([length(t1),length(t2),length(y1),length(y2)]);
    t1=t1(cutp:end);t2=t2(cutp:end);t5=t5(cutp:end);t7=t7(cutp:end);
    y1=y1(cutp:end);y2=y2(cutp:end);y5=y5(cutp:end);y7=y7(cutp:end);
    
end

function cutnt=findcut(f1,t,y,errlim)
    dt=t(20)-t(19);
    period1n=ceil(1/f1/dt)*2;%T1n points in one period, number of periods for A=(max-min)/2
    tn=length(t);
    nperiod=floor(tn/(period1n));
    %% Ast is the amplitude of last 5 periods with steady vibration
    tstartn=(nperiod-5-1)*period1n+1;tendn=nperiod*period1n;
    Ast=(max(y(tstartn:tendn))-min(y(tstartn:tendn)))*0.5;
    %% if the relative error is continuously small for 15 periods,
    s=0;%count periods that satisfies the condition, 5 statisfaction periods define the steady
    scheck=5;
    for i1=1:nperiod %
        tstartn=(i1-1)*period1n+1;
        tendn=i1*period1n;
        yamp(i1)=(max(y(tstartn:tendn))-min(y(tstartn:tendn)))*0.5;
        err(i1)=abs((yamp(i1)-Ast)/yamp(i1));%relative error
        if err(i1)<errlim
            s=s+1;
            if s==scheck
                break
            end
        end
    end

    cutnt=tendn-period1n*scheck;
end

%             dt=t1(20)-t1(19);
%             T1n=ceil(1/f1/dt);%T1n points in one period, number of periods for A=(max-min)/2
%             tn=length(t1);
%             nperiod=floor(tn/(T1n));
%             for i1=1:nperiod %
%                 tstartn=(i1-1)*T1n+1;
%                 tendn=i1*T1n;
%                 yamp(i1)=(max(y1(tstartn:tendn))-min(y1(tstartn:tendn)))*0.5;
%                 if i1>1; err1=(yamp(i1)-yamp(i1-1))/yamp(i1);end
%                 if i1>1 && err1<0.01;break;end
%             end
%             cutnt=tendn;
            
            
