clc
clear all
close all
list0=dir('run_g3.0a2.0m2.*');
n0=length(list0);
s=0;
for j=1:n0
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
    for i=16:16
        dirnamef=[list0(j).name,'/',list(i).name,'/'];
        disp(dirnamef);
        
        period=1/str2double(list(i).name); %
        v02=load([dirnamef,'VIV02.DAT']);
        
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
        
        
        plot(t,y)
        print('-dpng','-r600',[list0(j).name,'time_history','.png']);
        plot(yamp)
        print('-dpng','-r600',[list0(j).name,'yamp','.png']);
        plot(yampds)
        print('-dpng','-r600',[list0(j).name,'yampds','.png']);
        
        
        %s=s+1;
        %figure(s)
        %plot(yampds(yampn:2*yampn))
        %plot(yamp);
        A2(i)=mean(yampds(yampn:2*yampn));
        A2dA1(i)=A2(i)/A1;
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
    plot(f,A2dA1)
    title(['G=',num2str(gam(1)),'      A1=',num2str(gam(2)),'      m*=',num2str(gam(3))])
    xlabel('f1');
    ylabel('A2/A1');
    set(gca,'XTick',0:0.2:2.5);
    grid on
    mkdir(['plotting/Amplitude_Frequency/'])
    cd ('plotting/Amplitude_Frequency/')
    print('-dpng','-r600',[list0(j).name,'A2_f1_1_3_','1_periods','.png']);
    cd ('../')
    cd ('../')

    
end