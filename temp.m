%temp
x0=[-8 8 27]; 
tspan=[0,20];
[t,x]=ode45(@lorenz,tspan,x0);
plot(x(:,1),x(:,3));

a0=[0 0];
tspan=[0,150];
[t,a]=ode45(@ODEs,tspan,a0,[],t1,y1);
plot(a(:,1),a(:,2));
subplot(2,1,1) ;plot(t,a(:,1)) ;subplot(2,1,2) ;plot(t,a(:,2)) ;