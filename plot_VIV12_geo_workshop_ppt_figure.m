clc
clear all
close all
fclose all;
cd /Volumes/GROUP_BLACK/orange_backup/
list0=dir('g0.20a0.1m2.5zl_*48/');
n0=length(list0);
s=0;count=0;s2=0;
for j=1:n0
    cd (list0(j).name)
    list=dir('0*');
    n=length(list);
    cd ('../')
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
    G=gam(1);
    A=gam(2);
    m=gam(3);
    
    for i=1:n % i=1:n
        dirnamef=[list0(j).name,'/',list(i).name,'/'];
        %v01=load([dirname,'VIV01.DAT']);
        v02=load([dirnamef,'VIV02.DAT']);
        v02=sortrows(v02);%sort to avoid repeated data
        disp(dirnamef);
        f1=str2double(list(i).name);
        period=1/f1;

        dt=v02(20,1)-v02(19,1);

        if mod(i,4)==1;
            tstart=period*15;%filter the noise t1=floor(period*4/dt)

            t_end=tstart+period*4;
        end
        t1=floor(tstart/dt);
        tn=min(length(v02),floor(t_end/dt));%
        %tn=length(v02);%Number of lines plotted
        %t1=ceil(tn/2);
        s=s+1;s2=s2+1;
        %figure(s)
        plot(v02(t1:tn,1),v02(t1:tn,4)); % y displacement of cylinder 2 (free)
        hold on; 
        legendInfo{s2} = ['f_1/f_n_2=',list(i).name,];
        if mod(s,4)==0
            %axes('position', [0 0 1 1])
            count=count+1;
            %plot(v02(:,1),v02(:,4),'color','r') % y displacement of cylinder 2 (free)
            title(['G=',num2str(G),'  A_1=',num2str(A),'  m=',num2str(m),'  Cylinder 2'])
            xlabel('t*fn2');
            ylabel('Y/D');
            tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
            legend(legendInfo)

            mkdir(['plotting/',list0(j).name])
            cd (['plotting/',list0(j).name])
            print('-dpng','-r500',['Plotting2_',num2str(count),'.png']);
            cd ('../')
            cd ('../')
            clear legendInfo
            close all
            fclose all;
            s2=0;
        end
        
    end
    
end