function [t,y,v]=textscanty(fnum)
if ~exist('fnum','var') || isempty(fnum)
    file=fopen('VIV02.DAT');
else
    file=fopen('VIV01.DAT');
end
    
    if file==-1
        y=0;t=0;disp('file open fail');return
    else
        viv02=textscan(file,'%f %f %f %f %f');n=5;
        fclose(file);

        %get minimum length of 5 columns
        for i=1:n
            L(i)=numel(viv02{1,i});
        end
        Lmin=min(L);

        %viv02m=[0,0];
        viv02m=zeros(Lmin,n);
        for i=1:n
            viv02m(1:Lmin,i)=viv02{1,i}(1:Lmin);
        end
        viv02m=viv02m(~any(isnan(viv02m),2),:);%remove rows with NaN values
        viv02m=unique(viv02m,'rows');



        t=viv02m(:,1);% time
        y=viv02m(:,4);% displacement
        v=viv02m(:,5);% velocity
    end
    %% interpolation to obtain regular time steps
    [t,ia] = unique(t);y=y(ia);%make every time step unique
    dt=t(20)-t(19);
    xq = t(1):dt:t(end);
    y = interp1(t,y,xq,'spline');
    t=xq;
    
    
end