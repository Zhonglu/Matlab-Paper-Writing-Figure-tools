clc
clear all
close all
cd /Volumes/GROUP_BLACK/orange_backup/ %'C:\'
list0=dir('g0.20a0.100m*r48');
n0=length(list0);
s=0;
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
        v01=load([dirnamef,'VIV01.DAT']);
        v02=load([dirnamef,'VIV02.DAT']);
        f1=str2double(list(i).name);
        timestep=v01(2,1)-v01(1,1);
        NT1=1/f1/timestep;
        Nall=length(v01);

        disp(dirnamef);
        %tn=length(v02)/5;%Number of lines plotted
        s=s+1;
        figure(s)
        plot(v01((Nall-5*NT1):Nall,1),v01((Nall-5*NT1):Nall,4),'color','b') % y displacement of cylinder 1 (forced)
        hold on; 
        plot(v02((Nall-5*NT1):Nall,1),v02((Nall-5*NT1):Nall,4),'color','r') % y displacement of cylinder 2 (free)
        legendInfo{1} = ['Cylinder 1'];
        legendInfo{2} = ['Cylinder 2'];
        legend(legendInfo)
        title(['$','G=',num2str(G),'\ \ A_1=',num2str(A),'\ \ m^*=',num2str(m),'\ \ f_1=',list(i).name,'$'],'Interpreter','latex')
        xlabel('$t f_{n2}$','Interpreter','latex');
        ylabel('$\widetilde{Y}/D$','Interpreter','latex');
        tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
        mkdir(['plotting_frequency_check/',list0(j).name])
        cd (['plotting_frequency_check/',list0(j).name])
        print('-dpng','-r500',['Plotting_',tiname,'.png']);
        cd ('../')
        cd ('../')
        close all
    end
    

    
end