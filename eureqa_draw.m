clear all; %close all;

%G=0.4;A1=[0.025 0.05 0.075 0.1]; mr=1.5;f1=0.05:0.001:2.4;%sleg=0;i=0;
G=0.2;A1=[0.1]; mr=[1.5 1.7 2.0 2.2 2.5];f1=0.05:0.001:2.4;%


h = findobj('Type', 'line');
i=length(h);hstart=i+1;sleg=0;
for mr=[1.5 1.7 2.0 2.2 2.5]
i=i+1;
%A2 = A1.*( 0.0404610726917864..*f1 + 3.22417005702081..*f1...^(f1...^ (-2.98185247109963..*mr))../ (G + 6.24655536070865..*A1 + (4.88046768088561 + 23.0910663472393..*G)..^f1..*( f1...^(f1...^(-2.98185247109963..*mr)))...^(mr./f1...^(f1...^(-2.98185247109963..*mr)))));
A2= A1* (0.0410712276225994.*f1 + 3.12135534754373.*f1.^(f1.^(-3.12509563952794.*mr))./(G + 14.3334258840871.*A1.*f1.^(f1.^(-3.12509563952794.*mr)) + (3.84756680693061 + 23.6286911002874.*G).^f1.*(f1.^(f1.^(-3.12509563952794.*mr))).^(mr./f1.^(f1.^(-3.12509563952794.*mr)))));
%A2 = 0.0275211883574247.*A1 + 2.53134056832888.*A1.*exp(-1.32694982349777.*G).*gauss(0.143917202827626./f1.^(G + 4.18052201098028.*mr + 0.0330672548540617./A1) - 1.55135322591415);
h(i)=plot(f1,A2/A1,'LineWidth',1.3); hold on;
sleg=sleg+1;
legendInfo{sleg} = ['Mod: $A_1=$',num2str(A1)];

end
    set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
    set(groot, 'defaultLegendInterpreter','latex');
legend(legendInfo)

xlabel('$f_1$','Interpreter','LaTex','FontSize',20);
ylabel('$A_2$','Interpreter','LaTex','FontSize',20);


    set(gca,'XTick',0:0.2:2.5);
    grid on


    %cd ('.../')
    %cd ('.../')

    %set(h,'Color','Black');
    markerset={
'-'	%Solid line (default)
'--'	%Dashed line
':'	%Dotted line
'-.'%Dash-dot line
};
    set(h(hstart:i),{'LineStyle'},markerset(1:(i-hstart+1)));
    set(h,'markersize',5);
    set(h,'Color','Black');
    %set(h,{'linestyle'},{'-';'-.'});
    [hleg1, hobj1] = legend;
    set(hleg1,'position',[0.6 0.5 0.2 0.3])
    set(hleg1,'FontSize',15)
    printpdf(gcf,['Eureqa_A2.pdf'])
%
stop

xlim([0.7837 0.9044])
ylim([0.0771 0.1682])
set(gca,'XTick',0:0.025:2.5);
printpdf(gcf,['Eureqa_A2_details.pdf'])


