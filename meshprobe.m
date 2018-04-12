clc
clear all
close all
cd ./GMesh0.5test
mesh=load('meshnodes.txt');
boundary=load('meshboundary.txt');
%bnlines=boundary(161:436,4);
bnlines=boundary(161:438,4);
pmesh=mesh(bnlines,:);
plot(pmesh(:,1),pmesh(:,2));
cd ../