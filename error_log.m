%{
plotting_both/g0.3a0.100m1.5r180
Subscript indices must either be real positive integers or logicals.

Error in autocut>findcut (line 19)
    Ast=(max(y(tstartn:tendn))-min(y(tstartn:tendn)))*0.5;

Error in autocut (line 3)
    cut1=findcut(f1,t1,y1,errlim);

Error in Check_both_CY_and_Y_plot_all_fft_th>checkplot_CY_and_Y (line 121)
[t1,y1,t2,y2]=autocut(f1,t1,y1,t2,y2);

Error in Check_both_CY_and_Y_plot_all_fft_th (line 68)
        [err,stperiods]=checkplot_CY_and_Y(fdir,zpf,start,pdir,ttl_p,pname,ylimfftl,f1,nT,ylimthl,A1,ylimfftr,ylimthr); 


%}