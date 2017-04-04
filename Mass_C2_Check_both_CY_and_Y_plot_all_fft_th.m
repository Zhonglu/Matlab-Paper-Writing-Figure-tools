
clear all
close all

sysdir

list0=dir('g*a*m*r141');
n0=length(list0);
s=0;resc=0;Re=100;
%result(resc,:)=['G','A','m.*','f1','r_task_ID','Re','steady_periods','more than 10 periods or not'];
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
        %if f1<=0.96||f1>=1.03; continue; end
        %if f1~=1.00; continue; end
        close all
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
        start=0;
        f1=f1;A1=A1;
        nT=4;%nT last periods will be displayed
        ylimfftl=[];ylimfftr=[];
        %ylimthl=[-1.5 1.5];ylimthr=[-0.04 0.04];
        ylimthl=[];ylimthr=[];
        mr=m;
        [err,stperiods]=checkplot_CY_and_Y(fdir,zpf,start,pdir,ttl_p,pname,ylimfftl,f1,nT,ylimthl,A1,ylimfftr,ylimthr,mr);
        if err~=-1
            saveas(gcf,[ttl,'.fig'])
        end
        resc=resc+1;
        result(resc,:)=[gamr(1:3) f1 gamr(4) Re stperiods -1];
        cd ('../')
        cd ('../')
        csvwrite(['gamfr_Re_stperiods.dat'],result)
    end
    

    
end




%%
%clc
function [err,stperiods]=checkplot_CY_and_Y(fdir,zpf,start,pdir,ttl_p,pname,ylimfftl,f1,nT,ylimthl,A1,ylimfftr,ylimthr,mr)
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
dt1=t1(20)-t1(19);           
[t2,y2,v2]=textscanty;         % 2 denotes displacement
dt2=t2(20)-t2(19);  

%% Verification config
condit=false; %condition to trigger verification plotting
fdname='Verification';
%% (from Cy to Y) Cy and Y relationship validation  ==========  
if condit
    sysdir
    mkdir(fdname)
    cd(fdname)
    
%% verification CY2_val
    Cy_sim=y1;Vr=2.*pi.*A1.*f1;%Cyt=t1;
    rightn=(2/pi.*(Vr)^2/mr).*Cy_sim;
    
    n_int_t=sum(t1<=100);% the index at t1 closest to 100
    y0=[y2(n_int_t) v2(n_int_t)];
    
    tspan=[t1(n_int_t):dt1:241];
    [t_val,Cy_val_temp]=ode45(@ODEs,tspan,y0,[],t1,rightn);
    Cy_val=Cy_val_temp(:,1);
    
    %plot(a(:,1),a(:,2));
%         figure
%         hold on;
%         plot(t_s,a(:,1),'k-') ;
%         plot(t2,y2,'r--');

    xlim([237 240]); %ylim([-1 1]);
    xlabel('$tf_n$','Interpreter','LaTex','FontSize',20)
    ylabel('$Y_2/D$','Interpreter','LaTex','FontSize',20)
    
    hl=legend('$Y_{2,val}/D$','$Y_2/D$');set(hl,'Interpreter','latex','FontSize',20);
    
    %printpdf(gcf,['f1=1_time_history_comparison_from_Cy_to_Y2.eps']);
    
    %subplot(2,1,2) ;plot(t_s,a(:,2)) ; % a(1) is Y_2
    %hold on;
    %subplot(2,1,1) ; ;
    %subplot(2,1,2) ;plot(t_s,a(:,2)) ;
    
    %%
    Cy_sim=y1;%Cyt=t1;t=Cyt;
    figure(2);hold on;
    %Cyt=[dt1:2e-04:245];
    
    
    input_force_frequency=2;%
    Cyt=[dt1:dt1/2:245];
    %Cyt=t1;
    %% random noise
    %r1 = rand(length(Cyt),1)*dt1/1; % random noise
    %Cyt=Cyt+r1';
    %% functions to model Cy
    %Cysin = 0.0231824755675313 - 0.0103509988892154.*cos(4.85136899955705 - 18.8500005272845.*t) - 0.23551358625904.*sin(4.72967531292306 - 12.5663609263014.*t);
    t=Cyt;Cy2_sin = 0.0226809015035037 - 0.235834694520537.*sin(5.06307730580011 - 2.*pi*input_force_frequency*t);f1=1.0
    %Cy2_sin = 39.9709775505053*sin(1.18846623393097 + 4.71244446755185*t) - 0.0392091319237; % f1=0.75
    %Cy2_sin = 5.88443828151987 + 7.49919551325746*sin(5.04534584948306 - 2.35412178376292*t) - 11.9765659719409.*sin(4.98660909522323 - 2.38968829170992*t).*sin(3.04665996562926 - 2.32286028329614*t); % 0.375
    %Cy2_sin = 5.94610162229417*sin(3.2432990120742 - 4.71244656819651*t) - 0.0627467926225541 - 7.50635901415724*cos(1.61543065413503 - 2.35594005056044*t); %0.375
    %Cy2_sin = 5.94610162229417*sin(3.2432990120742 - 4.71244656819651*t) - 0.0627467926225541 - 7.50635901415724*cos(1.61543065413503 - 2.35594005056044*t); %0.375
    %Cysin = 0.0234873289247971 + 5.59190809320121e-5..*cos(1.5247204956213 + 18.8496081212669..*t).^3 + 2.3496138199634e-5..*sin(4.73205289765201 - 12.5663700806052..*t)..*cos(1.5247204956213 + 18.8496081212669..*t) - 0.0103898420278672..*cos(1.5247204956213 + 18.8496081212669..*t) - 0.23549277651046..*sin(4.73205289765201 - 12.5663700806052..*t) - 0.000641330628350327..*sin(4.73205289765201 - 12.5663700806052..*t).^2;
    %Cysin=y1;
    
    %% Windowing kaiser
%     M = length(Cyt); 
%     w = kaiser(M,5); 
%     Cy2_sin = w'.*Cy2_sin'; 
    %%
    
    plot(t1,Cy_sim,'-k')
    plot(Cyt,Cy2_sin,'--r')
    %ylim([-0.25 0.3])
    xlim([237 240])
    
    %hl=legend('$C_{Y2}$','$C_{Y2,sin}$');set(hl,'Interpreter','latex','FontSize',15);
    xlabel('$tf_n$','Interpreter','LaTex','FontSize',20)
    
    %printpdf(gcf,['simulated cy input vs sinusoidal cy input_','f1_',num2str(f1),'.eps']);

    %% Numerical solution
    Vr=2.*pi.*A1.*f1;
    rightn=(2/pi.*(Vr)^2/mr).*Cy2_sin;
    
    dt=Cyt(20)-Cyt(19);
    %tspan=[0:241];%t1;%
    n_int_t=sum(t1<=100);% the index at t1 closest to 100
    y0=[y2(n_int_t) v2(n_int_t)];
    
    tspan=[t1(n_int_t):dt1:242];
    [t_s,a]=ode45(@ODEs,tspan,y0,[],Cyt,rightn);
    %plot(a(:,1),a(:,2));
    t2_sin=t_s; y2_sin=a(:,1);
        %% Analytical Solution
    Vr=2.*pi.*A1.*f1;% /(fn
    syms y(t)
    %eqn='(D2y+4*pi*pi*y)=0.0226809015035037 - 0.235834694520537*sin(5.06307730580011 - 2*pi*2*t)';
    eqn=diff(y,t,2)+4*pi*pi*y==2/pi*Vr*Vr/mr*(0.0226809015035037 - 0.235834694520537*sin(5.06307730580011 - 2*pi*2*t));
    Dy=diff(y,t);
    cond=[y(t1(n_int_t))==y2(n_int_t),Dy(t1(n_int_t))==v2(n_int_t)];
    %solution=dsolve(eqn,init,'t');
    ySol(t) = dsolve(eqn,cond);
    
    %figure(3);fplot(ySol(t))
    
    %figure;
    %[f, P1]=fftzp2(t,yy02_anl);
    %plot(f,P1,'color','r','LineStyle','--');
    %xlim([0 2.4]);%ylim([-0.3 0.3]);
    %xlabel('$f/f_n$','Interpreter','LaTex','FontSize',20)
    %%
    
    %%
    %figure(3)
    hold on;
    %plot(t,yy02_anl,'g:');
    
    %plot(t_val,Cy_val,'b-.');
    %ylabel('$Y_2/D$','Interpreter','LaTex','FontSize',20)
    yyaxis left
    ylabel('$C$','Interpreter','LaTex','FontSize',20)
    yyaxis right
    ylabel('$Y/D$','Interpreter','LaTex','FontSize',20)
    plot(t2,y2,'k:');
    plot(t2_sin,y2_sin,'r-.'); %sinusoidal input
    
    xlim([237 240]); %ylim([-1 1]);
    xlabel('$tf_n$','Interpreter','LaTex','FontSize',20)
    
    
    hl=legend('$C_{Y2}$','$C_{Y2,sin}$','$Y_2/D$','$Y_{2,sin}/D$');set(hl,'Interpreter','latex','FontSize',20);
    %printpdf(gcf,['test2.eps']);
    printpdf(gcf,['displacement_verification_','f1_',num2str(f1),'.eps']);
    
    t1_pre=t1;y1_pre=y2;
    [t1,y1,t2,y2]=autocut(f1,t1,y1,t2,y2);
    %[Cyt,Cy2_sin,t2_sin,y2_sin]=autocut(f1,Cyt,Cy2_sin,t2_sin,y2_sin);
    %plot fft of input
    figure(4);hold on;
    [f, P1]=fftzp2(t1,y1);
    plot(f,P1,'color','k','LineStyle','-');
    yyaxis right
    [f, P1]=fftzp2(t2,y2);
    plot(f,P1,'color','r','LineStyle','--');
    xlim([0 2.4]);%ylim([-0.3 0.3]);
    xlabel('$f/f_n$','Interpreter','LaTex','FontSize',20)
    temp=['$f_1/f_n=',num2str(f1),'$'];
    hl = legend(['$C_{Y2}$ ',temp],['$Y_2/D$\ \ \ ',temp]);set(hl,'Interpreter','latex','FontSize',20);
    
    printpdf(gcf,['simulation_results_','f1_',num2str(f1),'.eps']);
    
    figure(5);hold on;
    [f, P1]=fftzp2(t1,y1);
    plot(f,P1,'color','k','LineStyle','-');
    yyaxis right
    [f, P1]=fftzp2(t_val,Cy_val);
    plot(f,P1,'color','r','LineStyle','--');
    xlim([0 2.4]);%ylim([-0.3 0.3]);
    xlabel('$f/f_n$','Interpreter','LaTex','FontSize',20)
    temp=['$f_1/f_n=',num2str(f1),'$'];
    hl = legend(['$C_{Y2}$ ',temp],['$Y_{2,val}/D$\ \ \ ',temp]);
    title('Verification results')
    
    figure(6);hold on;
    [f, P1]=fftzp2(Cyt,Cy2_sin);
    plot(f,P1,'color','k','LineStyle','-');
    ylabel('$C_{AY2,sin}$','Interpreter','LaTex','FontSize',20)
    yyaxis right
    ylabel('$Y_{A2,sin}/D$','Interpreter','LaTex','FontSize',20)
    [f, P1]=fftzp2(t2_sin,y2_sin);
    plot(f,P1,'color','r','LineStyle','--');
    xlim([0 2.4]);%ylim([-0.3 0.3]);
    xlabel('$f/f_n$','Interpreter','LaTex','FontSize',20)
    temp=['$f_1/f_n=',num2str(f1),'$'];
    hl = legend(['$C_{Y2,sin}$ ',temp],['$Y_{2,sin}/D$\ \ \ ',temp]);set(hl,'Interpreter','latex','FontSize',20);
    
    printpdf(gcf,['sinusoidal_input_results_','f1_',num2str(f1),'.eps']);
    %% dts investigate influence of time step series on the FFT results of Cy2
%     dts=zeros(length(t1)-1,1);
%     for i=1:length(t1)-1
%         dts(i)=t1(i+1)-t1(i);
%     end
    %S = std(dts);
    %linear approximation
    %tspan=linspace(min(t1),max(t1),length(t1));
    %Cy_test=linear_approx(tspan,t1,y1);
    
    cd ../
    
end
%% Auto cut by comparing amplitude
[t1,y1,t2,y2]=autocut(f1,t1,y1,t2,y2);
%%
note1='Cy02';
note2='Y';

%L = min([length(y1),length(y2),length(t1),length(t2)]);
L = length(y1); %total points after cut
stperiods=floor(L/(1/f1/dt1));% number of steady periods
if L-ceil(1/f1.*10/dt1)<=0 
    disp('less than 10 steady periods') ;err=-1;
    return;
else
    err=1;
end
if ~exist('nT','var') || isempty(nT)
    th1=t1(start:end);th2=t2(start:end);
    yh1=y1(start:end);yh2=y2(start:end);
else
    NnT1=ceil(1/f1.*nT/dt1);NnT2=ceil(1/f1.*nT/dt2);%NnT= number of steps for nT periods

     th1=t1(L-NnT1:end);th2=t2(L-NnT2:end);
     yh1=y1(L-NnT1:end);yh2=y2(L-NnT2:end);
%    th1=t1(1:NnT1);th2=t2(1:NnT1);
 %   yh1=y1(1:NnT1);yh2=y2(1:NnT1);
end

if condit
    %% Cy and Y relationship validation (from Y to Cy) ==========   

    sysdir
    %mkdir(fdname)
    cd(fdname)
    dYdt=diff(y2)/dt2;ddYdt=diff(dYdt)/dt2;
    Y=y2;Y=Y(1:length(ddYdt));
    Cy02_val=(ddYdt+4.*pi^2.*Y)/(2/pi.*(2.*pi.*A1.*f1)^2/mr);

    %plot time history comparison========================================
    figure;hold on
    Y_co=Y.*4.*pi^2;
    plot(t1(1:length(ddYdt) ),  y1(1:length(ddYdt)),  'color','b','LineStyle','-')
    plot(t1( 1:length(Cy02_val)), Cy02_val,               'color','r','LineStyle','--');
    hl=legend('$C_{Y2}$','$C_{Y2,val}$');set(hl,'Interpreter','latex','FontSize',15);
    xlim([237 240]);ylim([-1 1]);
    xlabel('$tf_n$','Interpreter','LaTex','FontSize',20)
    printpdf(gcf,['f1=1_time_history_comparison_2 _terms.eps']);

    %plot time history comparison========================================
    figure;hold on
    Y_co=Y.*4.*pi^2;
    plot(t1( 1:length(Y_co) ),  Y_co,               'color','r','LineStyle','-');
    plot(t1( 1:length(ddYdt) ), ddYdt,              'color','b','LineStyle','--');
    plot(t1( 1:length(ddYdt) ), (4.*pi^2.*Y+ddYdt),   'color','green','LineStyle','-.');
    plot(t1( 1:length(Cy02_val)), Cy02_val,             'color','black','LineStyle',':');
    %plot(t1(1:length(ddYdt) ),y1(1:length(ddYdt)),t1(1:length(ddYdt)),CL_val)
    hl=legend('$(4\pi^2Y_2)/D$','$(d^2Y_2/dt^2)/D$','$(4\pi^2Y_2+d^2Y_2/dt^2)/D$','$C_{Y2,val}$');set(hl,'Interpreter','latex','FontSize',15);
    xlim([237 240]);ylim([-1 1]);
    xlabel('$tf_n$','Interpreter','LaTex','FontSize',20)
    printpdf(gcf,['f1=1_time_history_comparison_4_terms.eps']);

    %plot each term's FFT on the left of mass-spring equation=============
    figure;hold on
    Y_co=Y.*4.*pi^2;
    [f, P1]=fftzp2(t1( 1:length(Y_co) ),Y_co);plot(f,P1,'color','r','LineStyle','-');
    [f, P1]=fftzp2(t1( 1:length(ddYdt) ),ddYdt);plot(f,P1,'color','b','LineStyle','--');
    [f, P1]=fftzp2(t1( 1:length(ddYdt) ),(4.*pi^2.*Y+ddYdt));plot(f,P1,'color','green','LineStyle','-.');
    [f, P1]=fftzp2(t1( 1:length(Cy02_val) ),Cy02_val);plot(f,P1,'color','black','LineStyle',':');
    hl=legend('$(4\pi^2Y_2)/D$','$(d^2Y_2/dt^2)/D$','$(4\pi^2Y_2+d^2Y_2/dt^2)/D$','$C_{Y2,val}$');set(hl,'Interpreter','latex','FontSize',15);
    xlim([0 2.4]);%ylim([-0.3 0.3]);
    xlabel('$f/f_n$','Interpreter','LaTex','FontSize',20)
    printpdf(gcf,['f1=1_FFT_comparison_4_terms.eps']);

    %plot FFT comparison =================================================
    figure;hold on;
    [f, P1]=fftzp2(t1,y1);
    plot(f,P1,'color','b','LineStyle','-');
    [f, P1]=fftzp2(t1( 1:length(ddYdt) ),Cy02_val);
    plot(f,P1,'color','r','LineStyle',':');
    xlim([0 2.5])
    hl=legend('$C_{Y2}$','$C_{Y2,val}$');set(hl,'Interpreter','latex','FontSize',15);
    xlabel('$f/f_n$','Interpreter','LaTex','FontSize',20)
    printpdf(gcf,['f1=1_FFT_comparison_2_terms.eps']);
    %ylabel('$C$','Interpreter','LaTex','FontSize',20);
    %}
    printpdf(gcf,['f1=1_FFT_comparison_CL_CL_val.eps']);
    
    cd ../
    %% ============================== end of verification
end

hold off
figure(15)
%% plot last few periods of time history
%% left for coefficient
h(1)=plot(th1,yh1,'color','black'); % v02 coefficient of cylinder 2 (free)
%xlabel('t.*fn2');
xlabel('$tf_{n}$','Interpreter','LaTex','FontSize',20)
ylabel('$C_{Y2}$','Interpreter','LaTex','FontSize',20)

%% right for displacement
hold on
yyaxis right
%h(2)=plot(th2,yh2,'color','r','LineStyle','--');
h(2)=plot(th2,yh2,'color','r','LineStyle','--');
ylabel('$y/D$','Interpreter','LaTex','FontSize',20)
axr = gca;axr.YColor = 'k';%set color of yaxis 

%% align zero for left and right
xlim([th1(1) th1(end)])
yyaxis right; ylimr = get(gca,'Ylim');ratio = ylimr(1)/ylimr(2);
yyaxis left; yliml = get(gca,'Ylim');
if yliml(2).*ratio<yliml(1)
    set(gca,'Ylim',[yliml(2).*ratio yliml(2)])
else
    set(gca,'Ylim',[yliml(1) yliml(1)/ratio])
end


%%
if ~exist('ylimthl','var') || isempty(ylimthl); else; yyaxis left; ylim(ylimthl); end
if ~exist('ylimthr','var') || isempty(ylimthr); else; yyaxis right; ylim(ylimthr); end
if ~exist('f1','var') || isempty(f1)
else
    temp=['$f_1/f_n=',num2str(f1),'$'];
    hl = legend(['$C_{Y2}$ ',temp],['$Y_2/D$\ \ \ ',temp]);
    set(hl,'Interpreter','latex','FontSize',15)
    %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
end

if ~exist('ttl','var') || isempty(ttl); else; title(ttl); end
if ~exist('pdir','var') || isempty(pdir); else; cd(pdir); 
    printpdf(gcf,[pname,'_',note1,'_Time_history_last_periods.eps']);
end


hold off
%% Plot Entire time history for fft
figure(6)
%% left for coefficient
h(1)=plot(t1,y1,'color','black'); % v02 coefficient of cylinder 2 (free)
%xlabel('t.*fn2');
xlabel('$tf_{n}$','Interpreter','LaTex','FontSize',20)
ylabel('$C_{Y2}$','Interpreter','LaTex','FontSize',20)

%% right for displacement
hold on
yyaxis right
%h(2)=plot(th2,yh2,'color','r','LineStyle','--');
h(2)=plot(t2,y2,'color','r','LineStyle','--');
ylabel('$y/D$','Interpreter','LaTex','FontSize',20)
axr = gca;axr.YColor = 'k';%set color of yaxis 

%% align zero for left and right
yyaxis right; ylimr = get(gca,'Ylim');ratio = ylimr(1)/ylimr(2);
yyaxis left; yliml = get(gca,'Ylim');
if yliml(2).*ratio<yliml(1)
    set(gca,'Ylim',[yliml(2).*ratio yliml(2)])
else
    set(gca,'Ylim',[yliml(1) yliml(1)/ratio])
end

hold off
%%
if ~exist('ylimthl','var') || isempty(ylimthl); else; yyaxis left; ylim(ylimthl); end
if ~exist('ylimthr','var') || isempty(ylimthr); else; yyaxis right; ylim(ylimthr); end
if ~exist('f1','var') || isempty(f1)
else
    temp=['$f_1/f_n=',num2str(f1),'$'];
    hl = legend(['$C_{Y2}$ ',temp],['$Y_2/D$\ \ \ ',temp]);
    set(hl,'Interpreter','latex','FontSize',15)
    %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
end

if ~exist('ttl','var') || isempty(ttl); else; title(ttl); end
if ~exist('pdir','var') || isempty(pdir); else; cd(pdir); 
    printpdf(gcf,[pname,'_',note1,'_Time_history_all_used.eps']);
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

xlabel('$f_2/f_n$','Interpreter','LaTex','FontSize',20)
ylabel('$C_{AY2}$','Interpreter','LaTex','FontSize',20);

hold on
%% Right of yyaxis
yyaxis right
                        % Sampling period    

%% Key
%figure(7)
[f, P1]=fftzp2(t2,y2);plot(f,P1,'color','r','LineStyle','--');
xlim([0 2.5]);
if ~exist('ylimfftr','var') || isempty(ylimfftr)
else
    ylim(ylimfftr);
end
axr = gca;axr.YColor = 'k';%set color of yaxis 
if ~exist('f1','var') || isempty(f1)
else
    temp=['$f_1/f_n=',num2str(f1),'$'];
    hl = legend(['$C_{Y2}$ ',temp],['$Y_2/D$\ \ \ ',temp]);
    set(hl,'Interpreter','latex','FontSize',15)
    %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
end

    
xlabel('$f$','Interpreter','LaTex','FontSize',20)
ylabel('$A_2/D$','Interpreter','LaTex','FontSize',20);




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

