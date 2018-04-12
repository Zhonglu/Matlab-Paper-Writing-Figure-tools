t=0:0.01:5;

c1=1;
c2=5;

y1=c1*cos(2*pi*t);
y2=c2*sin(2*pi*t);

figure;plot(t,y1,t,y2,t,y1+y2)
figure;plot(t,y1+y2)