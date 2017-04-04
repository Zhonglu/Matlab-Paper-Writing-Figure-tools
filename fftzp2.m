%function [f, P1]=fftzp2(t,y)
function [f, P1, phs]=fftzp2(t,y)
    zpf=10;
    disp(['zfp=',num2str(zpf)])
    %zpf=2;
    L=length(t);
    dt=t(20)-t(19);
    Fs = 1/dt;
    Y = fft(y,zpf*L);
    %Y = fft(y,L);
    P2 = abs(Y/L);
    P1 = P2(1:ceil(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:ceil(L/2))/(zpf*L);
    %% phase angle Warning: Undertest


% 
% 
%     
%     Yb=fft(y);
%     ly = length(Yb);
%     fb = (0:ly-1)/ly*Fs;
%     
% %     X3=Yb;
% %     threshold = max(abs(Yb))/2; %tolerance threshold
% %     %X3(abs(Yb)<threshold) = 0; %maskout values that are below the threshold
% %     phs = unwrap(angle(X3));
% %     %phs = (angle(X3));
% %     figure(8);plot(fb,phs*180/pi)
% %     %figure;plot(fb,(mod(phs*180/pi,360)))
% %     xlabel 'Frequency (Hz)';xlim([0 2.5])
% %     ylabel 'Phase (degrees)' %ylabel 'degrees' %
% %     grid
% 
%     X1=Yb;%store the FFT results in another array
%     %detect noise (very small numbers (eps)) and ignore them
%     [maxYb, maxin]=max((abs(Yb))/ly);
%     threshold = max((abs(Yb)))/2; %tolerance threshold
%     X1(abs(Yb)<threshold) = 0; %maskout values that are below the threshold
%     phase=atan2(imag(X1),real(X1))*180/pi; %phase information
%     
%     %phase(sum(fb<=0.375))% need to adjust manually
%     %fb(sum(fb<=0.375))   %need to adjust manually
%     
%         figure(9);plot(fb,phase); %phase vs frequencies
%     %disp(['at ',num2str(),])
%     xlabel 'Frequency (Hz)';xlim([0 2.5])
%     ylabel 'Phase (degrees)' %ylabel 'degrees' %
%         figure(10);plot(f,P1);
%     xlabel 'Frequency (Hz)';xlim([0 2.5])
%     ylabel 'A' %ylabel 'degrees' %
%     grid
% 
%     
%     
%     disp(['Amax=',num2str(maxYb)])
%     fmax=fb(maxin);disp(['f for Amax=',num2str(fmax)])
%     phsmax=phase(maxin);disp(['phs for Amax=',num2str(phsmax)])
%     phs=phsmax;
    
    %inverse fft test
%     X1i=ifft(X1);
%     figure;     plot(t,X1i)
%     hold on;    plot(t, y)
    



    % energy conservation check
    Ent=sum(y.^2)*dt;
    df = Fs/L; 
    Enf=sum(abs(Y*dt).^2)*df;
    if Ent-Enf>1e-8; disp('energy not conserved'); pause;end
end