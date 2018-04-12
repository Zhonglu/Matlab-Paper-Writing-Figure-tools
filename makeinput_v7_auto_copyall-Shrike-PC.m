
clc
clear all
close all

%cd ('C:\running_tasks\')

foldername='g0.05a0.04m2.5zl_r25';

copy_or_not=true;

cd (foldername)

str=foldername;
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


%% INPUT PARAMETERs 1
g=gam(1);%G/D
a1=gam(2);%A1
m=gam(3);%m*
re=100;  %Renolds Number
ftspara=0.004;%normally 0.004
codename='2';

walltime='200:00:00'; %Wall clock time
taskstr=['r',num2str(gam(4))]        ;%task number
%% Adjust Title Format
gstr=num2str(g);%    ,'%.3f'
a1str=num2str(a1);%  ,'%.3f'
mstr=num2str(m);%,'%.1f'

%% =============================FOLDERs======================

%---
i=0;
j=0;

while true
    if j<0.35
        i=i+1;
    elseif j>=0.35 && j<0.45
        i=i+0.5;
    elseif j>=0.45 && j<0.8
        i=i+1;
    elseif j>=0.8 && j<0.85
        i=i+0.5;
    elseif j>=0.85 && j<1.0
        i=i+1;
    elseif j>=1 && j<=1.3
        i=i+2;
    elseif j>1.3 && j<=1.8
        i=i+4;
    elseif j>1.8
        i=i+8;
    end
    j=00.05*i;
    name=['0',num2str(j,'%05.3f'),''];
    mkdir(name) 
    if j>=2.4 
        break
    end
end

disp('folder created')
%%



%% =============================COPY1======================

if copy_or_not

disp('copying from proto...')

cd ('proto')
list1=dir('*.TXT');
n1=length(list1);

cd ('../')
list0=dir('0*');
n0=length(list0);

%%
%n0=3;%for test
%%
for j=1:n0
    for i=1:n1
        origin=['./proto/',list1(i).name];
        destin=['./',list0(j).name];
        copyfile(origin,destin)
    end
end
disp('copy done')



%% =============================COPY2======================


disp('copying from proto...')

cd ('proto')
list1=dir('*.bat');
n1=length(list1);

cd ('../')
list0=dir('0*');
n0=length(list0);

%%
%n0=3;%for test
%%
for j=1:n0
    for i=1:n1
        origin=['./proto/',list1(i).name];
        destin=['./',list0(j).name];
        copyfile(origin,destin)
    end
end
disp('copy done')

%% ===========================
end % end of copy

%% =============================EDIT======================
%clear all
%close all

list0=dir('0*');
n0=length(list0);

%n0=3;%test f=0.05



%%
disp(['alter value for ','G/D=',gstr,', A1=',a1str,', m*=',mstr])

for j=1:n0
    %% Calculated INPUT PARAMETERs
    disp(['alter value for ','G/D=',num2str(g),', A1=',num2str(a1),', m*=',num2str(m), ...,
        ' f1=',list0(j).name])
    f1=str2num(list0(j).name);
    visc=2*3.14159265*f1*a1/re; %viscosity
    fts=ftspara/(2*3.14159265*a1*f1); %flow time step
   
    f1str=list0(j).name;
    
    taskname=['Z',f1str,taskstr];
    taskdir=['cd /projects/y73/dongfang/','g',gstr,'a',a1str,'m',mstr,'zl_',taskstr,'/',list0(j).name];
%%   Reading and edit txt
    %
    cd ('proto')
    fid = fopen('VIV_PARA.TXT','r');
    i = 1;
    tline = fgetl(fid);
    txtv{i} = tline;
    while ischar(tline)
        i = i+1;
        tline = fgetl(fid);
        txtv{i} = tline;
    end
    fclose(fid);

    % Change cell 
    txtv{3} = strrep(sprintf('%d',a1),'e','D');
    txtv{4} = strrep(sprintf('%d',f1),'e','D');
    txtv{9} = mstr;
    % 
%% 
    fid = fopen('CALCULATION_PARA.TXT','r');
    i = 1;
    tline = fgetl(fid);
    txtc{i} = tline;
    while ischar(tline)
        i = i+1;
        tline = fgetl(fid);
        txtc{i} = tline;
    end
    fclose(fid);

    % Change cell
    txtc{1} = strrep(sprintf('%d',visc),'e','D');
    txtc{2} = strrep(sprintf('%d',fts),'e','D');
    %%
    fid = fopen('pbs.sh','r');
    i = 1;
    tline = fgetl(fid);
    txtp{i} = tline;
    while ischar(tline)
        i = i+1;
        tline = fgetl(fid);
        txtp{i} = tline;
    end
    fclose(fid);

    % Change cell
    txtp{3} = ['#PBS -l walltime=',walltime];
    txtp{6} = ['#PBS -N ',taskname];
    txtp{7} = taskdir;
    txtp{8} = ['/projects/y73/dongfang/code',codename,'/viv > test.e'];
%%  write txt
    cd ('../')
    cd (list0(j).name)
    fid = fopen('VIV_PARA.TXT', 'w');
    for i = 1:numel(txtv)
        if txtv{i+1} == -1
            fprintf(fid,'%s', txtv{i});
            break
        else
            fprintf(fid,'%s\n', txtv{i});
        end
    end
    
    fid = fopen('CALCULATION_PARA.TXT', 'w');
    for i = 1:numel(txtc)
        if txtc{i+1} == -1
            fprintf(fid,'%s', txtc{i});
            break
        else
            fprintf(fid,'%s\n', txtc{i});
        end
    end
    
    fid = fopen('pbs.sh', 'w');
    for i = 1:numel(txtp)
        if txtp{i+1} == -1
            fprintf(fid,'%s', txtp{i});
            break
        else
            fprintf(fid,'%s\n', txtp{i});
        end
    end
%%
   fclose(fid);
   cd ('../')
end
disp(['NOTE! codename= ',codename])
disp(['NOTE! flow_time_step_para= ',num2str(ftspara)])
disp('edit done')