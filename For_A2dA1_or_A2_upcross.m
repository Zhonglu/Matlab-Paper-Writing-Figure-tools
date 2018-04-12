clc
clear all
close all
%cd G:\orange_backup % any dir
%cd /Volumes/GROUP_BLACK/orange_backup/
cd '/Volumes/GROUP_BLACK/orange_backup/'



list0=dir('g0.2*m2.5*');

%A1din = input('input: digits after decimal point for A_1 legend? (default is 3 digits)','s');
%if size(A1din)==0;
    A1din= '3';
%end

A2switch=false; % A2=true or A2dA1=false

mrswitch=false; %mass ratio is a variable or not

n1=1;%starting number of files
disp(['starting number= ',num2str(n1)])
if A2switch
    disp('drawing A2 graph')
else
    disp('drawing A2/A1 graph')
end

if mrswitch
    disp('dealing with mass ratios')
else
    disp('NOT dealing with mass ratios')
end

n0=length(list0);
s=0;sp=0;
yaxismax=0;xaxismax=0;
yaxismin=0;xaxismin=0;
aryaxismax=0;arxaxismax=0;
aryaxismin=0;arxaxismin=0;
clear gamall aryaxismax aryaxismin arxaxismax arxaxismin
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
    if A1>1
        continue
    end
    
 
%     if not(A1==0.1)
%         continue
%     end
    for i=1:n
        dirnamef=[list0(j).name,'/',list(i).name,'/'];
        disp(dirnamef);
        f(i)=str2double(list(i).name);
        
        
%         if A1==0.1 && f(i)==0.4
%             stop
%         else
%             continue
%         end
        
        
        period=1/str2double(list(i).name); %
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

%         yamp_his(j,1)=str2num(list0(j).name(2:end));
%         yamp_his(j,2:nperiod+1)=yamp(1:nperiod);
%         freq_his(j,1)=str2num(list0(j).name(2:end));
%         freq_his(j,2:nperiod+1)=freq(1:nperiod);
        
        yampds=sort(yamp,'descend');
        yampn=floor(1/3*(length(yampds)));% N of 1/3 values 
        %yampn=floor(1/5*(length(yampds)));
        %average of 1/3 value in the middle of yampds
        
        %s=s+1;
        %figure(s)
        %plot(yampds(yampn:2*yampn))
        %plot(yamp);
        A2(i)=mean(yampds(yampn:2*yampn));
        
        %A2(j)=yamp(nperiod);
        %A2(j)=yampds(1);
        

        %A2(j)=yamp(nperiod);
        
        %A2(j)=mean(yampds(1:yampn));
        if A2switch==false
            A2dA1(i)=A2(i)/A1;
        end
        %f(j)=str2double(list(i).name);
        %plot(t(zpoint(10):zpoint(40)),y(zpoint(10):zpoint(40)))
%        [sm,sn]=size(yamp_his);
%        plotstart=37;%from beginning should be 2
        %plot(plotstart:nperiod,yamp_his(j,plotstart:nperiod));
%        hold on
%        legendInfo{j}=num2str(yamp_his(j,1));

        Yrms(i)=rms(y(zpoint(floor(lenz*2/3)):zpoint(lenz)));

        if false %str2num(list0(j).name(2:end))==36
            figure(2)
            plot(t,y)
            stop
        end
        
        
        clear ymax ymin yamp yampds t v02 y freq ;
        %
     

    end
    %%
    if A2switch==false
        if max(A2dA1)>yaxismax
            [aryaxismax(j),peaki]=max(A2dA1);
            aryaxismin(j)=min(A2dA1((peaki-1):(peaki+1)));
            arxaxismax(j)=f(peaki+1);
            arxaxismin(j)=f(peaki-1)-(f(peaki+1)-f(peaki-1));
        end
    else
        pause
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
    if mrswitch
        %legendInfo{j} = ['G=',num2str(gamall(1,j),4),'  A_1=',num2str(gamall(2,j),['%10.',A1din,'f']),'  m^*=',num2str(gamall(3,j),['%10.',A1din,'f'])];
        legendInfo{j} = ['m^*=',num2str(gamall(3,j),['%10.',A1din,'f'])];
    else
        legendInfo{j} = ['G=',num2str(gamall(1,j),4),'  A_1=',num2str(gamall(2,j),['%10.',A1din,'f'])];%specify digit of legend number
    end

end
mkdir(['plotting/Amplitude_Frequency/'])
cd ('plotting/Amplitude_Frequency/')

yaxismax=max(aryaxismax);
yaxismin=min(aryaxismin);
xaxismax=max(arxaxismax);
xaxismin=min(arxaxismin);

gmin=num2str(min(gamall(1,:)));gmax=num2str(max(gamall(1,:)));
a1min=num2str(min(gamall(2,:)));a1max=num2str(max(gamall(2,:)));
mrmin=num2str(min(gamall(3,:)));mrmax=num2str(max(gamall(3,:)));

%legend(['G=',num2str(gamall(1,1)),'  A_1=',num2str(gamall(2,1))],'G=3.0  A_1=1.0','G=3.0  A_1=1.5','G=3.0  A_1=2.0','Location','northeast')
%title(['G=',num2str(gam(1)),'      A1=',num2str(gam(2)),'      m*=',num2str(gam(3))])
legend(legendInfo)
xlabel('$f_1$','Interpreter','LaTex','FontSize',20);
if A2switch
    ylabel('$A_2$','Interpreter','LaTex','FontSize',20);
else
    ylabel('$A_2/A_1$','Interpreter','LaTex','FontSize',20);
end

set(gca,'XTick',0:0.2:2.5);
grid on


%cd ('../')
%cd ('../')

%set(h,'Color','Black');
markerset={'o';'+';'*';'x';'s';'d';'^'};
set(h(1:j),{'Marker'},markerset(1:j));
set(h,'Color','Black');
%set(h,{'linestyle'},{'-';'-.'});
[hleg1, hobj1] = legend;
set(hleg1,'position',[0.6 0.5 0.2 0.3])
set(hleg1,'FontSize',15)
%% figure1

tiname=['upcross_','G=',gmin,'-',gmax,'_A1=',a1min,'-',a1max,'_mr',mrmin,'-',mrmax];
if A2switch
    print('-dpng','-r600',[tiname,'_A2_overall','.png']);
else
    print('-dpng','-r600',[tiname,'_A2dA1_overall','.png']);
end
%% figure 2


set(hleg1,'position',[0.2 0.5 0.2 0.3])
set(hleg1,'FontSize',15)
set(gca,'XTick',0:0.1:2.5);
%axis(gca, [xmin xmax ymin ymax])
axis(gca, [0.3 1.0 0 (yaxismax+0.1)]);
%print('-dpng','-r600',[tiname,'_A2dA1','.png']);

%tiname=['G=',gmin,'-',gmax,'_A1=',a1min,'-',a1max,'_mr_max=',mrmin,'-',mrmax];
if A2switch
    print('-dpng','-r600',[tiname,'_A2_zoom','.png']);
else
    print('-dpng','-r600',[tiname,'_A2dA1_zoom','.png']);
end
%% figure 3

set(gca,'XTick',0:0.025:2.5);
%zoom on
%axis(gca, [xmin xmax ymin ymax])
xmargin=(xaxismax-xaxismin)/10;
ymargin=(yaxismax-yaxismin)/10;
axis(gca, [xaxismin-xmargin xaxismax+xmargin yaxismin-ymargin yaxismax+ymargin]);

%tiname=['G=',gmin,'-',gmax,'_A1=',a1min,'-',a1max,'_mr_max=',mrmin,'-',mrmax];
if A2switch
    print('-dpng','-r600',[tiname,'_A2_details','.png']);
else
    print('-dpng','-r600',[tiname,'_A2dA1_details','.png']);
end
%%





