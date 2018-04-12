
clear all
close all

sysdir

list0=dir('g1.0a*m*r*');
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
    for i=1:n % i=1:n
        dirnamef=[list0(j).name,'/',listf1(i).name,'/'];
        %v01=load([dirname,'VIV01.DAT']);
        cd(dirnamef)
        disp(pwd);
        %[y,t]=loadv02yt(0);
        fdir=pwd;
        cd ../; cd ../;
        tempo=['plotting_force/',list0(j).name];
        mkdir(tempo)
        cd (tempo)
        disp(tempo)
        
        ttl=['G=',num2str(G),'  A_1=',num2str(A1),'  m=',num2str(m),'  f1=',listf1(i).name,'  Cylinder 2'];
        pdir=pwd;
        pname=[list0(j).name,'_',listf1(i).name];
        f1=str2double(listf1(i).name);
        
        ylimfft=[0 1];              disp(['ylimfft = ',num2str(ylimfft)])
        plotforce(fdir,[],24000,pdir,[],pname,ylimfft,f1,4,[],A1)

        cd ('../')
        cd ('../')
        close all
    end
    

    
end


%         figure(6)
%         plot(t,y,'color','r') % y displacement of cylinder 2 (free)
%         title(ttl)
%         xlabel('t*fn2');
%         ylabel('Y/D');
%         
%         
%         print('-dpng','-r500',[pname,'_Time_history.png']);
%         
%         %% fft
%         figure(5)
%         T=t(20)-t(19);
%         Fs = 1/T;            % Sampling frequency                                 % Sampling period       
%         L = length(y);             % Length of signal
% 
%         Y = fft(y);
%         %%
%         % Compute the two-sided spectrum |P2|.  Then compute the single-sided
%         % spectrum |P1| based on |P2| and the even-valued signal length |L|.
% 
% %% Key zero taging approximation
% zpf=2;
% Y = fft(y,zpf*L);
% P2 = abs(Y/L);
% P1 = P2(1:ceil(L/2)+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:ceil(L/2))/(zpf*L);
% 
%         plot(f,P1) 
%         xlim([0 4.8]);
%         title(ttl)
%         xlabel('f (Hz)')
%         ylabel('|A2(f)|')
%         print('-dpng','-r500',[pname,'_FFT_.png']);