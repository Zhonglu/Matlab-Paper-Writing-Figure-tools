tspan=[0 4];
y0=[0.02;0];
[t,y]=ode45('unforced1',tspan,y0);
plot(t,y(:,1));
grid on
xlabel('time')
ylabel('Displacement')
title('Displacement Vs Time')
hold on; 


function yp = unforced1(t,y)
yp = [y(2);(-((c/m)*y(2))-((k/m)*y(1)))]; 
end