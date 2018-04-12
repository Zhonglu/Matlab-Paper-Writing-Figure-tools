clc
clear all
close all
list0=dir('g3.0a2.0m2.*');
n0=length(list0);
s=0;
for j=1:n0
    cd (list0(j).name)
    list=dir('0*');
    n=length(list);
    cd ('../')
    %CM = lines(10);
    %%{
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
        
        plot(v01(:,1),v01(:,5),'color','b') % y displacement of cylinder 2 (free)
        title([list0(j).name,'  f1/fn2=',list(i).name,' VIV01'])
        xlabel('t*fn2');
        ylabel('V/(Dfn2)');
        tiname=[list0(j).name,'_',list(i).name,'_VIV01_Velocity'];
        cd ('plotting')
        print('-dpng','-r600',['P_Velocity',tiname,'.png']);

        cd ('../')
    end
    %}
    for i=1:50
        dirnamef=[list0(j).name,'/',list(i).name,'/'];
        %v01=load([dirname,'VIV01.DAT']);
        v02=load([dirnamef,'VIV02.DAT']);
        disp(dirnamef);
        %tn=length(v02)/5;%Number of lines plotted
        s=s+1;
        figure(s)
        %plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
        %hold on; 
        plot(v02(:,1),v02(:,5),'color','r') % y displacement of cylinder 2 (free)
        title([list0(j).name,'  f1/fn2=',list(i).name,' VIV02'])
        xlabel('t*fn2');
        ylabel('V/(Dfn2)');
        tiname=[list0(j).name,'_',list(i).name,'_VIV02_Velocity'];
        cd ('plotting')
        print('-dpng','-r600',['P_Velocity',tiname,'.png']);
        cd ('../')
    end
    

    
end