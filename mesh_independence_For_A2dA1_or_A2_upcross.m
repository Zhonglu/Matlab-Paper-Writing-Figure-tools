clc
clear all
close all
%cd G:\orange_backup % any dir
%cd /Volumes/GROUP_BLACK/orange_backup/mesh_independence_study/%boundary_mesh_size/
cd /Volumes/GROUP_BLACK/orange_backup/mesh_independence_study_mdisk/Nc
list0=dir('v*');
A1din = 3; %input('input: digits after decimal point for A_1 legend? ','s');
if size(A1din)==0;
A1din= '3';
end

A2switch=true; % A2=true or A2dA1=false

if A2switch
    disp('drawing A2 graph')
else
    disp('drawing A2/A1 graph')
end
n1=1;%starting number of files
n0=length(list0);%length(list0);
disp(['starting number= ',num2str(n1)])
s=0;sp=0;

for j=n1:n0
    %cd (list0(j).name)
    %cd ('../')
    
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
%     gam=str2num(str);
%     gamall(:,j)=gam;
%     A1=gam(2);
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
    G=0.2;
    A1=0.1;
    m=2.5;
    f=0.825;
        dirnamef=[list0(j).name,'/'];
        disp(dirnamef);
        
        period=1/f; %
        v02=load([dirnamef,'VIV02.DAT']);
        v02=unique(v02,'rows');%delete repeated rows
        
        t=v02(:,1);
        y=v02(:,4);
        period1n=0;
        leny=length(y);
        zpoint=0;%zpoints are the point before zero point
        s=0;
        
        for ii=1:(leny-1)
            if y(ii)*y(ii+1)<0
                s=s+1;
                zpoint(s)=ii;
            end
        end
        
        lenz=length(zpoint);%
        
        if lenz<3
            continue
        end
        
        s2=0;% No. of period
        for s=1:2:(lenz-2)
            s2=s2+1;
            freq(s2)=1/(t(zpoint(s+2))-t(zpoint(s)));
            yamp(s2)=(max(y(zpoint(s):zpoint(s+2)))-min(y(zpoint(s):zpoint(s+2))))*0.5;
        end
        % now s2 = number of periods
        nperiod=s2;
%             
%         period1n=period1n+1;
% 
%         period1n=2*period1n;% number of periods for A=(max-min)/2
%         tn=length(t);
%         nperiod=floor(tn/(period1n));
%         for i1=1:nperiod %
%             tstartn=(i1-1)*period1n+1;
%             tendn=i1*period1n;
%             ymax(i1)=max(y(tstartn:tendn));
%             ymin(i1)=min(y(tstartn:tendn));
%             yamp(i1)=(ymax(i1)-ymin(i1))/2;
%         end
        str=list0(j).name(2:end);
        str(str=='t')=[];
        strt=str2num(str);
        yamp_his(j,1)=str2num(str);
        yamp_his(j,2:nperiod+1)=yamp(1:nperiod);
        freq_his(j,1)=str2num(str);
        freq_his(j,2:nperiod+1)=freq(1:nperiod);
        
        %yampds=sort(yamp,'descend');
        %yampn=floor(1/3*(length(yampds)));% N of 1/3 values 
        %yampn=floor(1/5*(length(yampds)));
        %average of 1/3 value in the middle of yampds
        
        %s=s+1;
        %figure(s)
        %plot(yampds(yampn:2*yampn))
        %plot(yamp);
        %A2(j)=mean(yampds(yampn:2*yampn));
        
        %A2(j)=yamp(nperiod);
        %A2(j)=yampds(1);
        

        A2(j)=yamp(nperiod);
        %A2(j)=max(yamp);
        %A2(j)=mean(yampds(1:yampn));
        if A2switch==false
            A2dA1(j)=A2(j)/A1;
        end
        %f(j)=str2double(list(i).name);
        %plot(t(zpoint(10):zpoint(40)),y(zpoint(10):zpoint(40)))
        [sm,sn]=size(yamp_his);
        plotstart=37;%from beginning should be 2
        plot(plotstart:nperiod,yamp_his(j,plotstart:nperiod));
        hold on
        legendInfo{j}=num2str(yamp_his(j,1));

        %Yrms(j)=rms(y(zpoint(floor(lenz*3/5)):zpoint(lenz)));
        if length(zpoint)>70
            Yrms(j)=rms(y(zpoint(70):zpoint(lenz)));
            freqmean(j)=mean(freq(floor(1/3*length(freq)):end));
        end
        if false %str2num(list0(j).name(2:end))==36
            figure(2)
            plot(t,y)
            stop
        end
        
        
        clear ymax ymin yamp yampds t v02 y freq ;
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
        

    

    %v02=load([dirnamef,'VIV02.DAT']);
    
   % %tn=length(v02)/5;%Number of lines plotted
    %s=s+1;
    %figure(s)
    %plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
    %hold on; 
    %plot(v02(:,1),v02(:,4),'color','r') % y displacement of cylinder 2 (free)

    %legendInfo{j} = [list0(j).name];%specify digit of legend number
    cd(dirnamef)
        fid = fopen('MESH.TXT','r');
        i = 1;
        tline = fgetl(fid);
        txtv{i} = tline;
        for i=2:2
            tline = fgetl(fid);
            txtv{i} = tline;
        end
        fclose(fid);

        % Change cell 
        temp=str2num(txtv{2});
        mesh_node(j)=temp(1);
        
        fid = fopen('FORCE_PARA.TXT','r');
        i = 1;
        tline = fgetl(fid);
        txtv{i} = tline;
        fclose(fid);

        % Change cell 
        Nc(j)=str2num(txtv{1});
    cd ../
    
    cd(dirnamef)
        fid = fopen('CALCULATION_PARA.TXT','r');
        i = 1;
        tline = fgetl(fid);
        txtv{i} = tline;
        for i=2:2
            tline = fgetl(fid);
            txtv{i} = tline;
        end
        fclose(fid);
        
        % Change cell 
        
        for ia=[32:46,47,58:127]
            txtv{2}(txtv{2}==char(ia))=[' '];
        end    
        temp=str2num(txtv{2});
        flow_time_step(j)=(temp(1)+temp(2)*10^(-length(num2str(temp(2)))))*10^(-temp(3));
        
    cd ../
end


%legend(['G=',num2str(gamall(1,1)),'  A_1=',num2str(gamall(2,1))],'G=3.0  A_1=1.0','G=3.0  A_1=1.5','G=3.0  A_1=2.0','Location','northeast')
%title(['G=',num2str(gam(1)),'      A1=',num2str(gam(2)),'      m*=',num2str(gam(3))])

results(:,1)=yamp_his(:,1);
results(:,2)=mesh_node';
results(:,3)=A2';
results(1:length(Yrms),4)=Yrms;
results(1:length(freqmean),5)=freqmean;
results(:,6)=flow_time_step;
results(:,7)=Nc./2;
 %courant number
legend(legendInfo)
 stop
    sp=sp+1;
    %x_axis=str2num(list0.name);
    if A2switch
        %h(sp)=plot(x_axis,A2);
    else
        %h(sp)=plot(x_axis,A2dA1);
    end
    hold on

%legend(['A_2'])
xlabel('$N_c$','Interpreter','LaTex');
if A2switch
    ylabel('$A_2$','Interpreter','LaTex');
else
    ylabel('A_2/A_1');
end
tiname=['G=',num2str(G)];
set(gca,'XTick',0:0.2:2.5);
grid on
mkdir(['plotting/Amplitude_Frequency/'])
cd ('plotting/Amplitude_Frequency/')

%cd ('../')
%cd ('../')

%set(h,'Color','Black');
%set(h(1:6),{'Marker'},{'o';'+';'*';'x';'s';'d'}); %%
set(h,'Color','Black');
%set(h,{'linestyle'},{'-';'-.'});
%set(h,{'markers'},{ms;ms;ms;ms;ms})
[hleg1, hobj1] = legend;
%set(hleg1,'position',[0.6 0.5 0.2 0.3])
%set(hleg1,'FontSize',15)
%%
if A2switch
    %print('-dpng','-r600',[tiname,'_A2','.png']);
else
    %print('-dpng','-r600',[tiname,'_A2dA1','.png']);
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
%A2=A2'