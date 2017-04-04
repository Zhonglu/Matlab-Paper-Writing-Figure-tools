%function [f, P1]=fftzp2(t,y)
function [f, P1, phsmax,phsmaxf1,phsmaxf2]=fftphase(t,y,f1)
    zpf=1;% 1 is OK for phase identifying
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
    Yb=fft(y);
    ly = length(Yb);
    fb = (0:ly-1)/ly*Fs;
    
%     X3=Yb;
%     threshold = max(abs(Yb))/2; %tolerance threshold
%     %X3(abs(Yb)<threshold) = 0; %maskout values that are below the threshold
%     phs = unwrap(angle(X3));
%     %phs = (angle(X3));
%     figure(8);plot(fb,phs*180/pi)
%     %figure;plot(fb,(mod(phs*180/pi,360)))
%     xlabel 'Frequency (Hz)';xlim([0 2.5])
%     ylabel 'Phase (degrees)' %ylabel 'degrees' %
%     grid

    X1=Yb;%store the FFT results in another array
    %detect noise (very small numbers (eps)) and ignore them
    [maxYb, maxin]=max((abs(Yb))/ly);
    temp1=sum(fb<0.98*f1);
    [~, maxinf1]=max((abs(Yb(temp1:sum(fb<1.02*f1))))/ly);
    maxinf1=maxinf1+temp1-1;% excluding frequency larger than f1, so that dominant frequency at f=f1 is obtained
    [~, maxinf2]=max((abs(Yb(sum(fb<1.7*f1):sum(fb<2.3*f1))))/ly);maxinf2=maxinf2+sum(fb<1.7*f1)-1;% aim to get dominant frequency at f=2f1 is obtained
    
    %threshold = max((abs(Yb)))/2; %tolerance threshold
    %X1(abs(Yb)<threshold) = 0; %maskout values that are below the threshold
    phase=atan2(imag(X1),real(X1))*180/pi; %phase information
    
    %phase(sum(fb<=0.375))% need to adjust manually
    %fb(sum(fb<=0.375))   %need to adjust manually
    
    if false
        figure(9);plot(fb,phase); %phase vs frequencies
        %disp(['at ',num2str(),])
        xlabel 'Frequency (Hz)';xlim([0 2.5])
        ylabel 'Phase (degrees)' %ylabel 'degrees' %
        figure(10);plot(f,P1);
        xlabel 'Frequency (Hz)';xlim([0 2.5])
        ylabel 'A' %ylabel 'degrees' %
        grid

    end
    
    disp(['Amax=',num2str(maxYb)])
    fmax=fb(maxin);disp(['f for Amax=',num2str(fmax)])
    phsmax=phase(maxin);disp(['phs for Amax=',num2str(phsmax)])
    
    if 1
        %disp(['Af1=',num2str()])
        fmaxf1=fb(maxinf1);disp(['f for Af1=',num2str(fmaxf1)])
        phsmaxf1=phase(maxinf1);disp(['phs for Af1=',num2str(phsmaxf1)])   
    end
    
    if 1
        %disp(['Af2=',num2str()])
        fmaxf2=fb(maxinf2);disp(['f for Af2=',num2str(fmaxf2)])
        phsmaxf2=phase(maxinf2);disp(['phs for Af2=',num2str(phsmaxf2)])   
    end
    
    %inverse fft test
%     X1i=ifft(X1);
%     figure;     plot(t,X1i)
%     hold on;    plot(t, y)
    



%     %% energy conservation check
%     Ent=sum(y.^2)*dt;
%     df = Fs/L; 
%     Enf=sum(abs(Y*dt).^2)*df;
%     if Ent-Enf>1e-8; disp('energy not conserved'); pause;end
end