%geo work shop contour lines for G=3 vibration centre shift

clear all
close all
fclose all;

%A2switch=false; % A2=true or A2dA1=false

%cd G:\orange_backup % any dir for windows
cd /Volumes/GROUP_BLACK/orange_backup/ % Mac
list0=dir('g3.0a*');
n_list=length(list0);
for j=1:n_list
    cd (list0(j).name)
    list=dir('0*');
    n_f_list=length(list);
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
    A1(j)=gam(2);
    m=gam(3);
    
    for i=1:n_f_list  % i=1:n
        dirnamef=[list0(j).name,'/',list(i).name,'/'];
        %v01=load([dirname,'VIV01.DAT']);
        v02=load([dirnamef,'VIV02.DAT']);
        %v02=sortrows(v02);%sort to avoid repeated data
        v02=unique(v02,'rows');
        disp(dirnamef);
        f1(i)=str2double(list(i).name);
        period=1/f1(i);
        dt=v02(20,1)-v02(19,1);
        %% get delta Y max
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
        ydisp(nperiod)=0;
        for i1=1:nperiod %
            tstartn=(i1-1)*period1n+1; %start of period No.
            tendn=i1*period1n;          % end of period No.
            %ymax(i1)=max(y(tstartn:tendn));
            %ymin(i1)=min(y(tstartn:tendn));
            %yamp(i1)=(ymax(i1)-ymin(i1))/2;
            ydisp(i1)=(  max( y(tstartn:tendn))+min(y(tstartn:tendn) )  )/2;
        end
        ydisp=abs(ydisp);
        yampds=sort(ydisp,'descend');
        yampn=floor(1/5*(length(yampds)));% 
        
        %s=s+1;
        %figure(s)
        %plot(yampds(yampn:2*yampn))
        %plot(yamp);
        deltaY2(j,i)=mean(yampds(3*yampn:4*yampn));
        %if A2switch==false
        %    deltaY2dA1(i)=deltaY2(i)/A1(i);
        %end
        
        clear ydisp yampds t v02 y;
        
    end
    
end

X=f1;
Y=A1;
Z=deltaY2;
contour(X,Y,Z,'ShowText','on')

%axes('position', [0 0 1 1])
count=count+1;
%plot(v02(:,1),v02(:,4),'color','r') % y displacement of cylinder 2 (free)
title(['G=',num2str(G),'  A_1=',num2str(A1),'  m=',num2str(m),'  Cylinder 2'])
xlabel('t*fn2');
ylabel('Y/D');
tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%legend(legendInfo)

mkdir(['plotting/',list0(j).name])
cd (['plotting/',list0(j).name])
print('-dpng','-r500',['Plotting2_',num2str(count),'.png']);
cd ('../')
cd ('../')
clear legendInfo
close all
fclose all;
s2=0;