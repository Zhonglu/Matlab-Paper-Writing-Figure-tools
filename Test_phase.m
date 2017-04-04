%Test phase extraction


A = 0.5; %amplitude of the cosine wave
fc=10;%frequency of the cosine wave
phase=30; %desired phase shift of the cosine in degrees
t=0:1/fs:2-1/fs;%2 seconds duration
 
fs=32*fc;%sampling frequency with oversampling factor 32
 
phi = phase*pi/180; %convert phase shift in degrees in radians
x=A*cos(2*pi*fc*t+phi);%time domain signal with phase shift
 
figure; plot(t,x); %plot the signal