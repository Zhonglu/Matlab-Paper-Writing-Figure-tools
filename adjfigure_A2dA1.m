function adjfigure_A2dA1
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

% xlim([0.2 1.1])
% ylim([0 1.85])
set(gca,'linewidth',1.4)
ax = gca;
ax.BoxStyle = 'full';
set(gca, 'XTickMode', 'auto', 'XTickLabelMode', 'auto')

ylabel('$A_2/A_1$','Interpreter','LaTex','FontSize',25);
xlabel('$f_1/f_n$','Interpreter','LaTex','FontSize',25);
%yticks([0:45:180])
%ylim([-10 180])
%set(gca,'XTick',0:0.25:2.5);
grid on

h=findobj(gca,'Type','line');
sgamall=length(h);
set(h,'LineWidth',1.2)
if sgamall==8 % for G/D
    %legend('$G/D=0.3$','$G/D=0.5$','$G/D=0.7$','$G/D=0.9$')
end

if sgamall==5 % for m^*
    legend('$m^*=1.5$','$m^*=1.7$','$m^*=2.0$','$m^*=2.2$','$m^*=2.5$')
end

if sgamall==4 % for A1
    %legend('$A_1/D=0.025$','$A_1/D=0.050$','$A_1/D=0.075$','$A_1/D=0.100$')
end

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
    'hexagram'};
%'.'
set(h(1:sgamall),{'Marker'},markerset(1:sgamall));
set(h,'markersize',10.5);
set(h,'Color','Black'); %set(h,'Color','Default');
%set(h,{'linestyle'},{'-';'-.'});
[hleg1, ~] = legend;
%set(hleg1,'position',[0.531696769550958,0.313200939927145,0.247644352166617,0.533411204257857])
set(hleg1,'FontSize',23)

%set(gcf,'position',[281,170,607,428]) % set window size

%cd('/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/Interaction between Two Vibrating Cylinders Immersed in Fluid/elsarticle_Interaction between Two Vibrating Cylinders Immersed in Fluid/figures/')

if sgamall==4
    %set(h,'markersize',6);
    %set(hleg1,'FontSize',17)
    printpdf(gcf,['Across_A1_A2dA1_overall','.eps']);
end


if sgamall==5
    printpdf(gcf,['Across_m_A2dA1_overall','.eps']);
end

if sgamall==8
    printpdf(gcf,['Across_g_A2dA1_overall','.eps']);
end



end