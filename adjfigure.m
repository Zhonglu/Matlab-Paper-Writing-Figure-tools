function adjfigure
    set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
    set(groot, 'defaultLegendInterpreter','latex');
    
    xlabel('$f_1/f_n$','Interpreter','LaTex','FontSize',26);
    
    ylabel('Phase difference (degrees)','Interpreter','LaTex','FontSize',25);
    yticks([0:45:180])
    ylim([-10 180])
    set(gca,'XTick',0:0.25:2.5);
    grid on
    
    h=findobj(gca,'Type','line');
    sgamall=length(h);
    
    if sgamall==8 % for G/D
        legend('$G/D=0.2$','$G/D=0.3$','$G/D=0.4$','$G/D=0.5$','$G/D=0.6$','$G/D=0.7$','$G/D=0.9$','$G/D=1.0$')
    end
    
    if sgamall==5 % for m^*
        legend('$m^*=1.5$','$m^*=1.7$','$m^*=2.0$','$m^*=2.2$','$m^*=2.5$')
    end
    
    if sgamall==4 % for A1
        legend('$A_1/D=0.025$','$A_1/D=0.050$','$A_1/D=0.075$','$A_1/D=0.100$')
    end
    
    markerset={
'+'	
'o'	
'*'	
'.'	
'x'	
'square'
'diamond'
'^'	
'v'	
'>'	
'<'	
'pentagram'
'hexagram'};
    set(h(1:sgamall),{'Marker'},markerset(1:sgamall));
    set(h,'markersize',6);
    set(h,'Color','Black');
    %set(h,{'linestyle'},{'-';'-.'});
    [hleg1, ~] = legend;
    set(hleg1,'position',[0.531696769550958,0.313200939927145,0.247644352166617,0.533411204257857])
    set(hleg1,'FontSize',23)
    
    set(gcf,'position',[281,170,607,428]) % set window size
    
    cd('/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/JFM latex files - IFC - 19_04_2016/phase/')
    
    if sgamall==4
        printpdf(gcf,['varya','.eps']);
    end
    
    
    if sgamall==5
        printpdf(gcf,['varym','.eps']);
    end
    
    if sgamall==8
        printpdf(gcf,['varyg','.eps']);
    end
    
    
    
end