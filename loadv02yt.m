function [y,t]=loadv02yt(tstart,tend)
    [t,y]=textscanty;
    %% truncate t<50
    if ~exist('tstart','var') || isempty(tstart)
    else
        if ~exist('tend','var') || isempty(tend)
        t=t(tstart:end);y=y(tstart:end);
        else
            t=t(tstart:tend);y=y(tstart:tend);
        end
    end



end