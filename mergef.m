%function mergef
clear all; close all; fclose all;
    sysdir
    disp('processing gamdr cases')
        listtemp=dir(['g*a*m*d*r*']);
    L=length(listtemp);
    for i1=1:(L-1)
        for i2=(i1+1):L
            gamr1=s2gamr(listtemp(i1).name);
            gamr2=s2gamr(listtemp(i2).name);
            if min(gamr1(1:4)==gamr2(1:4))
                statusmove=0;statuscopy=0;
                [statusmove,messagemove,messageIdmove]=movefile([listtemp(i2).name,'\*'],listtemp(i1).name);
                if statusmove~=1
                    [statuscopy,messagecopy,messageIdcopy]=copyfile([listtemp(i2).name,'\*'],listtemp(i1).name);
                end
                if statuscopy==1||statusmove==1
                    rmdir(listtemp(i2).name,'s');
                    disp(['removed ',listtemp(i2).name])
                else
                    disp('error')
                    pause
                end
                %merge folder i1 and folder i2
            end
        end
    end
    
    stop
    pause
    disp('proceed to gam d=0 cases')
    
    clear all
    listtemp=dir(['g*a*m*r*']);
    L=length(listtemp);
    for i1=1:(L-1)
        for i2=(i1+1):L
            gamr1=s2gamr(listtemp(i1).name);
            gamr2=s2gamr(listtemp(i2).name);
            if min(gamr1(1:3)==gamr2(1:3))
                statusmove=0;statuscopy=0;
                [statusmove,messagemove,messageIdmove]=movefile([listtemp(i2).name,'\*'],listtemp(i1).name);
                if statusmove~=1
                    [statuscopy,messagecopy,messageIdcopy]=copyfile([listtemp(i2).name,'\*'],listtemp(i1).name);
                end
                if statuscopy==1||statusmove==1
                    rmdir(listtemp(i2).name,'s');
                    disp(['removed ',listtemp(i2).name])
                else
                    disp('error')
                    pause
                end
                %merge folder i1 and folder i2
            end
        end
    end



%end