%clc
function [amp f] = fftampfreq(fdir)


%cd 'C:\Users\Zhonglu Lin\OneDrive\PhDWorks\VIV\temp' %for windows
% if exist(fdir,'var')
%     cd('./')
% else
%     cd(fdir) %for mac
% end
%v01=load([dirname,'VIV01.DAT']);
%tn=length(v02)/5;%Number of lines plotted

%plot(v01(1:tn,1),v01(1:tn,4),'color','b') % v02 displacement of cylinder 1 (forced)
%hold on; 


figure(6)
%% fft
T=v02(20,1)-v02(19,1);
Fs = 1/T;            % Sampling frequency                                 % Sampling period       
L = length(y);             % Length of signal
       % Time vector
%% 
% Form a signal containing a 50 Hz sinusoid of amplitude 0.7 and a 120 Hz 
% sinusoid of amplitude 1.

%% 
% Corrupt the signal with zero-mean white noise with a variance of 4.

%% 
% Compute the Fourier transform of the signal. 

Y = fft(y);
%%
% Compute the two-sided spectrum |P2|.  Then compute the single-sided
% spectrum |P1| based on |P2| and the even-valued signal length |L|.

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
%% 
% Define the frequency domain |f| and plot the single-sided amplitude
% spectrum |P1|.  The amplitudes are not exactly at 0.7 and 1, as expected, because of the added 
% noise. On average, longer signals produce better frequency approximations.

f = Fs*(0:(L/2))/L;
plot(f,P1) 
xlim([0 3.6]);
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%mkdir(['plotting/',list0(j).name])
%cd (['plotting/',list0(j).name])
%print('-dpng','-r500',['Plotting_',tiname,'.png']);
cd('C:\Users\Zhonglu\OneDrive - University Of Cambridge\OneDrive\PhDWorks\VIV')

end