%Add_points_makeinput_v11_auto_copyall_SBATCH_remesh_input_mass_ratio.m
%clc
clear all
close all
fclose all;

%cd ('C:\running_tasks\')
%folderlist=dir('*r83');

ristart=197;%144;
ri=ristart-1;
s=0;

gmf=[
0.2	1.5	0.72500
0.2	1.5	0.73750
0.2	2.0	0.77500
0.2	2.0	0.78750
0.2	2.0	0.76250
0.2	2.5	0.80625
0.2	2.5	0.81250
0.2	2.5	0.81875
0.2	2.5	0.83750
0.3	1.5	0.72500
0.3	1.5	0.74000
0.3	1.5	0.76000
0.3	2.0	0.77500
0.3	2.0	0.79000
0.3	2.5	0.77500
0.3	2.5	0.79000
0.3	2.5	0.83750
0.4	1.5	0.72500
0.4	1.5	0.74500
0.4	1.5	0.75500
0.4	2.0	0.77500
0.4	2.0	0.80500
0.4	2.0	0.78500
];

for i3=1:size(gmf,1)
    for ai=[0.025 0.050 0.075 0.100]
            ri=ri+1;
            temp1=['g',num2str(gmf(i3,1),'%.1f'),'a',num2str(ai,'%.3f'), ...
                'm',num2str(gmf(i3,2),'%.1f'),'f',num2str(gmf(i3,3),'%.6f'),'r',num2str(ri)];
            mkdir(temp1)
            disp(temp1)

            
            s=s+1;
            txt{s}=['cd ./*r',num2str(ri),'; qsub slurm_submit.txt ; cd ../'];

        
    end
end


%% write submit.com file
fid = fopen(['./',num2str(ristart),'_to_',num2str(ri),'_subauto_hpc'], 'w');                
for ii = 1:length(txt)
        fprintf(fid,'%s\n', txt{ii});
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
    
    account='SOGA';% zl352
    %account='LIANG-SL3';%dl359 xz328
    walltime='12:00:00'; %Wall clock time
    codename='7';

    copyall_or_not=1;
    
    %Global Calculation parameters
    ttperiods=120;
    odfis=1000;% Output data frequency in steps
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
    str(str=='m')=' ';str(str=='f')=' ';
    gam=str2num(str);


    %% INPUT PARAMETERs 1
    g=gam(1);%G/D
    a1=gam(2);%A1
    m=gam(3);%m*
    f1=gam(4);
    taskstr=['r',num2str(gam(5))];%task number   
    
    re=100;  %Renolds Number
    ftspara=0.00025;%
    
    

    

         
    %% Adjust Title Format
    gstr=num2str(g,'%.2f');%    ,'%.3f'
    a1str=num2str(a1,'%.3f');%  ,'%.3f'
    mstr=num2str(m);%,'%.1f'
    f1str=num2str(f1);
    
    protodir=['/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/VIV/Chosen_mesh_19_Dec/g',num2str(g,'%.1f')];
    
    
    %% =============================FOLDERs======================

    %%



    %% =============================COPY1======================

    if copyall_or_not

    disp('copying from proto...')
    
    destidir=pwd;
    
    cd (protodir)
    list1=dir('*.TXT');
    n1=length(list1);

    cd (destidir)
%     list0=dir('0*');
%     n0=length(list0);

    %%

    %%
    
    for i=1:n1
        origin=[protodir,'/',list1(i).name];
        destin=['./'];
        copyfile(origin,destin)
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

    %list0=dir('0*');
    %n0=length(list0);

    %n0=3;%test f=0.05



    %%
    disp(['alter value for ','G/D=',gstr,', A1=',a1str,', m*=',mstr])
    
        %% Calculated INPUT PARAMETERs
        %disp(['alter value for ','G/D=',num2str(g),', A1=',num2str(a1),', m*=',num2str(m), ...,
        %    ' f1=',list0(j).name])
        %f1=str2num(list0(j).name);
        visc=2*3.14159265*f1*a1/re; %viscosity
        fts=ftspara/(2*3.14159265*a1*f1); %flow time step
    
        tts=ttperiods/f1/fts;% total time step

        
        %f1str=list0(j).name;
        taskname=['Z',f1str,taskstr];
        %taskdirdarwin=['cd /home/zl352/VIVHPC/','g',gstr,'a',a1str,'m',mstr,'zl_',taskstr,'_code',codename,'/',list0(j).name];
        %taskdirorange=['cd /projects/y73/dongfang/','g',gstr,'a',a1str,'m',mstr,'zl_',taskstr,'_code',codename,'/',list0(j).name];
        %taskdirdarwin=['cd ~/scratch/','g',gstr,'a',a1str,'m',mstr,'zl_',taskstr,'/',list0(j).name];
        taskdirdarwin='cd $workdir';
        %taskdirorange=['cd /projects/y73/dongfang/','g',gstr,'a',a1str,'m',mstr,'zl_',taskstr,'/',list0(j).name];
    %%   Reading and edit txt
        %
        destidir=pwd;
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
        txts{26} = ['#SBATCH --mail-type=ALL'];
        %txts{63} = ['application="/home/zl352/VIVHPC/code',codename,'/viv"']; %code dir
        txts{63} = ['application="~/scratch/code',codename,'/viv"']; %code dir
        txts{107} = taskdirdarwin;     %running dir 
        %txts{107} = 'cd $workdir';

       %% PBS
%         fid = fopen('pbs.sh','r');
%         i = 1;
%         tline = fgetl(fid);
%         txtp{i} = tline;
%         while ischar(tline)
%             i = i+1;
%             tline = fgetl(fid);
%             txtp{i} = tline;
%         end
%         fclose(fid);
% 
%         % Change cell
%         txtp{3} = ['#PBS -l walltime=',walltime];
%         txtp{6} = ['#PBS -N ',taskname];
%         txtp{7} = taskdirorange;
%         txtp{8} = ['/projects/y73/dongfang/code',codename,'/viv > test.e'];
    %%  write txt
        cd (destidir)
        %cd (list0(j).name)
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

%         fid = fopen('pbs.sh', 'w');
%         for i = 1:numel(txtp)
%             if txtp{i+1} == -1
%                 fprintf(fid,'%s', txtp{i});
%                 break
%             else
%                 fprintf(fid,'%s\n', txtp{i});
%             end
%         end
    %%
       fclose(fid);
       cd ('../')
    
    disp(['NOTE! codename= ',codename])
    disp(['NOTE! flow_time_step_para= ',num2str(ftspara)])
    disp(['NOTE! taskdir_darwin= ',taskdirdarwin])
%    disp(['NOTE! taskdir_orange= ',taskdirorange])
    disp(['NOTE! walltime= ', walltime])
    disp('====================================')
    
    fclose all;
    %cd ('../')
end