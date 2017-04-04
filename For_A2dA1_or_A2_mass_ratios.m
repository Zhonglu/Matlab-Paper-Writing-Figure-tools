clc
clear all
close all
%cd G:\orange_backup % any dir
%cd /Volumes/GROUP_BLACK/orange_backup/
cd '/Volumes/GROUP_BLACK/orange_backup/'

list0=dir('g0.20a0.025m*');
%A1din = input('input: digits after decimal point for A_1 legend? (default is 3 digits)','s');
%if size(A1din)==0;
    A1din= '3';
%end

A2switch=true; % A2=true or A2dA1=false
n1=1;%starting number of files
disp(['starting number= ',num2str(n1)])
if A2switch
    disp('drawing A2 graph')
else
    disp('drawing A2/A1 graph')
end
n0=length(list0);
s=0;sp=0;

for j=n1:n0
    cd (list0(j).name)
    list=dir('0*');
    n=length(list);
    cd ('../')
    
    str=list0(j).name;
    str(str=='r')=[];
    str(str=='u')=[];
    str(str=='n')=[];
    str(str=='_')=[];
    str(str=='z')=[];
    str(str=='l')=[' '];
    str1=str;
    str(str=='g')=' ';
    str(str=='a')=' ';
    str(str=='m')=' ';
    gam=str2num(str);
    gamall(:,j)=gam;
    A1=gam(2);
    %CM = lines(10);
    %{
    for i=1:1
        dirnamef=[list0(j).name,'/',list(i).name,'/'];
        %v01=load([dirname,'VIV01.DAT']);
        v01=load([dirnamef,'VIV01.DAT']);
        disp(dirnamef);
        %tn=length(v01)/5;%Number of lines plotted
        s=s+1;
        figure(s)
        %plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
        %hold on; 
        
        plot(v01(:,1),v01(:,4),'color','b') % y displacement of cylinder 2 (free)
        title([list0(j).name,'  f1/fn2=',list(i).name,' VIV01'])
        xlabel('t*fn2');
        ylabel('X/D');
        tiname=[list0(j).name,'_',list(i).name,'_VIV01'];
        cd ('plotting')
        print('-dpng','-r600',['Plotting_',tiname,'.png']);

        cd ('../')
    end
    %}
    for i=1:n
        dirnamef=[list0(j).name,'/',list(i).name,'/'];
        disp(dirnamef);
        
        period=1/str2double(list(i).name); %
        v02=load([dirnamef,'VIV02.DAT']);
        v02=unique(v02,'rows');
        
        t=v02(:,1);
        y=v02(:,4);
        period1n=0;
        while true %count point number in one period
            period1n=period1n+1;
            if t(period1n)>=period
                break
            end
        end
        period1n=period1n*1;% number of periods for A=(max-min)/2
        tn=length(t);
        nperiod=floor(tn/(period1n));
        for i1=1:nperiod %
            tstartn=(i1-1)*period1n+1;
            tendn=i1*period1n;
            ymax(i1)=max(y(tstartn:tendn));
            ymin(i1)=min(y(tstartn:tendn));
            yamp(i1)=(ymax(i1)-ymin(i1))/2;
        end

        yampds=sort(yamp,'descend');
        yampn=floor(1/3*(length(yampds)));% N of 1/3 values 
        %average of 1/3 value in the middle of yampds
        
        %s=s+1;
        %figure(s)
        %plot(yampds(yampn:2*yampn))
        %plot(yamp);
        A2(i)=mean(yampds(yampn:2*yampn));
        if A2switch==false
            A2dA1(i)=A2(i)/A1;
        end
        f(i)=str2double(list(i).name);
        
        clear ymax ymin yamp yampds t v02 y;
        %
        
        %{
        title([list0(j).name,'  f1/fn2=',list(i).name,' VIV02'])
        xlabel('t*fn2');
        ylabel('X/D');
        tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
        cd ('plotting')
        print('-dpng','-r600',['Plotting_',tiname,'.png']);
        cd ('../')
        %}
        %{
        dirnamef=[list0(j).name,'/',list(i).name,'/'];

        %v02=load([dirnamef,'VIV02.DAT']);
        disp(dirnamef);
       % %tn=length(v02)/5;%Number of lines plotted
        %s=s+1;
        %figure(s)
        %plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
        %hold on; 
        %plot(v02(:,1),v02(:,4),'color','r') % y displacement of cylinder 2 (free)
        %
        title([list0(j).name,'  f1/fn2=',list(i).name,' Amplitude with time'])
        xlabel('N');
        ylabel('Amp');
        tiname=[list0(j).name,'_',list(i).name,'_Amplitude with time'];
        mkdir(['plotting/',list0(j).name])
        cd (['plotting/',list0(j).name])
        print('-dpng','-r600',['yampds_1_3_','1_periods',tiname,'.png']);
        cd ('../')
        cd ('../')
        %}
        
    end
    

    %v02=load([dirnamef,'VIV02.DAT']);
    
   % %tn=length(v02)/5;%Number of lines plotted
    %s=s+1;
    %figure(s)
    %plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
    %hold on; 
    %plot(v02(:,1),v02(:,4),'color','r') % y displacement of cylinder 2 (free)
    sp=sp+1;
    if A2switch
        h(sp)=plot(f,A2);
    else
        h(sp)=plot(f,A2dA1);
    end
    hold on
    legendInfo{j} = ['  m^*=',num2str(gamall(3,j),['%10.',A1din,'f'])];%specify digit of legend number

    
end

%legend(['G=',num2str(gamall(1,1)),'  A_1=',num2str(gamall(2,1))],'G=3.0  A_1=1.0','G=3.0  A_1=1.5','G=3.0  A_1=2.0','Location','northeast')
%title(['G=',num2str(gam(1)),'      A1=',num2str(gam(2)),'      m*=',num2str(gam(3))])
legend(legendInfo)
xlabel('$f_1$','Interpreter','LaTex','FontSize',20);
if A2switch
    ylabel('$A_2$','Interpreter','LaTex','FontSize',20);
else
    ylabel('$A_2/A_1$','Interpreter','LaTex','FontSize',20);
end
tiname=['G=',num2str(gam(1))];
set(gca,'XTick',0:0.2:2.5);
grid on
mkdir(['plotting/Amplitude_Frequency/'])
cd ('plotting/Amplitude_Frequency/')

%cd ('../')
%cd ('../')

%set(h,'Color','Black');
set(h(1:6),{'Marker'},{'o';'+';'*';'x';'s';'d'});
%set(h(1:5),{'Marker'},{'o';'+';'*';'x';'s'});
%set(h(1:4),{'Marker'},{'o';'+';'*';'x'});
%set(h(1:7),{'Marker'},{'o';'+';'*';'x';'s';'d';'^'});
%set(h(1:2),{'Marker'},{'o';'+'});
set(h,'Color','Black');
%set(h,{'linestyle'},{'-';'-.'});
%set(h,{'markers'},{ms;ms;ms;ms;ms})
[hleg1, hobj1] = legend;
set(hleg1,'position',[0.6 0.5 0.2 0.3])
set(hleg1,'FontSize',15)
%%
if A2switch
    print('-dpng','-r600',[tiname,'_A2_overall','.png']);
else
    print('-dpng','-r600',[tiname,'_A2dA1_overall','.png']);
end

%{
set(hleg1,'position',[0.2 0.5 0.2 0.3])
set(hleg1,'FontSize',15)
set(gca,'XTick',0:0.1:2.5);
print('-dpng','-r600',[tiname,'_A2dA1','.png']);

^^hand adjust!
set(gca,'XTick',0:0.025:2.5);
print('-dpng','-r600',[tiname,'_A2dA1_details','.png']);
%}