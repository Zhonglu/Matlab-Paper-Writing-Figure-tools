function Cyr=right(t,Cyt,rightn)
    %approximate the t value to closest Cyt and linearly approximate rightn
    %to Cyr
    tlown=sum(Cyt<t);
    %
    
%     ss=1;i=1;
%     while Cyt(i)<t
%         ss=ss+1;
%         i=i+1;
%     end
%     tlown=ss;
    %
    if tlown==0
        tlow=0;
    else
        tlow=Cyt(tlown);
    end
    thig=Cyt(tlown+1);
    dt=thig-tlow;
    if tlown==0
        Cyr=0+(t-tlow)*(rightn(tlown+1)-0)/dt;
    else
        Cyr=rightn(tlown)+(t-tlow)*(rightn(tlown+1)-rightn(tlown))/dt;
    end
    