function damp_adjfigure_phase
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

cd('/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/damping ratio comparison/magnification_factor/')
%targetname1='C2-C1 disp phase diff at f=f1G0.2_A10.1m20dmin0dmax0.8.fig';
%open(targetname1)
box on

ylabel('Phase difference (degrees)','Interpreter','LaTex','FontSize',25);
xlabel('$f_1/f_n$','Interpreter','LaTex','FontSize',25);
yticks([0:45:180])
ylim([-3 183])
set(gca,'XTick',0:0.25:2.5);
grid on

h=findobj(gca,'Type','line');
sgamall=length(h);

% legend('$m^*=1.5$' ...
% 	  ,'$m^*=1.7$' ...
% 	  ,'$m^*=2.0$' ...
% 	  ,'$m^*=2.2$' ...
% 	  ,'$m^*=2.5$' ...
% )


% legend('$G/D=0.3$' ...
% ,'$G/D=0.5$' ...
% ,'$G/D=0.7$' ...
% ,'$G/D=0.9$' ...
% )

% legend('$G/D=0.3$' ...
% ,'$G/D=0.5$' ...
% ,'$G/D=0.7$' ...
% ,'$G/D=0.9$' ...
% )

% 
legend('$\zeta=0.00$' ...
    ,'$\zeta=0.05$' ...
    ,'$\zeta=0.10$' ...
,'$\zeta=0.20$' ...
,'$\zeta=0.40$' ...
,'$\zeta=0.60$' ...
,'$\zeta=0.80$' ...
,'$\zeta=1.00$' ...
,'$\zeta=1.20$' ...
,'$\zeta=1.40$' ...
)

% legend('$\zeta=0.05$' ...
%     ,'$\zeta=0.10$' ...
% )

%     if sgamall==8 % for G/D

%     end
%
%     if sgamall==5 % for m^*
%         legend('$m^*=1.5$','$m^*=1.7$','$m^*=2.0$','$m^*=2.2$','$m^*=2.5$')
%     end
%
    if sgamall==4 % for A1
        legend('$A_1/D=0.025$','$A_1/D=0.050$','$A_1/D=0.075$','$A_1/D=0.100$')
    end
h=findobj(gca,'Type','line');sgamall=length(h);
markerset={
    '+'
    'o'
    '*'
    'x'
    'square'
    'diamond'
    '^'
    'v'
    '>'
    '<'
    'pentagram'
    'hexagram'};%'.'
%markerset=markerset(sgamall:-1:1);
% lineset={
%     '-'
%     '--'
%     '-.'
%     ':'
% };
set(h(1:sgamall),{'Marker'},markerset(1:sgamall));
set(h,'markersize',10.5);
set(h,'Color','Black');
%set(h,{'linestyle'},{'-';'-.'});
[hleg1, ~] = legend;
set(hleg1,'position',[0.531696769550958,0.313200939927145,0.247644352166617,0.533411204257857])
set(hleg1,'FontSize',23)

%set(gcf,'position',[281,170,607,428]) % set window size



%     if sgamall==4
%         set(h,'markersize',10.5);
%         set(hleg1,'FontSize',17)
%         ylabel('Phase difference (degrees)','Interpreter','LaTex','FontSize',20);
%         printpdf(gcf,['varya','.eps']);
%     end
%
%
%     if sgamall==5
%         printpdf(gcf,['varym','.eps']);
%     end
%
%     if sgamall==8
disp('printpdf?')
stop

printpdf(gcf,[targetname1,'.eps']);
%printpdf(gcf,['varydamp_C2-C1_disp_phase_diff_at_f=f1G0.2_A10.1m20dmin0dmax0.8.eps']);
saveas(gcf,targetname1)

figure
dr=[0.00000001,0.05,0.1,0.2:0.2:1.6];
%zeta(zeta>1/sqrt(2))=[];
%fmax=zeros(length(zeta))
fr=[0.000000001:0.01:2.4];
hold on
for i=1:length(dr)
pdiff=(atan(2*dr(i).*fr./(1.-fr.^2))+pi)/pi*180;
pdiff(pdiff>180)=pdiff(pdiff>180)-180;

plot(fr,pdiff,'LineWidth',2.2)%,'r--'

end

     

%(A2/D) = f1((G/D), (f1/fn), (A1/D), Re)/sqrt((f1/fn)^2*4*f4()*(mr/(mr + 1)) + (f4()*mr/(mr + 1) - (f1/fn)^2)^2)
%end