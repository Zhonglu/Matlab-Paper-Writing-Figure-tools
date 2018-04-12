function [t1,y1,t2,y2,info3]=autocut_for_irregular(f1,t1,y1,t2,y2)
global cutlength
if ~exist('cutlength','var') || isempty(cutlength)
    cutlength=5;%10e-5
end

[cut1,info1]=findcut_for_irregular(f1,t1,y1,cutlength);
[cut2,info2]=findcut_for_irregular(f1,t2,y2,cutlength);
if or(info1,info2)==-1
    info3=-1;
    return
end
cutp=min([cut1 cut2]);
if cutp==0;cutp=1;end
%Lmin=min([length(t1),length(t2),length(y1),length(y2)]);
t1=t1(cutp:end);
t2=t2(cutp:end);
y1=y1(cutp:end);
y2=y2(cutp:end);
info3=1;
end

function [cutnt,info]=findcut_for_irregular(f1,t,y,cutlength)
dt=t(20)-t(19);
period1n=ceil(1/f1/dt);%*2;%T1n points in one period, number of periods for A=(max-min)/2
tn=length(t);
%% simply cut off the cutlength periods at t < cutlength, (non-dimensional time),
... when the time history is unstable, and the amplitude flutuates irregularly
    %cutnt=sum(t<cutlength);

cutnt=cutlength*period1n;

if (tn+16*period1n)<=cutnt %least number of periods * period1n
    disp('length(t)<=cutnt, data not long enough')
    info=-1;
    cutnt=0;
    return
end
disp(['autocut_for_irregular, cutoff/total rate= ',num2str(cutnt/tn)])
info=1;
%     % Ast is the amplitude of last 5 periods with steady vibration
%     tstartn=(nperiod-5-1)*period1n+1;tendn=nperiod*period1n;
%     if or(tstartn<1,tendn<1)
%         disp('autocut tstartn < 0, data not long enough')
%         info=-1;
%         cutnt=0;
%         return
%     end
%
%     Ast=(max(y(tstartn:tendn))-min(y(tstartn:tendn)))*0.5;
%     % if the relative error is continuously small for 15 periods,
%     s=0;%count periods that satisfies the condition, 5 statisfaction periods define the steady
%     scheck=5;
%     for i1=1:nperiod %
%         tstartn=(i1-1)*period1n+1;
%         tendn=i1*period1n;
%         yamp(i1)=(max(y(tstartn:tendn))-min(y(tstartn:tendn)))*0.5;
%         err(i1)=abs((yamp(i1)-Ast)/yamp(i1));%relative error
%         if err(i1)<cutlength
%             s=s+1;
%             if s==scheck
%                 break
%             end
%         end
%     end


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

