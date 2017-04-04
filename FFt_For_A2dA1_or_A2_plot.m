%


%cd G:\orange_backup % any dir
%cd /Volumes/GROUP_BLACK/orange_backup/
clear all

%Gi=[0.05 0.1 0.2 0.3 0.4 0.5 1 1.25 3]; %All the G

Gi=[0.4];
mi=[1.5];
for i3=Gi
    for i4=mi

        close all
        clearvars -except i3 i4 Gi mi
        sys=computer;
        if sys(1:6)=='MACI64'
            cd '/Volumes/GROUP_BLACK/orange_backup/'
        else
            cd E:\Independent_23_Dec
        end
        gstr=num2str(i3,['%10.1','f']);
        mstr=num2str(i4,['%10.1','f']);
        list0=dir(['g',gstr,'*m',mstr,'*']);

        %A1din = input('input: digits after decimal point for A_1 legend? (default is 3 digits)','s');
        %if size(A1din)==0;
            A1din= '3';
        %end

        maximumA1=inf;

        A2switch=false; % A2=true or A2dA1=false

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

        n0=length(list0);
        s=0;sp=0;
        yaxismax=0;xaxismax=0;
        yaxismin=0;xaxismin=0;
        aryaxismax=0;arxaxismax=0;
        aryaxismin=0;arxaxismin=0;
        countl=0;
        clear gamall aryaxismax aryaxismin arxaxismax arxaxismin
        for j=n1:n0

            cd (list0(j).name)
            list=dir('0*');
            n=length(list);
            cd ('../')

            str=list0(j).name;
            str(str=='r')=[' '];
            str(str=='u')=[];
            str(str=='n')=[];
            str(str=='_')=[];
            str(str=='z')=[];
            str(str=='l')=[' '];
            str1=str;
            str(str=='g')=' ';
            str(str=='a')=' ';
            str(str=='m')=' ';
            gam=str2num(str);
            gamall(1:length(gam),j)=gam;
            A1=gam(2);
%             if A1>maximumA1
%                 continue
%             end
            countl=countl+1;
            %CM = lines(10);
            %{
            for i=1:1
                dirnamef=[list0(j).name,'/',list(i).name,'/'];
                %v01=load([dirname,'VIV01.DAT']);
                v01=load([dirnamef,'VIV01.DAT']);
                disp(dirnamef);
                %tn=length(v01)/5;%Number of lines plotted
                s=s+1;
                figure(s)
                %plot(v01(1:tn,1),v01(1:tn,4),'color','b') % y displacement of cylinder 1 (forced)
                %hold on; 

                plot(v01(:,1),v01(:,4),'color','b') % y displacement of cylinder 2 (free)
                title([list0(j).name,'  f1/fn2=',list(i).name,' VIV01'])
                xlabel('t*fn2');
                ylabel('X/D');
                tiname=[list0(j).name,'_',list(i).name,'_VIV01'];
                cd ('plotting')
                print('-dpng','-r600',['Plotting_',tiname,'.png']);

                cd ('../')
            end
            %}
    %         if not(A1==0.1)
    %             continue
    %         end
            for i=1:n
                dirnamef=[list0(j).name,'/',list(i).name,'/'];
                disp(dirnamef);
                f1(i)=str2double(list(i).name);


    %             if A1==0.1 && f(i)==0.4
    %                 stop
    %             else
    %                 continue
    %             end


                period=1/str2double(list(i).name); %
                v02=load([dirnamef,'VIV02.DAT']);
                v02=unique(v02,'rows');

                t=v02(:,1);
                y=v02(:,4);

                [A2(i),f2(i)]=Contfft(t,y,f1(i));
                
                if A2switch==false
                    A2dA1(i)=A2(i)/A1;
                end




                clear ymax ymin yamp yampds t v02 y;


            end

            if A2switch==false
                if max(A2dA1)>yaxismax
                    [aryaxismax(j),peaki]=max(A2dA1);
                    aryaxismin(j)=min(A2dA1((peaki-1):(peaki+1)));
                    arxaxismax(j)=f1(peaki+1);
                    arxaxismin(j)=f1(peaki-1)-(f1(peaki+1)-f1(peaki-1));
                end
            else
                if max(A2)>yaxismax
                    [aryaxismax(j),peaki]=max(A2);
                    aryaxismin(j)=min(A2((peaki-1):(peaki+1)));
                    arxaxismax(j)=f1(peaki+1);
                    arxaxismin(j)=f1(peaki-1)-(f1(peaki+1)-f1(peaki-1));
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
            if mrswitch 
                %legendInfo{j} = ['G=',num2str(gamall(1,j),4),'  A_1=',num2str(gamall(2,j),['%10.',A1din,'f']),'  m^*=',num2str(gamall(3,j),['%10.',A1din,'f'])];
                legendInfo{j} = ['m^*=',num2str(gamall(3,j),['%10.1f'])];
            else
                legendInfo{j} = ['G=',num2str(gamall(1,j),4),'  A_1=',num2str(gamall(2,j),['%10.',A1din,'f'])];%specify digit of legend number
            end

        end
        mkdir(['fft_Amplitude_Frequency_imp/'])
        cd ('fft_Amplitude_Frequency_imp/')

        yaxismax=max(aryaxismax);
        yaxismin=min(aryaxismin);
        xaxismax=max(arxaxismax);
        xaxismin=min(arxaxismin);

        gmin=num2str(min(gamall(1,:)));gmax=num2str(max(gamall(1,:)));
        a1min=num2str(min(gamall(2,:)));a1max=num2str(max(gamall(2,:)));
        mrmin=num2str(min(gamall(3,:)));mrmax=num2str(max(gamall(3,:)));

        %legend(['G=',num2str(gamall(1,1)),'  A_1=',num2str(gamall(2,1))],'G=3.0  A_1=1.0','G=3.0  A_1=1.5','G=3.0  A_1=2.0','Location','northeast')
        %title(['G=',num2str(gam(1)),'      A1=',num2str(gam(2)),'      m*=',num2str(gam(3))])
        legend(legendInfo)
        xlabel('$f_1$','Interpreter','LaTex','FontSize',20);
        if A2switch
            ylabel('$A_2$','Interpreter','LaTex','FontSize',20);
        else
            ylabel('$A_2/A_1$','Interpreter','LaTex','FontSize',20);
        end

        set(gca,'XTick',0:0.2:2.5);
        grid on


        %cd ('../')
        %cd ('../')

        %set(h,'Color','Black');
        markerset={'o';'+';'*';'x';'s';'d';'^'};
        set(h(1:countl),{'Marker'},markerset(1:countl));
        set(h,'Color','Black');
        %set(h,{'linestyle'},{'-';'-.'});
        [hleg1, hobj1] = legend;
        set(hleg1,'position',[0.6 0.5 0.2 0.3])
        set(hleg1,'FontSize',15)
        %% figure1

        tiname=['G=',gmin,'-',gmax,'_A1=',a1min,'-',a1max,'_mr=',mrmin,'-',mrmax];
        if A2switch
            print('-dpng','-r600',[tiname,'_A2_overall','.png']);
        else
            print('-dpng','-r600',[tiname,'_A2dA1_overall','.png']);
        end
        %% figure 2


        set(hleg1,'position',[0.2 0.5 0.2 0.3])
        set(hleg1,'FontSize',15)
        set(gca,'XTick',0:0.1:2.5);
        %axis(gca, [xmin xmax ymin ymax])
        axis(gca, [0.3 1.0 0 (yaxismax+0.1)]);
        %print('-dpng','-r600',[tiname,'_A2dA1','.png']);

        %tiname=['G=',gmin,'-',gmax,'_A1=',a1min,'-',a1max,'_mr_max=',mrmin,'-',mrmax];
        if A2switch
            print('-dpng','-r600',[tiname,'_A2_zoom','.png']);
        else
            print('-dpng','-r600',[tiname,'_A2dA1_zoom','.png']);
        end
        %% figure 3

        set(gca,'XTick',0:0.025:2.5);
        %zoom on
        %axis(gca, [xmin xmax ymin ymax])
        xmargin=(xaxismax-xaxismin)/10;
        ymargin=(yaxismax-yaxismin)/10;
        axis(gca, [xaxismin-xmargin xaxismax+xmargin yaxismin-ymargin yaxismax+ymargin]);

        %tiname=['G=',gmin,'-',gmax,'_A1=',a1min,'-',a1max,'_mr_max=',mrmin,'-',mrmax];
        if A2switch
            print('-dpng','-r600',[tiname,'_A2_details','.png']);
        else
            print('-dpng','-r600',[tiname,'_A2dA1_details','.png']);
        end
        %%

    end
end
