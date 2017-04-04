clc
clear all
close all
%cd '/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/VIV/meshes_validation_results'
cd /Volumes/GROUP_BLACK/orange_backup/mesh_independence_study/
%list0=dir('v*');
%n0=length(list0);
s=0;

%for j=1:n0
%    cd (list0(j).name)
    list=dir('v*');
    n= length(list);

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
%     str=list0(j).name;
%     str(str=='r')=[];
%     str(str=='u')=[];
%     str(str=='n')=[];
%     str(str=='_')=[];
%     str(str=='z')=[];
%     str(str=='l')=[' '];
%     str1=str;
%     str(str=='g')=' ';
%     str(str=='a')=' ';
%     str(str=='m')=' ';
%    gam=str2num(str);
    G=0.2;
    A=0.1;
    m=2.5;
    for i=1:n % i=1:n
        dirnamef=[list(i).name,'/'];
        %v01=load([dirname,'VIV01.DAT']);
        v02=load([dirnamef,'VIV02.DAT']);
        v02=unique(v02,'rows');
        disp(dirnamef);
        %tn=length(v02)/5;%Number of lines plotted
        s=s+1;
        figure(s)
        %plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
        %hold on; 
        plot(v02(:,1),v02(:,4)) % y displacement of cylinder 2 (free)
        %hold on

        %cd ('../')
        %cd ('../')
        %close all
        legendInfo{i} = ['v=',list(i).name];%specify digit of legend number

    %end
    %legend(legendInfo)
    title(['G=',num2str(G),'  A_1=',num2str(A),'  m=',num2str(m),'  f1/fn2=','0.825',' v=',list(i).name,'  Cylinder 2'])
    xlabel('t*fn2');
    ylabel('Y/D');
    tiname=[list(i).name,'_VIV02'];
    mkdir(['plotting/'])
    cd (['plotting/'])
    print('-dpng','-r500',['Plotting_',tiname,'.png']);
    cd ../
end