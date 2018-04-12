function [t,CL]=textscan_ft(A1,f1,fnum)
% if fnum=[], open F002.DAT, in current directory, and returns CL as total
% force
% if fum=1, open F001.DAT instead
% if fnum==25, it return CL as pressure force coefficient on y direction
% if fnum==27, it return CL as shear    force coefficient on y direction
%get force data
%file=fopen('F002.DAT');
if ~exist('fnum','var') || isempty(fnum) || fnum==25 || fnum==27
    file=fopen('F002.DAT');
elseif fnum==1
    file=fopen('F001.DAT');
end

if file==-1
    CL=0;t=0;disp('file open fail');
    return;
else
    temp=textscan(file,'%f %f %f %f %f %f %f');n=7;
    fclose(file);
    
    L=zeros(1,n);
    for i=1:n
        L(i)=numel(temp{1,i});
    end
    Lmin=min(L);
    
    f002m=zeros(Lmin,n);
    for i=1:n
        f002m(1:Lmin,i)=temp{1,i}(1:Lmin);
    end
    f002m=f002m(~any(isnan(f002m),2),:);
    f002m=unique(f002m,'rows');
    t=f002m(:,1);% time
    %Fy02=;% C2, Fy/(D/2), Fy is total force in y direction
    CL=f002m(:,3)/( (2*pi*A1*f1)^2 );
    
    if ~exist('fnum','var') || isempty(fnum)
    elseif fnum==25
        Fy02_5=f002m(:,5); %  pressure force in y direction
        CL=Fy02_5/( (2*pi*A1*f1)^2 );
    elseif fnum==27
        Fy02_7=f002m(:,7); %  shear force in y direction
        CL=Fy02_7/( (2*pi*A1*f1)^2 );
    end
    
end


%% result check and discard initialising noise and remove repeated time steps
store=[];
for i=1:length(f002m)-1
    if f002m(i,1)>=f002m(i+1,1)
        %store=[store;f002m(i,:);f002m(i+1,:)];
        store=[store;i;i+1];
    end
end
temps=f002m;temps(store,:)=[];

%figure;plot(store(:,1),store(:,3))
%figure;plot(temps(:,1),temps(:,3));ylim([-0.06 0.06])
%% interpolation to obtain regular time steps
%x = 0:pi/4:2*pi;   t
%v = sin(x);        CL
[t,ia] = unique(t);CL=CL(ia);%make every time step unique
dt=t(20)-t(19);
xq = t(1):dt:t(end);
CL = interp1(t,CL,xq,'spline');
t=xq;

%     figure
%     plot(x,v,'o',xq,CL,':.');
%     %xlim([0 2*pi]);
%     title('Spline Interpolation');
end