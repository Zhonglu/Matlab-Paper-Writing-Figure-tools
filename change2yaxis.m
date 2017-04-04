function change2yaxis(times)

h=gca; yyaxis left; ylim(h.YLim/times); yyaxis right; ylim(h.YLim/times)