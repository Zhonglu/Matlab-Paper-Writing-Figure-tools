% producing the figure of phase differenece

clear all
close all
fclose all;

sysdir
cd ""
list0=dir('g0.4a*m1.5d0.20r*');
n0=length(list0);
s=0;resc=0;Re=100;
%result(resc,:)=['G','A','m.*','f1','r_task_ID','Re','steady_periods','more than 10 periods or not'];
for j=1:n0 %1:n0
    fclose('all');
    cd (list0(j).name)
    listf1=dir('0*');
    n=length(listf1);
    cd ('../')
    
    str=list0(j).name;
    gamr=s2gamr(str);
    
    G=gamr(1);
    A1=gamr(2);
    m=gamr(3);
    d=gamr(4);
    if j==1
        Gmin=G;Gmax=G;
        A1min=A1;A1max=A1;
        mmin=m;mmax=m;
        dmin=d;dmax=d;
    else
        if Gmin>G;Gmin=G;end;if Gmax<G;Gmax=G;end
        if A1min>A1;A1min=A1;end;if A1max<A1;A1max=A1;end
        if mmin>m;mmin=m;end;if mmax<m;mmax=m;end
        if dmin>d;dmin=d;end;if dmax<d;dmax=d;end
    end
    
    %if d==0.05||d==0.1; continue; end
    %%
    if G==0.8; continue; end %cases of G==0.8's simulations are not successful
    %if G<0.3; continue; end
    
    
    %%
    cphsc1=zeros(1,n);
    yphsc1=zeros(1,n);
    cphsc2=zeros(1,n);
    yphsc2=zeros(1,n);
    cphsc1f1=zeros(1,n);
    yphsc1f1=zeros(1,n);
    cphsc2f1=zeros(1,n);
    yphsc2f1=zeros(1,n);
    cphsc1f2=zeros(1,n);
    yphsc1f2=zeros(1,n);
    cphsc2f2=zeros(1,n);
    yphsc2f2=zeros(1,n);
    f1s=zeros(1,n);
    for i=1:n % i=1:n
        f1=str2double(listf1(i).name);
        f1s(i)=f1;
        %if f1<=0.7||f1>=0.8; continue; end
        %if f1<=0.96||f1>=1.03; continue; end
        %if f1~=0.40; continue; end
        %if ~(f1<=2.4 && f1>=1.3); continue; end
        %if f1~=0.375; continue; end
        %if f1~=1.80; continue; end
        %close all
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
        [err,stperiods,cphsc1(i),yphsc1(i),cphsc2(i),yphsc2(i),cphsc1f1(i),yphsc1f1(i),cphsc2f1(i),yphsc2f1(i),cphsc1f2(i),yphsc1f2(i),cphsc2f2(i),yphsc2f2(i)]=checkplot_CY_and_Y(fdir,zpf,start,pdir,ttl_p,pname,ylimfftl,f1,nT,ylimthl,A1,ylimfftr,ylimthr,mr);
        if err~=-1
            %saveas(gcf,[ttl,'.fig'])
        end
        resc=resc+1;
        result(resc,:)=[gamr(1:3) f1 gamr(4) Re stperiods -1];
        
        cd ('../')
        cd ('../')
        %csvwrite(['gamfr_Re_stperiods.dat'],result)
    end
    
    %% plot phase-f1
    hold off
    %% max amplitude phase difference
    %figure;plot(f1s,cphsc2);title('C2 force phase')%plot phase of force coefficient (dominant frequency with largest amplitude)
    %figure;plot(f1s,yphsc2);title('C2 disp phase')%plot phase of displacement
    %figure(14);hold on;plot(f1s,cphsc2-yphsc2);title('C2 force-disp phase difference for max amp') % plot phase difference
    
    %figure;plot(f1s,cphsc1);title('C1 force phase')%plot phase of force coefficient (dominant frequency with largest amplitude)
    %figure;plot(f1s,yphsc1);title('C1 disp phase')%plot phase of displacement
    %%%%figure(15);hold on;plot(f1s,cphsc1-yphsc1); title('C1 force-disp phase diff for max amp') % plot phase difference
    
    %plot(f1s,yphsc1)%plot phase of force coefficient (dominant frequency with largest amplitude)
    %plot(f1s,yphsc2)%plot phase of displacement
    %%%%figure(16);hold on;plot(f1s,yphsc2-yphsc1); title('C2-C1 disp phase diff for max amp') % plot phase difference
    

    
    %% f=f1 phase difference

    
    titletemp1='C2_force-disp_phase_diff_at_f=f1';
    figure(17);hold on;plot(f1s,cphsc2f1-yphsc2f1);%title(titletemp1) % plot phase difference
    grid on; yticks([0:45:180]); xticks([0:0.25:2.5])
    %figure(21);plot(f1s,cphsc1f1-yphsc1f1); title('C1 force-disp phase diff at f=f1') % plot phase difference
    
    
    titletemp2='C2_force_-_C1_disp_phase_diff_at f=f1';
    figure(18);hold on;plot(f1s,cphsc2f1-yphsc1f1); %title(titletemp2) % plot phase difference
    grid on; yticks([0:45:180]); xticks([0:0.25:2.5]);xlabel('$f_1/f_n$','Interpreter','LaTex','FontSize',20);ylabel('Phase (degrees)','Interpreter','LaTex','FontSize',20)

    figure(20);hold on;
    temp1=yphsc2f1-yphsc1f1;
    temp1(temp1>=270)=temp1(temp1>=270)-360;temp1(temp1<=-90)=temp1(temp1<=-90)+360; % vectorised adjust
    
    titletemp3='C2-C1_disp_phase_diff_at_f=f1';
    plot(f1s,temp1); %title(titletemp3) % plot phase difference
    grid on; yticks([0:45:180]); xticks([0:0.25:2.5]);xlabel('$f_1/f_n$','Interpreter','LaTex','FontSize',20);ylabel('Phase (degrees)','Interpreter','LaTex','FontSize',20)
    
    
    %cd ../
    
    figure(1)
    
    
    
    %% f=f2 phase difference
    %         figure;plot(f1s,cphsc2f2-yphsc2f2,'k');title('C2 force-disp phase diff at f=2f1') % plot phase difference
    %         grid on; yticks([0:45:180]); xticks([0:0.25:2.5])
    %
    %         figure;plot(f1s,cphsc1f2-yphsc1f2); title('C1 force-disp phase diff at f=2f1') % plot phase difference
    %
    %         figure;plot(f1s,yphsc2f2-yphsc1f2); title('C2-C1 disp phase diff at f=2f1') % plot phase difference
    %
    %         figure;plot(f1s,yphsc2f2-yphsc1f1,'k'); title('C2 2f1-C1 f1 disp phase difference') % plot phase difference
    %         grid on; yticks([0:45:180]); xticks([0:0.25:2.5])
    %
    
    %%
    
    
end


    tempo=['phase_diff/'];
    mkdir(tempo)
    cd (tempo)
    disp(tempo)
    
        notetemp=['_G=',num2str(Gmin),'-',num2str(Gmax),...
        '_A1=',num2str(A1min),'-',num2str(A1max),...
        '_m=',num2str(mmin),'-',num2str(mmax),...
        '_dmin=',num2str(dmin),'_dmax=',num2str(dmax)];
    
    saveas(17,[titletemp1,...
        notetemp,'.fig'])
    saveas(18,[titletemp2,...
        notetemp,'.fig'])
    saveas(20,[titletemp3,...
        notetemp,'.fig'])

cd ../

%%
%clc
function [err,stperiods,cphsc1,yphsc1,cphsc2,yphsc2,cphsc1f1,yphsc1f1,cphsc2f1,yphsc2f1,cphsc1f2,yphsc1f2,cphsc2f2,yphsc2f2]=checkplot_CY_and_Y(fdir,zpf,start,pdir,ttl_p,pname,ylimfftl,f1,nT,ylimthl,A1,ylimfftr,ylimthr,mr)
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

[t1c2,y1c2]=textscan_ft(A1,f1);% 1 denotes C2's force coefficient
dt1=t1c2(20)-t1c2(19);
[t2c2,y2c2,~]=textscanty;         % 2 C2's denotes displacement
dt2=t2c2(20)-t2c2(19);

[t1c1,y1c1]=textscan_ft(A1,f1,1);% 1 denotes force coefficient
%dt1=t1(20)-t1(19);
[t2c1,y2c1]=textscanty(1);         % 2 denotes displacement
%dt2=t2(20)-t2(19);

%% Verification config
condit=false;%f1==1.00; %condition to trigger verification plotting
fdname='Verification';

%% Auto cut by comparing amplitude
[t1c2,y1c2,t2c2,y2c2]=autocut(f1,t1c2,y1c2,t2c2,y2c2);
%[t1c1,y1c1,t2c1,y2c1]=autocut(f1,t1c1,y1c1,t2c1,y2c1);
%[t2c2,y2c2,t2c1,y2c1]=autocut(f1,t2c2,y2c2,t2c1,y2c1);
%%
note1='Cy02';
note2='Y';

if 0
    figure(30);plot(t2c1,y2c1,t2c2,y2c2);% check phase by time history
    close(figure(30))
end

lb=max(min(t2c1),min(t2c2));
temp2=t2c1<=lb;temp3=t2c2<=lb;
t2c1((temp2))=[];y2c1((temp2))=[];
t2c2((temp3))=[];y2c2((temp3))=[];

rb=min(max(t2c1),max(t2c2));
temp4=t2c1>=rb;temp5=t2c2>=rb;
t2c1((temp4))=[];y2c1((temp4))=[];
t2c2((temp5))=[];y2c2((temp5))=[];

%L = min([length(y1),length(y2),length(t1),length(t2)]);
L = length(y1c2); %total points after cut
stperiods=floor(L/(1/f1/dt1));% number of steady periods
if L-ceil(1/f1.*10/dt1)<=0
    disp('less than 10 steady periods') ;err=-1;
    return;
else
    err=1;
end
if ~exist('nT','var') || isempty(nT)
    th1=t1c2(start:end);th2=t2c2(start:end);
    yh1=y1c2(start:end);yh2=y2c2(start:end);
else
    NnT1=ceil(1/f1.*nT/dt1);NnT2=ceil(1/f1.*nT/dt2);%NnT= number of steps for nT periods
    
    th1=t2c1(L-NnT1:end);th2=t2c2(L-NnT2:end);
    yh1=y2c1(L-NnT1:end);yh2=y2c2(L-NnT2:end);
    %    th1=t1(1:NnT1);th2=t2(1:NnT1);
    %   yh1=y1(1:NnT1);yh2=y2(1:NnT1);
end

%% FTT plot below

%% C1 force and disp
%figure(6)

%% Key
cphsc1=0;
[~, ~,cphsc1, cphsc1f1,cphsc1f2]=fftphase(t1c1,y1c1,f1);






%====================================================================
%% C2 force and disp
%figure(7)

%% Key
cphsc2=0;
[~, ~,cphsc2,cphsc2f1,cphsc2f2]=fftphase(t1c2,y1c2,f1);

%% Key
%figure(7)
yphsc2=0;
[~, ~, yphsc2, yphsc2f1,yphsc2f2]=fftphase(t2c2,y2c2,f1);%plot(f,P1,'color','r','LineStyle','--');

%% Key
yphsc1=0;
[~, ~, yphsc1, yphsc1f1,yphsc1f2]=fftphase(t2c1,y2c1,f1);%plot(f,P1,'color','r','LineStyle','--');

%%

%tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%mkdir(['plotting/',list0(j).name])
%cd (['plotting/',list0(j).name])
%print('-dpng','-r500',['Plotting_',tiname,'.pdf']);
%cd('C:\Users\Zhonglu\OneDrive - University Of Cambridge\OneDrive\PhDWorks\VIV')
if ~exist('pdir','var') || isempty(pdir)
else
    cd(pdir)
    %printpdf(gcf,[pname,'_',note1,'_FFT_.eps']);
    
end
%%
if ~exist('pdir','var') || isempty(pdir)
else
    cd(pdir)
    %printpdf(gcf,[pname,'_',note1,'_FFT_.eps']);
    
end
end

