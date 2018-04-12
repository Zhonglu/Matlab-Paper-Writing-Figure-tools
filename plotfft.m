%clc
function plotfft(fdir,zpf,start,pdir,ttl,pname,ylimfft,f1,nT,ylimth)
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

[t,y]=textscanty;
dt=t(20)-t(19);
L = length(y);
if ~exist('nT','var') || isempty(nT)
    t=t(start:end);
    y=y(start:end);
else
    NnT=ceil(1/f1*nT/dt);%NnT= number of steps for nT periods
    th=t(L-NnT:end);
    yh=y(L-NnT:end);
end

h(1)=plot(th,yh,'color','black'); % v02 displacement of cylinder 2 (free)
xlabel('t*fn2');
xlabel('$tf_n$','Interpreter','LaTex','FontSize',20)
ylabel('$Y$','Interpreter','LaTex','FontSize',20)

if ~exist('ylimth','var') || isempty(ylimth)
else
    ylim(ylimth);
end

if ~exist('f1','var') || isempty(f1)
else
    hl = legend(['$f_1=',num2str(f1),'$']);
    set(hl,'Interpreter','latex','FontSize',20)
    %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
end

if ~exist('ttl','var') || isempty(ttl)
else
    title(ttl);
end


if ~exist('pdir','var') || isempty(pdir)
else
    cd(pdir)
    print('-dpng','-r500',[pname,'_Time_history.png']);
end

figure(6)
%% fft
%dt=t(20)-t(19);
Fs = 1/dt;            % Sampling frequency                                 % Sampling period       
%L = length(y);             % Length of signal
       % Time vector

%% Key
if ~exist('zpf','var') || isempty(zpf)
  zpf=2;
end
Y = fft(y,zpf*L);
P2 = abs(Y/L);
P1 = P2(1:ceil(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:ceil(L/2))/(zpf*L);
%%
plot(f,P1,'color','black') 
xlim([0 2.5]);
if ~exist('ylimfft','var') || isempty(ylimfft)
else
    ylim(ylimfft);
end

if ~exist('ttl','var') || isempty(ttl)
else
    title(ttl);
end

if ~exist('f1','var') || isempty(f1)
else
    hl = legend(['$f_1=',num2str(f1),'$']);
    set(hl,'Interpreter','latex','FontSize',20)
    %title(['$f_1=',num2str(f1),'$'],'Interpreter','LaTex','FontSize',20);
end

    
xlabel('$f_2$','Interpreter','LaTex','FontSize',20)
ylabel('$A_2$','Interpreter','LaTex','FontSize',20);
grid on
grid minor




if ~exist('pdir','var') || isempty(pdir)
else
    cd(pdir)
    print('-dpng','-r500',[pname,'_FFT_.png']);
end


%tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%mkdir(['plotting/',list0(j).name])
%cd (['plotting/',list0(j).name])
%print('-dpng','-r500',['Plotting_',tiname,'.png']);
%cd('C:\Users\Zhonglu\OneDrive - University Of Cambridge\OneDrive\PhDWorks\VIV')

end