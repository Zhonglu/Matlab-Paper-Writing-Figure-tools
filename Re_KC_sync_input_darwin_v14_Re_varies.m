%makeinput_v11_auto_copyall_SBATCH_remesh_input_mass_ratio

%this version can deal with damping ratio
%clc
clear all
close all
fclose all;
cd('/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/VIV')
%cd ('C:\running_tasks\')
%folderlist=dir('*r83');

% damp f
% Gtarget=0.4;
% A1target=0.025;
% mtarget=1.5;
% damptarget=[
%     0.00
%     0.05
%     0.10
%     0.20
%     0.40
%     ];
% f1target=[ % corresponding each damp
%     0.78
%     0.78
%     0.78
%     0.795
%     0.9
%     ];



copyall_or_not=1;
ttperiods=500;

account='SOGA';% zl352
%account='LIANG-SL4';%dl359 xz328 fy hj

ristart=1590;%;
ri=ristart-1;
s=0;
%%{
if1=[
    %     00.050
    %     00.150
    %     00.200
    %     00.250
    %     00.300
    %     0.35
    %     0.36
    %     0.37
    %     0.38
    %     0.39
    %     0.4
    %     0.41
    %     0.42
    %     0.43
    %     0.44
    %     0.45
    %     00.500
    %     00.550
    %     00.600
    %     00.650
    %     00.700
    %     0.71
    %     0.72
    %     0.73
    %     0.74
    %     0.75
    %     0.76
    %     0.77
    %     0.78
    %     0.79
    %     0.795
    %     00.800
    %     00.825
    %     00.850
    %     00.900
    %     00.950
    %     01.000
    %     01.100
    %     01.200
    %     01.300
    %     01.400
    %     01.600
    %     01.800
    %     02.000
    %     02.400
    
    00.050
    00.100
    00.150
    00.200
    00.250
    00.300
    00.350
    00.360
    00.370
    00.380
    00.390
    00.400
    00.410
    00.420
    00.430
    00.440
    00.450
    00.500
    00.550
    00.600
    00.650
    00.700
    00.705
    00.710
    00.715
    00.720
    00.725
    00.730
    00.735
    00.740
    00.745
    00.750
    00.755
    00.760
    00.765
    00.770
    00.775
    00.780
    00.785
    00.790
    00.795
    00.800
    00.825
    00.850
    00.900
    00.950
    01.000
    01.100
    01.200
    01.300
    01.400
    01.600
    01.800
    02.000
    02.400
    
    ]';

%}
%if1=[0.379 0.757];
%if1=[2.8:0.4:10];
% if1=[
% 0.35
% 0.36
% 0.37
% 0.38
% 0.39
% 0.4
% 0.41
% 0.42
% 0.43
% 0.44
% 0.45
%
% 0.705
% 0.71
% 0.715
% 0.72
% 0.725
% 0.73
% 0.735
% 0.74
% 0.745
% 00.750
% 0.755
% 0.76
% 0.765
% 0.77
% 0.775
% 0.78
% 0.785
% 0.79
% 0.795
% ]';

%re=100;% Reynolds Number
for sn=1:1
    
    if sn==1
        ristart2=ristart;
    else
        ristart2=ri+1;
    end
    
    if sn==1 %A1 varies
        gii=[3];
        aii=[
            0.1592
            0.3183
            0.4775
            0.6366
            0.7958
            0.9549
            1.1141
            1.2732
            1.4324
            1.5915
            1.7507
            1.9099
            ];
        mii=[2];
        dampii=[0.00,0.02];
        reii=[
            35.0000
            70.0000
            105.0000
            140.0000
            175.0000
            210.0000
            245.0000
            280.0000
            315.0000
            350.0000
            385.0000
            420.0000]';
    end
    
    if sn==2 %m* varies
        gii=0.9;
        aii=0.4775;
        mii=[1.5, 1.7, 2.0, 2.2, 2.5];
        dampii=[0,0.05, 0.1,0.2];
        reii=[50,70];
    end
    
    if sn==3 %G varies
        gii=0.9;
        aii=0.4775;
        mii=[1.5, 1.7, 2.0, 2.2, 2.5];
        dampii=[0,0.05, 0.1,0.2];
        reii=[90,110];
    end
    
    clear txt
    for gi=gii
        
        for mi=mii
            for dampi=dampii
                
                for iar=1:length(aii)
                    if length(aii)~=length(reii)
                        stop%
                    end
                    %for ai=aii
                    %for rei=reii
                    ai=aii(iar);
                    rei=reii(iar);
                    
                    ri=ri+1;
                    temp1=['g',num2str(gi,'%.1f'),...
                        'a',num2str(ai,'%.3f'), ...
                        'm',num2str(mi,'%.1f'),...
                        'd',num2str(dampi,'%.2f'),...
                        'e',num2str(rei,'%.1f'),...
                        'r',num2str(ri)];
                    mkdir(temp1)
                    disp(temp1)
                    
                    
                    s=s+1;
                    txt{s}=['cd ./*r',num2str(ri),'; chmod u+x suball.com; ./suball.com; cd ../'];
                    
                end
            end
        end
    end
    
    
    disp('===1st level folders created===')
    
    %% write submit.com file
    fid = fopen(['./',num2str(ristart2),'_to_',num2str(ri),'_subauto_hpc'], 'w');
    for ii = 1:length(txt)
        fprintf(fid,'%s\n', txt{ii});
    end
end

%%
start_task_num=ristart;
end_task_num=ri;%117+18-1;

nn=end_task_num-start_task_num+1;
for ii=1:nn
    task_num=start_task_num+ii-1;
    folderlist=dir(['*r',num2str(task_num)]);
    foldername=folderlist.name;
    disp(foldername)
    
    
    walltime='12:00:00'; %Wall clock time
    codename='7';
    
    
    
    %Global Calculation parameters
    
    odfis=2000;% Output data frequency in steps
    misfve=12000;% Maximum iteration step for velocity equation
    misfppe=10000;% Maximum iteration step for Pressure Possion equation
    NITRB= '350';       % MAXIMUM ITERATION STEP FOR MESH UPDATE EUQATION
    AERB = '1.D-15';      % ALLOW ERROR FOR SOLVING THE MESH UPDATE EQUATION
    % NITRB= '350'; By convention
    % AERB = '1.D-15'; By convention
    %mkdir (foldername)
    cd (foldername)
    mkdir('00')
    rmdir('0*','s');
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
    str(str=='d')=' ';
    str(str=='e')=' ';
    gam=str2num(str);
    
    
    %% INPUT PARAMETERs 1
    g=gam(1);%G/D
    a1=gam(2);%A1
    m=gam(3);%m*
    damp=gam(4);%damp ratio
    re=gam(5); %Renolds Number
    ftspara=0.00025;%normally 0.00025 for interaction of two cylinders
    
    
    
    
    
    taskstr=['r',num2str(gam(end))]        ;%task number
    %% Adjust Title Format
    gstr=num2str(g,'%.2f');%    ,'%.3f'
    a1str=num2str(a1,'%.3f');%  ,'%.3f'
    mstr=num2str(m);%,'%.1f'
    dampstr=num2str(damp,'%.3f');
    restr=num2str(re,'%.1f');
    
    protodir=['/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/VIV/Chosen_mesh_19_Dec/g',num2str(g,'%.1f')];
    
    
    %% =============================FOLDERs====================== f1s to be run
    
    %---
    i=0;
    j=0;
    s=0;
    clear txt
    %% j=if1
    for j=if1
        %for j=[0.81:0.01:0.99]
        %if j==0.85||j==0.90||j==0.95
        %continue
        %end
        name=['0',num2str(j,'%05.3f'),''];
        mkdir(name)
        %end
        s=s+1;
        txt{s}=['cd ./',name,'; qsub slurm_submit.txt; cd ../'];
    end
    %% write suball.com file
    fid = fopen(['./suball.com'], 'w');
    for ii = 1:length(txt)
        fprintf(fid,'%s\n', txt{ii});
    end
    disp('folder created')
    %%
    
    
    
    %% =============================COPY1======================
    
    if copyall_or_not
        
        disp('copying from proto...')
        
        origindir=pwd;
        
        cd (protodir)
        list1=dir('*.TXT');
        n1=length(list1);
        
        cd (origindir)
        list0=dir('0*');
        n0=length(list0);
        
        %%
        %n0=3;%for test
        %%
        for j=1:n0
            for i=1:n1
                origin=[protodir,'/',list1(i).name];
                destin=['./',list0(j).name];
                copyfile(origin,destin)
            end
        end
        disp('copy done')
        
        
        
        %% =============================COPY2======================
        
        
        
        %%
        %n0=3;%for test
        %%
        %     for j=1:n0
        %         for i=1:n1
        %             origin=['./proto/',list1(i).name];
        %             destin=['./',list0(j).name];
        %             copyfile(origin,destin)
        %         end
        %     end
        %     disp('copy done')
        
        %% ===========================
    end % end of copy
    
    %% =============================EDIT======================
    %clear all
    %close all
    
    list0=dir('0*');
    n0=length(list0);
    
    %n0=3;%test f=0.05
    
    
    
    %%
    disp(['alter value for ','G/D=',gstr,', A1=',a1str,', m*=',mstr,' damp=',dampstr,' re=',restr])
    
    for j=1:n0
        %% Calculated INPUT PARAMETERs
        %disp(['alter value for ','G/D=',num2str(g),', A1=',num2str(a1),', m*=',num2str(m), ...,
        %    ' f1=',list0(j).name])
        f1=str2num(list0(j).name);
        visc=2*3.14159265*f1*a1/re; %viscosity
        fts=ftspara/(2*3.14159265*a1*f1); %flow time step
        
        tts=floor(ttperiods/f1/fts);% total time step
        
        
        f1str=list0(j).name;
        taskname=['f',f1str,taskstr];
        %taskdirdarwin=['cd /home/zl352/VIVHPC/','g',gstr,'a',a1str,'m',mstr,'zl_',taskstr,'_code',codename,'/',list0(j).name];
        %taskdirorange=['cd /projects/y73/dongfang/','g',gstr,'a',a1str,'m',mstr,'zl_',taskstr,'_code',codename,'/',list0(j).name];
        %taskdirdarwin=['cd ~/scratch/','g',gstr,'a',a1str,'m',mstr,'zl_',taskstr,'/',list0(j).name];
        taskdirdarwin='cd $workdir';
        taskdirorange=['Not in use: cd /projects/y73/dongfang/','g',gstr,'a',a1str,'m',mstr,'zl_',taskstr,'/',list0(j).name];
        %%   Reading and edit txt
        %
        origindir=pwd;
        cd (protodir)
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
        txtv{11} = [dampstr,'   -> damping factor of cylinder 2'];
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
        txtc{14} = [NITRB,'         --> MAXIMUM ITERATION STEP FOR MESH UPDATE EUQATION '];
        txtc{15} = [AERB,'         --> ALLOW ERROR FOR SOLVING THE MESH UPDATE EQUATION'];
        
        %% SLURM
        fid = fopen('slurm_submit.txt','r');
        i = 1;
        tline = fgetl(fid);
        txts{i} = tline;
        while ischar(tline)
            i = i+1;
            tline = fgetl(fid);
            txts{i} = tline;
        end
        fclose(fid);
        
        % Change cell
        
        txts{13} = ['#SBATCH -J ',taskname];
        txts{15} = ['#SBATCH -A ',account];
        txts{21} = ['#!SBATCH --mem=200'];
        txts{24} = ['#SBATCH --time=',walltime];
        txts{25} = ['#SBATCH --mail-user=zl352'];
        txts{26} = ['#SBATCH --mail-type=END'];
        %txts{63} = ['application="/home/zl352/VIVHPC/code',codename,'/viv"']; %code dir
        txts{63} = ['application="~/scratch/code',codename,'/viv"']; %code dir
        txts{107} = taskdirdarwin;     %running dir
        %txts{107} = 'cd $workdir';
        
        %% PBS
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
        txtp{7} = taskdirorange;
        txtp{8} = ['/projects/y73/dongfang/code',codename,'/viv > test.e'];
        %%  write txt
        cd (origindir)
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
        
        fid = fopen('slurm_submit.txt', 'w');
        for i = 1:numel(txts)
            if txts{i+1} == -1
                fprintf(fid,'%s', txts{i});
                break
            else
                fprintf(fid,'%s\n', txts{i});
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
    disp('====================================')
    disp(pwd)
    disp(['NOTE! acount: ',account])
    disp(['NOTE! Output step ',num2str(odfis)])
    disp(['NOTE! codename= ',codename])
    disp(['NOTE! flow_time_step_para= ',num2str(ftspara)])
    disp(['NOTE! taskdir_darwin= ',taskdirdarwin])
    %disp(['NOTE! taskdir_orange= ',taskdirorange])
    disp(['NOTE! walltime= ', walltime])
    disp('====================================')
    
    fclose all;
    cd ('../')
end