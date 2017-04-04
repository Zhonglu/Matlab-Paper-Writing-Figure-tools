%clc
function plot_CY_and_Y(fdir,zpf,start,pdir,ttl_p,pname,ylimfftl,f1,nT,ylimthl,A1,ylimfftr,ylimthr)
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

if ~exist('start','var') || isempty(start)
  start=1;
end

[t1,y1]=textscan_ft(A1,f1);% 1 denotes force coefficient
dt1=t1(20)-t1(19);           
[t2,y2]=textscanty;         % 2 denotes displacement
dt2=t2(20)-t2(19);  
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
end

%% left for coefficient
h(1)=plot(th1,yh1,'color','black'); % v02 coefficient of cylinder 2 (free)
%xlabel('t*fn2');
xlabel('$tf_{n}$','Interpreter','LaTex','FontSize',20)
ylabel('$C_{Y2}$','Interpreter','LaTex','FontSize',20)

%% right for displacement
hold on
yyaxis right
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
if ~exist('pdir','var') || isempty(pdir); else; cd(pdir); printpdf(gcf,[pname,'_',note1,'_Time_history.pdf']);end



figure(6)
         
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
% if ~exist('ttl','var') || isempty(ttl)
% else
%     %title(ttl);
% end

% if ~exist('f1','var') || isempty(f1)
% else
%     hl = legend(['$f_1=',num2str(f1),'$']);
%     set(hl,'Interpreter','latex','FontSize',20)
%     %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
% end

    
xlabel('$f$','Interpreter','LaTex','FontSize',20)
ylabel('$A_2$','Interpreter','LaTex','FontSize',20);




%%
if ~exist('pdir','var') || isempty(pdir)
else
    cd(pdir)
    printpdf(gcf,[pname,'_',note1,'_FFT_.pdf']);
end


%tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%mkdir(['plotting/',list0(j).name])
%cd (['plotting/',list0(j).name])
%print('-dpng','-r500',['Plotting_',tiname,'.pdf']);
%cd('C:\Users\Zhonglu\OneDrive - University Of Cambridge\OneDrive\PhDWorks\VIV')

end