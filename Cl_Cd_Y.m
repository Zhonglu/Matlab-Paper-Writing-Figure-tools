clc
clear all
close all
cd G:\orange_backup
list0=dir('g0.20a0.10m2.5*');
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
    for i=1:n
        dirnamef=[list0(j).name,'/',list(i).name,'/'];
        %v01=load([dirname,'VIV01.DAT']);
        v02=load([dirnamef,'VIV02.DAT']);
        f02=load([dirnamef,'F002.DAT']);
        
        ro=1; %!!!??? assume density is 1!!!??? 
        f=str2double(list(i).name);
        Um1=2*3.14159265358979*A*f;
        startstep=100;
        
        disp(dirnamef);
        %tn=length(v02)/5;%Number of lines plotted
        s=s+1;
        figure(s)
        %plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
        %hold on; 
        hold on
        plot(v02(startstep:end,1),v02(startstep:end,4)) % y displacement of cylinder 2 (free)
        hold on
        plot(f02(startstep:end,1),(f02(startstep:end,2)/(ro*Um1^2)) ) % Cd=Fx/(0.5D * ro * Um1^2) of cylinder 2 (free)
        %hold on; plot(f02(startstep:end,1),(f02(startstep:end,3)/(ro*Um1^2)) ) % Cl=Fy/(0.5D * ro * Um1^2) of cylinder 2 (free)
        %legendInfo = {'Y/D','C_d (x)','C_l (y)'};legend(legendInfo);
        
        
        title(['G=',num2str(G),'  A_1=',num2str(A),'  m=',num2str(m),'  f1/fn2=',list(i).name,'  Cylinder 2'])
        xlabel('time*fn2');
        %ylabel('Y/D');
        tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
        mkdir(['plotting/Cl_Cd_Y/',list0(j).name])
        cd (['plotting/Cl_Cd_Y/',list0(j).name])
        print('-dpng','-r500',['Plotting_',tiname,'.png']);
        cd ('../')
        cd ('../')
        cd ('../')
        close all
    end
    

    
end