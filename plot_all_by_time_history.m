clc
clear all
close all

sysdir

list0=dir('*r*');
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
    G=gam(1);
    A=gam(2);
    m=gam(3);
    for i=1:n % i=1:n
        dirnamef=[list0(j).name,'/',list(i).name,'/'];
        %v01=load([dirname,'VIV01.DAT']);
        v02=load([dirnamef,'VIV02.DAT']);
        v02=unique(v02,'rows');
        disp(dirnamef);
        %tn=length(v02)/5;%Number of lines plotted
        s=s+1;
        figure(s)
        %plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
        %hold on; 
        plot(v02(:,1),v02(:,4),'color','r') % y displacement of cylinder 2 (free)
        title(['G=',num2str(G),'  A_1=',num2str(A),'  m=',num2str(m),'  f1/fn2=',list(i).name,'  Cylinder 2'])
        xlabel('t*fn2');
        ylabel('Y/D');
        tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
        mkdir(['plotting/',list0(j).name])
        cd (['plotting/',list0(j).name])
        print('-dpng','-r500',['Plotting_',tiname,'.png']);
        cd ('../')
        cd ('../')
        close all
    end
    

    
end