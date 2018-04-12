clear all
%close all
setlatex

%cd 'C:\Users\Zhonglu Lin\OneDrive\PhDWorks\VIV\temp' %for windows
sysdir
cd ../
%cd Free_cylinder_validation_manuscript
%cd Free_cylinder_G1.5_spr_30_test1 % does not work
%cd Free_cylinder_G1.5_spr_25_test2
%cd Free_cylinder_G1.5_spr_20_test3
%cd Free_cylinder_G1.5_spr_15_test4
%cd G1.5_dx_0.01_ftspara_0.000125
%cd G1.5_dx_0.005_ftspara_0.0000625
%cd G1.5_dx_0.0025_ftspara_0.00003125
list0=dir('g*a*m*d*e*r*');

for i=1:length(list0)
    namels(i,:)=s2gamr(list0(i).name);
end
Gi=unique(namels(:,1))';
Ai=unique(namels(:,2))';
mi=unique(namels(:,3))';
di=unique(namels(:,4))';
ei=unique(namels(:,5))';

for iA=Ai
    for im=mi
        for iG=Gi
            for id=di
                
                %            for i=1:length(list0)
                
                astr=num2str(iA,['%10.3','f']);
                mstr=num2str(im,['%10.1','f']);
                gstr=num2str(iG,['%10.1','f']);
                dstr=num2str(id,['%10.2','f']);
                
                nlist0=dir(['g',gstr,'a',astr,'m',mstr,'d',dstr,'e*r*']);
                for i=1:length(nlist0)
                    temp=s2gamr(nlist0(i).name);
                    re_temp(i)=temp(5);
                end
                [re_order,I]=sort(re_temp,'descend');
                nlist0=nlist0(I);
                clear I re_order re_temp
                figure;hold on;
                if length(nlist0)==0; continue; end
                for i=1:length(nlist0)
                    
                    gamder=s2gamr(nlist0(i).name);
                    re=gamder(5);
                    
                    %if re==100;continue;end
                    
                    cd([nlist0(i).name,'/01.000'])
                    [t,y]=textscanty;
                    
                    h(i)=plot(t,y);%,'color','black'); % v02 coefficient of cylinder 2 (free)
                    %xlabel('t.*fn2');
                    xlabel('$tf_1$','Interpreter','LaTex','FontSize',20)
                    ylabel('$Y_2/D$','Interpreter','LaTex','FontSize',20)
                    legendInfo{i} = ['$Re=$',num2str(re,['%10.0f'])];
                    cd ../../;
                    % end
                    legend(legendInfo)
                end
                ylim([-2 1.5])
                xlim([0 6])
                saveas(gcf,['g',gstr,'a',astr,'m',mstr,'d',dstr,'.fig'])
            end
        end
    end
end



% overlap Gazzola figure
cd ../Gazzola_data
nlist0=dir(['Re_*']);
nlist0=nlist0(end:-1:1);
clear I re_order re_temp
for i=1:length(nlist0)
    
    re=s2gamr_dot(nlist0(i).name);
    %re=gamder(1);
    
    %if re==100;continue;end
    
    %cd([nlist0(i).name,'/01.000'])
    file=fopen(nlist0(i).name);
    temp=textscan(file,'%f %f');
    t=temp{1,1};
    y=temp{1,2};
    h(i)=plot(t,y,'--');%,'color','black'); % v02 coefficient of cylinder 2 (free)
    %xlabel('t.*fn2');
    xlabel('$tf_1$','Interpreter','LaTex','FontSize',20)
    ylabel('$Y_2/D$','Interpreter','LaTex','FontSize',20)
    legendInfo{i} = ['$Re=$',num2str(re,['%10.0f'])];
    %cd ../../;
    % end
    legend(legendInfo)
end

ylim([-2 1.5])
xlim([0 6])
saveas(gcf,['g',gstr,'a',astr,'m',mstr,'d',dstr,'.fig'])
% Re=15		Re=20		Re=25		Re=27		Re=30		Re=40		Re=50		Re=60		Re=80		Re=100





