%% FFT 3D spectra
%% 2D peak line fft
%%
setlatex

%cd G:\orange_backup % any dir
%cd /Volumes/GROUP_BLACK/orange_backup/
clear all
fclose all;
%Gi=[0.05 0.1 0.2 0.3 0.4 0.5 1 1.25 3]; %All the G

%Gi=[0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
% Gi=[1.0];
% mi=[1.5 1.7 2.0 2.2 2.5];
% ri='*';
%
% Gi=0.2
% mi=2.0
%g0.9a0.477m1.7d0.05e110.0r1491/01.800/

% for iG=Gi
%     for im=mi
%         for ri=[
%         1175 1178 1179 1180 1181
%         ]
close all
clearvars -except iG im Gi mi ri
%sys=computer;
sysdir
pwd_dir=pwd;
% gstr=num2str(iG,['%10.1','f']);
% mstr=num2str(im,['%10.1','f']);
% rstr=num2str(ri);
list0_gam=dir(['g*a*m*d*e*r*']);
%list0=dir(['g0.2a0.100m2.0d0.05r*']);
%         if isempty(list0); continue; end
f1pmax=3.6;
%A1din = input('input: digits after decimal point for A_1 legend? (default is 3 digits)','s');
%if size(A1din)==0;
A1din= '3';
%end

maximumA1=inf;

A2switch=false; % A2=true or A2dA1=false

mrswitch=0; %mass ratio is a variable or not

n1=1;%starting number of files
disp(['starting number= ',num2str(n1)])

n0=length(list0_gam);
s=0;sp=0;
countl=0;
clear gamall aryaxismax aryaxismin arxaxismax arxaxismin

for ji=n1:n0
    cd (pwd_dir)
    cd (list0_gam(ji).name)
    list_f=dir('0*'); if isempty(list_f); continue; end
    n=length(list_f);
    str=list0_gam(ji).name;
    gamder=s2gamr(str);
    gamall(1:length(gamder),ji)=gamder;
    A1=gamder(2);
    taskid=gamder(6);
    
    %%
    if or(taskid<9326,taskid>9340); continue; end
%%
    %             if A1>maximumA1
    %                 continue
    %             end
    countl=countl+1;
    A2m=[];f2m=[];f1temp=[]; %initialise A2m and f2m
    clear A2dA1 A2p A2peak f1 f2p f2peak h
    for f1i=1:n
        dirnamef=[list0_gam(ji).name,'/',list_f(f1i).name,'/'];
        disp(dirnamef);
        f1(f1i)=str2double(list_f(f1i).name);
        T1=1/f1(f1i);
        
        %             if A1==0.1 && f(i)==0.4
        %                 stop
        %             else
        %                 continue
        %             end
        
        cd(list_f(f1i).name)
        [t,y]=textscanty;
        cd ../
        %% Remove initial unsteady state
        %[t,y]=autocut(f1(f1i),t,y,t,y); %truncate the initial parts that
        %the amplitude is varying
        
        t=t(4000:end);
        y=y(4000:end);
        %%
        [f2, A2]=fftzp2(t,y);
        %[~,~,A2, f2]=Contfft(t,y,);
        
        f2(f2>f1pmax)=[];
        A2=A2(1:numel(f2));
        A2m(f1i,1:numel(A2))=A2; f2m(f1i,1:numel(f2))=f2;
        
        %if A2switch==false;A2dA1(f1i)=A2p(f1i)/A1;end
        clear ymax ymin yamp yampds t v02 y;
    end
    %% 3D spectra
    
    
    Lf1=length(f1);
    figure(1)
    %waterfall(f1,[],A2m)
    hold on
    for itemp=1:Lf1
        f1temp(1:length(f2m(itemp,:)))=f1(itemp);
        h(itemp)=plot3(f2m(itemp,:),f1temp,A2m(itemp,:),'color','k');
        clear f1temp
    end
    grid on; %grid minor
    
    xlim([0 2.5]);ylim([0 2.5])
    xlabel('$f_2$','Interpreter','LaTex','FontSize',20);
    ylabel('$f_1$','Interpreter','LaTex','FontSize',20);
    zlabel('$A_2$','Interpreter','LaTex','FontSize',20);
    
    campos([12.5839  -11.2161    0.5939])
    [A2peak, IA2peak]=max(A2m,[],2);
    for itemp=1:Lf1
        f2peak(itemp)=f2m(itemp,IA2peak(itemp));
    end
    
    hp3=plot3(f2peak,f1,zeros(1,Lf1),'color','r','LineStyle','--');
    %zlim([0 2.5])
    cd ../
    %
    
    temp=['Y_FFT_spectra_fig/',list0_gam(ji).name];
    mkdir(temp)
    cd (temp)
    temp=[list0_gam(ji).name,'_Y_3DFFT'];
    %printpdf(gcf,['displacement_verification_','f1_',num2str(f1),'.eps']);
    %printpdf(gcf,[temp,'.eps']);
    saveas(gcf,[temp,'.fig'])
    %% 2D f1-f2
    hold off
    close all
    figure(1)
    hp3=plot(f1,f2peak,'color','r');
    grid on; grid minor;
    %set(gca,'XTick',0:0.2:2.5);
    xlabel('$f_1$','Interpreter','LaTex','FontSize',20);
    ylabel('$f_2$','Interpreter','LaTex','FontSize',20);
    setfigure;
    
    printpdf(gcf,[list0_gam(ji).name,'_2Df1_f2peak.eps']);
    close all
    cd ../;cd ../;
    
    %         end
    
end
%     end
% end
