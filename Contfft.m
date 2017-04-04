%clc
function [A2, f2peak, P1, f2] = Contfft(t,y,f1,zpf)
%% output: P1 amplitudes series, f corresponding frequency series

%% fft
 T=t(20)-t(19);
 Fs = 1/T;            % Sampling frequency                                 % Sampling period       
 L = length(y);             % Length of signal
%        % Time vector
% %% 
% % Form a signal containing a 50 Hz sinusoid of amplitude 0.7 and a 120 Hz 
% % sinusoid of amplitude 1.
% 
% %% 
% % Corrupt the signal with zero-mean white noise with a variance of 4.
% 
% %% 
% % Compute the Fourier transform of the signal. 
% 
% Y = fft(y);
% %%
% % Compute the two-sided spectrum |P2|.  Then compute the single-sided
% % spectrum |P1| based on |P2| and the even-valued signal length |L|.
% 
% P2 = abs(Y/L);
% P1 = P2(ceil(1:L/2+1));
% P1(2:end-1) = 2*P1(2:end-1);
% 
% %% Key zero taging approximation
% if ~exist('zpf','var') || isempty(zpf)
%   zpf=2;
% end
% Y = fft(y,zpf*L);
% P2 = abs(Y/L);
% P1 = P2(1:ceil(L/2)+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f2 = Fs*(0:ceil(L/2))/(zpf*L);

[f2, P1]=fftzp2(t,y);

%% 
% Define the frequency domain |f| and plot the single-sided amplitude
% spectrum |P1|.  The amplitudes are not exactly at 0.7 and 1, as expected, because of the added 
% noise. On average, longer signals produce better frequency approximations.

%f = Fs*(0:(L/2))/L;

%inx1=ceil(f1/Fs*L*zpf);%index of f2=f1
[A2,temp]=max(P1);

f2peak=(temp)*Fs/L;

%tiname=[list0(j).name,'_',list(i).name,'_VIV02'];
%mkdir(['plotting/',list0(j).name])
%cd (['plotting/',list0(j).name])
%print('-dpng','-r500',['Plotting_',tiname,'.png']);
%cd('C:\Users\Zhonglu\OneDrive - University Of Cambridge\OneDrive\PhDWorks\VIV')

end