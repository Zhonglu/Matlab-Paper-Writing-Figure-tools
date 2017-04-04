clc
clear all
close all
list0=dir('run_g3.0*');
n0=length(list0);
s=0;sp=0;
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
    for i=n:n
        dirnamef=[list0(j).name,'/',list(i).name,'/'];
        %v01=load([dirname,'VIV01.DAT']);
        v02=load([dirnamef,'VIV02.DAT']);
        disp(dirnamef);
        %tn=length(v02)/5;%Number of lines plotted
        %s=s+1;
        %figure(s)
        %plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
        %hold on; 
        t=v02(:,1);
        num=0;
        while true
           num=num+1;
           if t(num)>=14
               break
           end
        end
        sp=sp+1;
        h(sp)=plot(v02(1:num,1),v02(1:num,4)); % y displacement of cylinder 2 (free)
        hold on
        %title(['G=',num2str(G),'  A_1=',num2str(A),'  m=',num2str(m),'  f1/fn2=',list(i).name,'  Cylinder 2'])

    end


    
end
    legend('G=3.0  A_1=0.5  f_1=2.5','G=3.0  A_1=1.0  f_1=2.5','G=3.0  A_1=1.5  f_1=2.5','G=3.0  A_1=2.0  f_1=2.5','Location','northeast')
    xlabel('t * f_n_2');
    ylabel('Y_2 / D');
    axis([0,14,-0.5,0.5]);grid on;
    set(gca,'XTick',0:1:14);
    tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
    plotdir=['plotting/Interim'];
    mkdir(plotdir)
    cd (plotdir)
    %print('-dpng','-r600',['Interim_vibration_centre_with_A1_g3.0_a0.5_to_2.0.png']);

    %set(h,'Color','Black');
%set(h,{'Linestyle'},{'-';'--';'-.';':'});
%set(h,{'markers'},{ms;ms;ms;ms;ms}) set(h,{'Marker'},{'o';'+';'*';'x';'s'});
[hleg1, hobj1] = legend;
%set(hleg1,'position',[0.6 0.5 0.2 0.3])
%set(hleg1,'FontSize',15)
set(hleg1,'FontSize',13)
print('-dpng','-r600',['Interim_vibration_centre_with_A1_g3.0_a0.5_to_2.0.png']);