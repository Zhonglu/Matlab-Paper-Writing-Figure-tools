
clear all
%close all

sysdir

list0=dir('g0.2a0.1m*r*');
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
        %if f1~=1.00; continue; end
        %if ~(f1<=0.45 && f1>=0.3); continue; end
        %if f1~=0.375; continue; end
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
        figure;plot(f1s,cphsc2-yphsc2);title('C2 force-disp phase difference for max amp') % plot phase difference
        
        
        
        %figure;plot(f1s,cphsc1);title('C1 force phase')%plot phase of force coefficient (dominant frequency with largest amplitude)
        %figure;plot(f1s,yphsc1);title('C1 disp phase')%plot phase of displacement 
        figure;plot(f1s,cphsc1-yphsc1); title('C1 force-disp phase diff for max amp') % plot phase difference
        
        
        %plot(f1s,yphsc1)%plot phase of force coefficient (dominant frequency with largest amplitude)
        %plot(f1s,yphsc2)%plot phase of displacement 
        figure;plot(f1s,yphsc2-yphsc1); title('C2-C1 disp phase diff for max amp') % plot phase difference
        
        %% f=f1 phase difference
        figure;plot(f1s,cphsc2f1-yphsc2f1);title('C2 force-disp phase diff at f=f1') % plot phase difference
        grid on; yticks([0:45:180]); xticks([0:0.25:2.5])
        figure;plot(f1s,cphsc1f1-yphsc1f1); title('C1 force-disp phase diff at f=f1') % plot phase difference
        
        figure;plot(f1s,yphsc2f1-yphsc1f1); title('C2-C1 disp phase diff at f=f1') % plot phase difference
        grid on; yticks([0:45:180]); xticks([0:0.25:2.5])
        xlabel('$f_1/f_n$','Interpreter','LaTex','FontSize',20);ylabel('Phase (degrees)','Interpreter','LaTex','FontSize',20)
        
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
    [t1c1,y1c1,t2c1,y2c1]=autocut(f1,t1c1,y1c1,t2c1,y2c1);
    [t2c2,y2c2,t2c1,y2c1]=autocut(f1,t2c2,y2c2,t2c1,y2c1);
    %%
    note1='Cy02';
    note2='Y';

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

    if false
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
    ylabel('$Y_2$','Interpreter','LaTex','FontSize',20)
    axr = gca;axr.YColor = 'k';%set color of yaxis 

    %% align zero for left and right
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
        hl = legend(['$Y_1/D$ ',temp],['$Y_2/D$\ \ \ ',temp]);
        set(hl,'Interpreter','latex','FontSize',15)
        %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
    end
    xlim([max([min(th1) min(th2)]) min([max(th1) max(th2)])])
    if ~exist('ttl','var') || isempty(ttl); else; title(ttl); end
    if ~exist('pdir','var') || isempty(pdir); else; cd(pdir); 
        sysdir
        tempdir='phase_check';
        mkdir(tempdir);cd(tempdir)
        printpdf(gcf,[pname,'_',note1,'_Time_history_last_periods.eps']);
    end

    hold off

    end
    %% FTT plot below

    %% C1 force and disp
    %figure(6)

    %% Key
    cphsc1=0;
    [f, P1,cphsc1, cphsc1f1,cphsc1f2]=fftphase(t1c1,y1c1,f1);
    %%
    % plot(f,P1,'color','black') 
    % xlim([0 2.5]);
    % if ~exist('ylimfft','var') || isempty(ylimfftl)
    % else
    %     ylim(ylimfftl);
    % end
    % 
    % if ~exist('ttl','var') || isempty(ttl)
    % else
    %     title(ttl);
    % end
    % 
    % title('C1')
    % xlabel('$f_2/f_n$','Interpreter','LaTex','FontSize',20)
    % ylabel('$C_{AY2}$','Interpreter','LaTex','FontSize',20);
    % 
    % hold on
    % %% Right of yyaxis
    % yyaxis right
                            % Sampling period    

    %% Key
    yphsc1=0;
    [f, P1, yphsc1, yphsc1f1,yphsc1f2]=fftphase(t2c1,y2c1,f1);plot(f,P1,'color','r','LineStyle','--');
    % xlim([0 2.5]);
    % if ~exist('ylimfftr','var') || isempty(ylimfftr)
    % else
    %     ylim(ylimfftr);
    % end
    % axr = gca;axr.YColor = 'k';%set color of yaxis 
    % if ~exist('f1','var') || isempty(f1)
    % else
    %     temp=['$f_1/f_n=',num2str(f1),'$'];
    %     hl = legend(['$C_{Y2}$ ',temp],['$Y_2/D$\ \ \ ',temp]);
    %     set(hl,'Interpreter','latex','FontSize',15)
    %     %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
    % end
    % 
    % xlabel('$f$','Interpreter','LaTex','FontSize',20)
    % ylabel('$A_2/D$','Interpreter','LaTex','FontSize',20);

    %%
    if ~exist('pdir','var') || isempty(pdir)
    else
        cd(pdir)
        %printpdf(gcf,[pname,'_',note1,'_FFT_.eps']);

    end




    %====================================================================
    %% C2 force and disp
    %figure(7)

    %% Key
    cphsc2=0;
    [f, P1,cphsc2,cphsc2f1,cphsc2f2]=fftphase(t1c2,y1c2,f1);
    %%
    % plot(f,P1,'color','black') 
    % xlim([0 2.5]);
    % if ~exist('ylimfft','var') || isempty(ylimfftl)
    % else
    %     ylim(ylimfftl);
    % end
    % 
    % if ~exist('ttl','var') || isempty(ttl)
    % else
    %     title(ttl);
    % end
    % 
    % title('C2')
    % xlabel('$f_2/f_n$','Interpreter','LaTex','FontSize',20)
    % ylabel('$C_{AY2}$','Interpreter','LaTex','FontSize',20);
    % 
    % hold on
    % %% Right of yyaxis
    % yyaxis right
                            % Sampling period    

    %% Key
    %figure(7)
    yphsc2=0;
    [f, P1, yphsc2, yphsc2f1,yphsc2f2]=fftphase(t2c2,y2c2,f1);plot(f,P1,'color','r','LineStyle','--');
    % xlim([0 2.5]);
    % if ~exist('ylimfftr','var') || isempty(ylimfftr)
    % else
    %     ylim(ylimfftr);
    % end
    % axr = gca;axr.YColor = 'k';%set color of yaxis 
    % if ~exist('f1','var') || isempty(f1)
    % else
    %     temp=['$f_1/f_n=',num2str(f1),'$'];
    %     hl = legend(['$C_{Y2}$ ',temp],['$Y_2/D$\ \ \ ',temp]);
    %     set(hl,'Interpreter','latex','FontSize',15)
    %     %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
    % end
    % 
    %     
    % xlabel('$f$','Interpreter','LaTex','FontSize',20)
    % ylabel('$A_2/D$','Interpreter','LaTex','FontSize',20);




    %%
    if ~exist('pdir','var') || isempty(pdir)
    else
        cd(pdir)
        %printpdf(gcf,[pname,'_',note1,'_FFT_.eps']);

    end


    %tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
    %mkdir(['plotting/',list0(j).name])
    %cd (['plotting/',list0(j).name])
    %print('-dpng','-r500',['Plotting_',tiname,'.pdf']);
    %cd('C:\Users\Zhonglu\OneDrive - University Of Cambridge\OneDrive\PhDWorks\VIV')

end

