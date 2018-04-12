function approx=linear_approx(t,x,y)
    approx=zeros(length(t),1);
    for i=1:length(t)
        %approx(i)=right(t(i),x,y);
                %approximate the t value to closest x and linearly approximate y
        %to Cyr
        tlown=sum(x<t(i));
        %

    %     ss=1;i=1;
    %     while x(i)<t(i)
    %         ss=ss+1;
    %         i=i+1;
    %     end
    %     tlown=ss;
        %
        if tlown==0
            tlow=0;
        else
            tlow=x(tlown);
        end
        thig=x(tlown+1);
        dt=thig-tlow;
        if tlown==0
            approx(i)=0+(t(i)-tlow)*(y(tlown+1)-0)/dt;
        else
            approx(i)=y(tlown)+(t(i)-tlow)*(y(tlown+1)-y(tlown))/dt;
        end
    end