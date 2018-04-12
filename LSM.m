function [Cd,Cm]=LSM(Fm,um,rho,D)
%% minimisation of least squares method for the Morison equation calculation
%remember to regularise Fm and um time steps beforehand
%c_out(1)=Cd, c_out(2)=Cm

dt=um(2)-um(1);
%r=(Fm(1:end-1)-(pi/4*rho*C(2)*D^2*diff(um)/dt+1/2*rho*C(1)*D*um(1:end-1)*abs(um(1:end-1))))^2;

fun=@(C)(Fm(1:end-1,2)-(pi/4*rho*C(2)*D^2*diff(um(:,2))/dt+1/2*rho*C(1)*D*um(1:end-1,2)*abs(um(1:end-1,2))))^2;

x0=[1, 2];
c_out=fminsearch(fun,x0);
Cd=c_out(1);Cm=c_out(2);