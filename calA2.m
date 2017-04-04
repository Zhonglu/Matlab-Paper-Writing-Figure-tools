function [A2,f1]=calA2(dirnamef)
disp(dirnamef);
            cd(dirnamef)
            f1=str2double(dirnamef);
            period=1/str2double(dirnamef); %
            %%
            %if f1(i)~=1.4; cd ../; continue;end
            %%
            [t,y]=textscanty;
            if length(t)<2; A2=NaN; return; end
            dt=t(3)-t(2);
            period1n=ceil(period/dt);
            period1n=period1n*1;% number of periods per period
            Lt=length(t);
            nperiod=floor(Lt/(period1n));
            %%
            if nperiod<10; A2=NaN; return; end%
            %if nperiod<30; continue; end
            
            %%
            disp(pwd)
            disp([num2str(nperiod),'periods'])
            ystart=floor(Lt/3*2);
            if ystart>Lt;A2=NaN; return; end
            if (Lt-ystart)<period1n*3; ystart=(Lt-period1n*3);end% get at least 3 periods
            A2=0.5*(max(y(ystart:Lt))-min(y(ystart:Lt)));%(max in 70 period - min)/2
                                                %based on assumption fo f1=f2 
                                                %and vibration becomes
                                                %steady after a few periods
            %else
                %A2(i)=mean(yampds(yampn:2*yampn));
            %end
            %A2(i)=yampds(1);