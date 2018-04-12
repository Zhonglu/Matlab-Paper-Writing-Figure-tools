function primes=ODEs(t,a,Cyt,rightn)
% t time; x array of functions; t1 Cy time;y1 Cy values

%damp_ratio=0.9;

primes=[a(2);
        -4*pi*pi*a(1)+right(t,Cyt,rightn)];% Undamped
        %-4*pi*pi*a(1)+right(t,Cyt,rightn)- 4*pi*0.9*a(2)]; %disp('damped')% Damped