
%cd G:\orange_backup % any dir
%cd /Volumes/GROUP_BLACK/orange_backup/
close all
clear all

setlatex
set(gca, 'FontSize', 13);

A2switch=0;% A2=1 or A2dA1=0 or both
%Gi=[0.05 0.1 0.2 0.3 0.4 0.5 1 1.25 3]; %All the G

Gi=[0.2 0.3 0.4 0.5 0.6 0.7 0.9 1.0];
mi=[1.5 1.7 2.0 2.2 2.5];

Gi=[0.4];
mi=[1.5];
dampi=[0.05,0.1];



rstr='*';% *

for iG=Gi
    for im=mi
        for idamp=dampi
        close all
        clearvars -except iG im mi Gi A2switch rstr dampi idamp


        sysdir
        gstr=num2str(iG,['%10.1','f']);
        mstr=num2str(im,['%10.1','f']);
        if idamp==0
            lsgamdr=dir(['g',gstr,'a*m',mstr,'r',rstr]);
        else
            dampstr=num2str(idamp,['%10.2','f']);
            lsgamdr=dir(['g',gstr,'a*m',mstr,'d',dampstr,'r',rstr]);
        end
        if isempty(lsgamdr); continue; end

        
        %A1din = input('input: digits after decimal point for A_1 legend? (default is 3 digits)','s');
        %if size(A1din)==0;
            A1din= '3';
        %end

        mrswitch=0; %mass ratio is a variable or not

        n1=1;%starting number of files
        disp(['starting number= ',num2str(n1)])
        if A2switch
            disp('drawing A2 graph')
        else
            disp('drawing A2/A1 graph')
        end

        if mrswitch
            disp('dealing with mass ratios')
        else
            disp('NOT dealing with mass ratios')
        end

        n0=length(lsgamdr);
        s=0;sp=0;
        yaxismax=0;xaxismax=0;
        yaxismin=0;xaxismin=0;
        aryaxismax=0;arxaxismax=0;
        aryaxismin=0;arxaxismin=0;
        sgamall=0;sleg=0;saryaxim=0;sgamall=0;
        clear gamall aryaxismax aryaxismin arxaxismax arxaxismin

        for j=1:n0

            cd (lsgamdr(j).name)
            lsf1=dir('0*');
            n=length(lsf1);
            cd ('../')

            gamdr=s2gamr(lsgamdr(j).name);

            %%
            %if gamr(1)>0.5||gamr(1)~=0.1; continue; end
            if max(gamdr(1)==[0.8]); continue; end
            %%
            
            cd(lsgamdr(j).name)
            Lf1=length(lsf1);
            %%
            if Lf1<30; cd ../; continue; end % if f1 sample less than 30, skip
            %%

            f1=zeros(1,Lf1);A2=zeros(1,Lf1);A2dA1=zeros(1,Lf1);%A2pre=zeros(1,Lf1)

            sgamall=sgamall+1;
            gamall(1:length(gamdr),sgamall)=gamdr;
            A1=gamdr(2);

            go=1;
            for i=1:n

                dirnamef=lsf1(i).name;
                disp(dirnamef);
                cd(dirnamef)
                f1(i)=str2double(lsf1(i).name);
                period=1/str2double(lsf1(i).name); %
                %%
                %if f1(i)~=1.4; cd ../; continue;end
                %%
                [t,y]=textscanty;
                if length(t)<2; cd ../; continue; end
                dt=t(3)-t(2);
                period1n=ceil(period/dt);
                period1n=period1n*1;% number of periods for A=(max-min)/2
                Lt=length(t);
                nperiod=floor(Lt/(period1n));
                %%
                %if nperiod<16; sgamall=sgamall-1;go=0; break; end %
                %if nperiod<30; continue; end

                %%
                disp(pwd)
                disp([num2str(nperiod),'periods'])
                ystart=floor(Lt/2);
                A2(i)=0.5*(max(y(ystart:Lt))-min(y(ystart:Lt)));%(max in 70 period - min)/2
                                                    %based on assumption fo f1=f2 
                                                    %and vibration becomes
                                                    %steady after a few periods
                %A2pre(i)=A2eu(gamr(1),A1,gamr(3),f1(i));
                                                    %else
                    %A2(i)=mean(yampds(yampn:2*yampn));
                %end
                %A2(i)=yampds(1);

                if A2switch==0
                    A2dA1(i)=A2(i)/A1;
                end
                if A2switch==2
                    A2dA1(i)=A2(i)*A1;
                end
                clear ymax ymin yamp yampds t v02 y;

                cd ../
            end
            
            
            
            if go==0; cd ../; cd ../; disp('data too short skip'); continue; end

            saryaxim=saryaxim+1;
            if A2switch==false
                if max(A2dA1)>yaxismax
                    [aryaxismax(sgamall),peaki]=max(A2dA1);
                    if peaki >= length(A2dA1)
                        aryaxismin(sgamall)=min(A2dA1((peaki-1):(peaki)));
                        arxaxismax(sgamall)=f1(peaki);
                        arxaxismin(sgamall)=f1(peaki-1)-(f1(peaki)-f1(peaki-1));
                    else
                        aryaxismin(sgamall)=min(A2dA1((peaki-1):(peaki+1)));
                        arxaxismax(sgamall)=f1(peaki+1);
                        arxaxismin(sgamall)=f1(peaki-1)-(f1(peaki+1)-f1(peaki-1));
                    end
                end
            else
                if max(A2)>yaxismax
                    [aryaxismax(sgamall),peaki]=max(A2);
                    aryaxismin(sgamall)=min(A2((peaki-1):(peaki+1)));
                    arxaxismax(sgamall)=f1(peaki+1);
                    arxaxismin(sgamall)=f1(peaki-1)-(f1(peaki+1)-f1(peaki-1));
                end
            end

            %v02=load([dirnamef,'VIV02.DAT']);

           % %tn=length(v02)/5;%Number of lines plotted
            %s=s+1;
            %figure(s)
            %plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
            %hold on; 
            %plot(v02(:,1),v02(:,4),'color','r') % y displacement of cylinder 2 (free)
            sp=sp+1;
            if A2switch
                h(sp)=plot(f1,A2);

            else
                h(sp)=plot(f1,A2dA1);
            end
            hold on
            sleg=sleg+1;
            if mrswitch 
                %legendInfo{sleg} = ['G=',num2str(gamall(1,sleg),4),'  A_1=',num2str(gamall(2,sleg),['%10.',A1din,'f']),'  m^*=',num2str(gamall(3,j),['%10.',A1din,'f'])];
                legendInfo{sleg} = ['m^*=',num2str(gamall(3,sgamall),['%10.1f'])];
            else
                %legendInfo{sleg} = ['G=',num2str(gamall(1,sgamall),4)];%'  A_1=',num2str(gamall(2,j),['%10.',A1din,'f'])];%specify digit of legend number
                legendInfo{sleg} = ['$A_1/D=$',num2str(gamall(2,sgamall),4)];
            end
            cd ../
        end
        mkdir(['plotting/Amplitude_Frequency/'])
        cd ('plotting/Amplitude_Frequency/')

        yaxismax=max(aryaxismax);
        yaxismin=min(aryaxismin);
        xaxismax=max(arxaxismax);
        xaxismin=min(arxaxismin);

        gmin=num2str(min(gamall(1,:)));gmax=num2str(max(gamall(1,:)));
        a1min=num2str(min(gamall(2,:)));a1max=num2str(max(gamall(2,:)));
        mrmin=num2str(min(gamall(3,:)));mrmax=num2str(max(gamall(3,:)));

        %legend(['G=',num2str(gamall(1,1)),'  A_1=',num2str(gamall(2,1))],'G=3.0  A_1=1.0','G=3.0  A_1=1.5','G=3.0  A_1=2.0','Location','northeast')
        %title(['G=',num2str(gam(1)),'      A1=',num2str(gam(2)),'      m*=',num2str(gam(3))])
        set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
        set(groot, 'defaultLegendInterpreter','latex');

        legend(legendInfo)
        xlabel('$f_1/f_n$','Interpreter','LaTex','FontSize',20);
        if A2switch
            ylabel('$A_2/D$','Interpreter','LaTex','FontSize',20);
        else
            ylabel('$A_2/A_1$','Interpreter','LaTex','FontSize',20);
        end

        set(gca,'XTick',0:0.2:2.5);
        grid on


        %cd ('../')
        %cd ('../')

        %set(h,'Color','Black');
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
        set(h,'markersize',5);
        set(h,'Color','Black');
        %set(h,{'linestyle'},{'-';'-.'});

        %% figure1
        [hleg1, hobj1] = legend;
        set(hleg1,'position',[0.6 0.5 0.2 0.3])
        set(hleg1,'FontSize',15)
        tiname=['Across_A1_G=',gmin,'-',gmax,'_A1=',a1min,'-',a1max,'_mr=',mrmin,'-',mrmax,'_damp=',num2str(idamp),'-',num2str(idamp)];
        if A2switch
            printpdf(gcf,[tiname,'_A2_overall','.eps']);

            saveas(gcf,[tiname,'_A2.fig'])
        else
            printpdf(gcf,[tiname,'_A2dA1_overall','.eps']);
            saveas(gcf,[tiname,'_A2dA1.fig'])
        end
        saveas(gcf,[tiname,'.fig'])
        %% figure 2
        set(h,'markersize',7);

        set(hleg1,'position',[0.2 0.5 0.2 0.3])
        set(hleg1,'FontSize',15)
        set(gca,'XTick',0:0.1:2.5);
        %axis(gca, [xmin xmax ymin ymax])
        axis(gca, [0.3 1.0 0 yaxismax*1.1]);
        %printpdf(gcf,[tiname,'_A2dA1','.eps']);



        %tiname=['G=',gmin,'-',gmax,'_A1=',a1min,'-',a1max,'_mr_max=',mrmin,'-',mrmax];
        if A2switch
            printpdf(gcf,[tiname,'_A2_zoom','.eps']);
        else
            printpdf(gcf,[tiname,'_A2dA1_zoom','.eps']);
        end
        %% figure 3
        set(h,'markersize',15);
        set(gca,'XTick',0:0.025:2.5);
        %zoom on
        %axis(gca, [xmin xmax ymin ymax])
        xmargin=(xaxismax-xaxismin)/10;
        ymargin=(yaxismax-yaxismin)/10;
        axis(gca, [xaxismin-xmargin xaxismax+xmargin yaxismin-ymargin yaxismax+ymargin]);

        %tiname=['G=',gmin,'-',gmax,'_A1=',a1min,'-',a1max,'_mr_max=',mrmin,'-',mrmax];
        if A2switch
            printpdf(gcf,[tiname,'_A2_details','.eps']);
        else
            printpdf(gcf,[tiname,'_A2dA1_details.eps']);
        end
        %%
        end
    end
end


