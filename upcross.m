function [f, P1, phsmax,phsmaxf1,phsmaxf2]=upcross(t,y,f1)
f=0;P1=0;

index=0;s=0;

for i=1:length(t)-1
    if y(i)*y(i+1)<=0 && y(i)<=0
        s=s+1;
        index(s)=i; % get index of upcrossing zero points
    end
end
