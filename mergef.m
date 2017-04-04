%function mergef
clear all; close all; fclose all;
    sysdir
    listf=dir(['g*a*m*r*']);
    L=length(listf);
    for i1=1:(L-1)
        for i2=(i1+1):L
            gamr1=s2gamr(listf(i1).name);
            gamr2=s2gamr(listf(i2).name);
            if min(gamr1(1:3)==gamr2(1:3))
                statusmove=0;statuscopy=0;
                [statusmove,messagemove,messageIdmove]=movefile([listf(i2).name,'\*'],listf(i1).name);
                if statusmove~=1
                    [statuscopy,messagecopy,messageIdcopy]=copyfile([listf(i2).name,'\*'],listf(i1).name);
                end
                if statuscopy==1||statusmove==1
                    rmdir(listf(i2).name,'s');
                    disp(['removed ',listf(i2).name])
                else
                    disp('error')
                    pause
                end
                %merge folder i1 and folder i2
            end
        end
    end



%end