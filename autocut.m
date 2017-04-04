function [t1,y1,t2,y2]=autocut(f1,t1,y1,t2,y2)
    errlim=10e-5;
    cut1=findcut(f1,t1,y1,errlim);
    cut2=findcut(f1,t2,y2,errlim);
    cutp=min([cut1 cut2]);
    if cutp==0;cutp=1;end
    %Lmin=min([length(t1),length(t2),length(y1),length(y2)]);
    t1=t1(cutp:end);
    t2=t2(cutp:end);
    y1=y1(cutp:end);
    y2=y2(cutp:end);
end

function cutnt=findcut(f1,t,y,errlim)
    dt=t(20)-t(19);
    period1n=ceil(1/f1/dt)*2;%T1n points in one period, number of periods for A=(max-min)/2
    tn=length(t);
    nperiod=floor(tn/(period1n));
    %% Ast is the amplitude of last 5 periods with steady vibration
    tstartn=(nperiod-5-1)*period1n+1;tendn=nperiod*period1n;
    Ast=(max(y(tstartn:tendn))-min(y(tstartn:tendn)))*0.5;
    %% if the relative error is continuously small for 15 periods,
    s=0;%count periods that satisfies the condition, 5 statisfaction periods define the steady
    scheck=5;
    for i1=1:nperiod %
        tstartn=(i1-1)*period1n+1;
        tendn=i1*period1n;
        yamp(i1)=(max(y(tstartn:tendn))-min(y(tstartn:tendn)))*0.5;
        err(i1)=abs((yamp(i1)-Ast)/yamp(i1));%relative error
        if err(i1)<errlim
            s=s+1;
            if s==scheck
                break
            end
        end
    end

    cutnt=tendn-period1n*scheck;
end

%             dt=t1(20)-t1(19);
%             T1n=ceil(1/f1/dt);%T1n points in one period, number of periods for A=(max-min)/2
%             tn=length(t1);
%             nperiod=floor(tn/(T1n));
%             for i1=1:nperiod %
%                 tstartn=(i1-1)*T1n+1;
%                 tendn=i1*T1n;
%                 yamp(i1)=(max(y1(tstartn:tendn))-min(y1(tstartn:tendn)))*0.5;
%                 if i1>1; err1=(yamp(i1)-yamp(i1-1))/yamp(i1);end
%                 if i1>1 && err1<0.01;break;end
%             end
%             cutnt=tendn;
            
            