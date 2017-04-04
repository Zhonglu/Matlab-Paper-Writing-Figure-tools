
clear all
close all

sysdir

list0=dir('g0.4a*m*r*');
n0=length(list0);
s=0;
for j=1:n0
    cd (list0(j).name)
    listf1=dir('0*');
    n=length(listf1);
    cd ('../')
   
    str=list0(j).name;
    %str(str=='r')=[];
    str(str=='u')=[];
    str(str=='n')=[];
    str(str=='_')=[];
    str(str=='z')=[];
    str(str=='r')=[' '];
    %str1=str;
    str(str=='g')=' ';
    str(str=='a')=' ';
    str(str=='m')=' ';
    gam=str2num(str);
    G=gam(1);
    A=gam(2);
    m=gam(3);
    for i=1:n % i=1:n
        dirnamef=[list0(j).name,'/',listf1(i).name,'/'];
        %v01=load([dirname,'VIV01.DAT']);
        cd(dirnamef)
        disp(pwd);
        %[y,t]=loadv02yt(0);
        fdir=pwd;
        cd ../; cd ../;
        mkdir(['plotting/',list0(j).name])
        cd (['plotting/',list0(j).name])
        ttl=['G=',num2str(G),'  A_1=',num2str(A),'  m=',num2str(m),'  f1=',listf1(i).name,'  Cylinder 2'];
        pdir=pwd;
        pname=[list0(j).name,'_',listf1(i).name];
        f1=str2double(listf1(i).name);
        
        ylimfft=[0 0.0005];              disp(['ylimfft=',num2str(ylimfft)])
        plotfft(fdir,[],24000,pdir,[],pname,ylimfft,f1,4,[])

        cd ('../')
        cd ('../')
        close all
    end
    

    
end

