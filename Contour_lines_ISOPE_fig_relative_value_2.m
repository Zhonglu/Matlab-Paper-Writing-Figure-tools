%geo work shop contour lines for G=3 vibration centre shift

clear all
%close all
fclose all;

%A2switch=false; % A2=true or A2dA1=false

%cd G:\orange_backup % any dir for windows
sys=computer;
if sys(1:6)=='MACI64'
    cd '/Volumes/GROUP_BLACK/orange_backup/'
    disp('/Volumes/GROUP_BLACK/orange_backup/')
else
    cd F:\orange_backup
    disp('F:\orange_backup')
end
list0=dir('g3.00a*m2.5');
n_list=length(list0);
for j=5:n_list
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
    cd(list0(j).name)
    for i=1:n_f_list  % i=1:n
        dirnamef=list(i).name;
        %v01=load([dirname,'VIV01.DAT']);
        cd(dirnamef);
        [t,y]=textscanty;
        cd ../
        %v02=sortrows(v02);%sort to avoid repeated data

        %for ii=1:length(v02) 
        %end
        disp(dirnamef);
        f1(i)=str2double(list(i).name);
        period=1/f1(i);
        dt=t(20)-t(19);
        %% get delta Y max
        %begin_n=2*floor(period/dt);

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
        %if nperiod>25;nperiod=25;end
        for i1=1:nperiod %
            tstartn=(i1-1)*period1n+1; %start of period No.
            tendn=i1*period1n;          % end of period No.
            ymax(i1)=max(y(tstartn:tendn));
            ymin(i1)=min(y(tstartn:tendn));
            yamp(i1)=(ymax(i1)-ymin(i1))/2;
            ydisp(i1)=(ymax(i1)+ymin(i1))/2;
        end

        ydisp=abs(ydisp);
        %ydispds=sort(ydisp,'descend');
        %ydispn=floor(1/8*(length(ydispds)));% 
        deltaY2(j,i)=max(ydisp);
        %deltaY2(j,i)=max(ydispds(6*ydispn:7*ydispn));
        
        yampds=sort(yamp,'descend');
        yampn=floor(1/3*(length(yampds)));% N of 1/3 values 
        %A2(j,i)=mode(yamp);
        A2(j,i)=mean(yampds(yampn:2*yampn));
        %A2(j,i)=max(yamp(nperiod-3:nperiod));
        Z(j,i)=deltaY2(j,i)/A2(j,i);
        disp(['deltaY2=',num2str(deltaY2(j,i))])
        disp(['A2=',num2str(A2(j,i))])
        disp(['Z= ',num2str(Z(j,i))])
        figure(1)
        plot(t,y)
        figure(3)
        plot(yampds)
        figure(4);
        [ff, p1]=fftzp2(t,y);
        plot(ff,p1);xlim([0 2.5])
        %if A2switch==false
        %    deltaY2dA1(i)=deltaY2(i)/A1(i);
        %end
        %{
        close all
        figure
        plot(yamp,'--')
        hold on
        plot(ydisp,'-')
        %}
        clear ydisp ydispds ydispn yamp yampds yampn t v02 y;
        %clear all -except i j A2 Z deltaY2 f1 list0 list
    end
    cd ../
end
figure(2)
X=f1;
Y=A1;
%Z=deltaY2/A2;

 contour(X,Y,Z,[0.1 0.3 0.5 1 2 3 4 5 6 7 8 10 12 14],'ShowText','on','LineColor','black')

[X0,Y0] = meshgrid(X,Y);
%pcolor(X0,Y0,Z)
%shading interp
axis equal
axis tight
%colorbar

hold on

%level=[1, 1];
%contour(X,Y,Z,level,'ShowText','on','LineColor','red')

%axes('position', [0 0 1 1])
%plot(v02(:,1),v02(:,4),'color','r') % y displacement of cylinder 2 (free)
%tiname2=['Contour of \DeltaY_m_a_x / A_2  ',' G=',num2str(G)];
title('$\Delta\bar{Y}_{max}/{A}_{2}$   when G=3','Interpreter','latex')
ylabel('$A_1$','Interpreter','latex');
xlabel('$f_1$','Interpreter','latex');
tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%legend(legendInfo)

mkdir(['plotting/'])
cd (['plotting/'])
print('-dpng','-r500',['Contour_deltaY_divided_by_A2_','G_is_',num2str(G),'.png']);
clear legendInfo
fclose all;
