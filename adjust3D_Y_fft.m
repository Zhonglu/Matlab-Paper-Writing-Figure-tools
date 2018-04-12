function adjust3D_Y_fft
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
ylabel('$f_1/f_n$','Interpreter','LaTex','FontSize',25);
xlabel('$f/f_n$','Interpreter','LaTex','FontSize',25);
zlabel('$A/D$','Interpreter','LaTex','FontSize',25);
zt = get(gca, 'ZTick');set(gca, 'FontSize', 19)
set(gca,'linewidth',1.3)
set(gca,'XMinorTick','on','YMinorTick','on')
%yticks([0:45:180])
%ylim([-10 180])
%set(gca,'XTick',0:0.25:2.5);
%grid on

h=findobj(gca,'Type','line');
%yla=findobj(gca,'Type','ylabbel');

sgamall=length(h);




%set(h,{'linestyle'},{'-';'-.'});
[hleg1, ~] = legend;
set(hleg1,'position',[0.531696769550958,0.313200939927145,0.247644352166617,0.533411204257857])
set(hleg1,'FontSize',23)

%set(gcf,'position',[281,170,607,428]) % set window size

%cd('/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/Interaction between Two Vibrating Cylinders Immersed in Fluid/elsarticle_Interaction between Two Vibrating Cylinders Immersed in Fluid/figures/')
%printpdf(gcf,['3D_fft_displacement_overview','.eps']);

%half peak: axis([0 1.4 0.34 0.46 0 0.007])
% printpdf(gcf,['3D_fft_displacement_half_peak','.eps']);

%full peak: axis([0 2.4 0.72 0.86 0 0.04])
% printpdf(gcf,['3D_fft_displacement_over','.eps']);
end