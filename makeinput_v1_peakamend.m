
clc
clear all
close all

%cd ('C:\running_tasks\')

foldername='g1a0.25m2.5f0.8125_r10';
mkdir(foldername)
account='SOGA-SL4';% to charge money!!!

%Calculation parameters
tts=20001;% total time step
odfis=500;% Output data frequency in steps
misfve=1000;% Maximum iteration step for velocity equation
misfppe=10000;% Maximum iteration step for Pressure Possion equation
copy_or_not=false; %switch to copy everything or not

cd (foldername)

str=foldername;
str(str=='r')=[' '];
str(str=='u')=[];
str(str=='n')=[];
str(str=='_')=[];
str(str=='z')=[];
str(str=='p')=[];
str(str=='e')=[];
%str(str=='a')=[];
str(str=='k')=[];
str(str=='l')=[' '];
str1=str;
str(str=='g')=' ';
str(str=='a')=' ';
str(str=='m')=' ';
str(str=='f')=' ';

gamf=str2num(str);


%% INPUT PARAMETERs 1
g=gamf(1);%G/D
a1=gamf(2);%A1
m=gamf(3);%m*
f1=gamf(4);
re=100;  %Renolds Number
ftspara=0.004;%normally 0.004
codename='2';


walltime='12:00:00'; %Wall clock time
taskstr=['r',num2str(gamf(4))]        ;%task number
%% Adjust Title Format
gstr=num2str(g);%    ,'%.3f'
a1str=num2str(a1);%  ,'%.3f'
mstr=num2str(m);%,'%.1f'

%% =============================FOLDERs======================

%---
%%



%% =============================COPY1======================

if copy_or_not 

disp('copying from public_proto...')

cd ('public_proto')
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
        origin=['./public_proto/',list1(i).name];
        destin=['./',list0(j).name];
        copyfile(origin,destin)
    end
end
disp('copy done')



%% =============================COPY2======================


disp('copying from public_proto...')

cd ('public_proto')
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
        origin=['./public_proto/',list1(i).name];
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

for j=1:1
    %% Calculated INPUT PARAMETERs
    %f1=str2num(list0(j).name);
    disp(['alter value for ','G/D=',num2str(g),', A1=',num2str(a1),', m*=',num2str(m), ...,
        ' f1=',f1])
    visc=2*3.14159265*f1*a1/re; %viscosity
    fts=ftspara/(2*3.14159265*a1*f1); %flow time step
   
    f1str=num2str(f1);
    taskname=['f',f1str,'R',num2str(gamf(5))];
    taskdir='cd $workdir';

%%   Reading and edit txt
    %
    cd ../
    cd ('public_proto')
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
    txtv{3} = [strrep(sprintf('%d',a1),'e','D'),'    -> amplitude of the forced vibration'];
    txtv{4} = [strrep(sprintf('%d',f1),'e','D'),'    -> frequency (1/period) of the forced vibration'];
    txtv{9} = [mstr,'   -> mass ratio'];
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
    txtc{1} = [strrep(sprintf('%d',visc),'e','D'),'       --> viscosity'];
    txtc{2} = [strrep(sprintf('%d',fts),'e','D'),'       --> FLOW TIME STEP'];
    txtc{4} = [num2str(tts),'         --> Total time steps'];
    txtc{5} = [num2str(odfis),'         --> Output data frequency in steps'];
    txtc{7} = [num2str(misfve),'         --> Maximum iteration step for velocity equation'];
    txtc{10} = [num2str(misfppe),'         --> Maximum iteration step for Pressure Possion equation'];
    
    
    %%
    fid = fopen('slurm_submit.txt','r');
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

    txtp{13} = ['#SBATCH -J ',taskname];
    txtp{15} = ['#SBATCH -A ',account];
    txtp{24} = ['#SBATCH --time=',walltime];
    txtp{63} = ['application="/home/zl352/VIVHPC/code',codename,'/viv"']; %code dir
    txtp{107} = taskdir;     %running dir 
%%  write txt
    cd ('../')
    cd (foldername)
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
    
    fid = fopen('slurm_submit.txt', 'w');
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