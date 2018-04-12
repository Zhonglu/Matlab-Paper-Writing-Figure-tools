clear all

vnum=[110:114];
vt=[4];
    for j=vnum
        for i=vt
            origin=['./v103t1'];
            destin=['./v',num2str(j),'t',num2str(i)];
            mkdir(destin)
            copyfile(origin,destin)
        end
    end
    disp('copy done')
    
%     for j=103:108
%         mkdir(['meshes/',num2str(j)])
%     end
    
    for j=vnum
        for i=vt
            origin=['meshes/',num2str(j),'/*'];
            destin=['./v',num2str(j),'t',num2str(i),'/'];
            copyfile(origin,destin)
        end
    end
    %%
    
        fid = fopen('./v103t1/CALCULATION_PARA.TXT','r');
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
        %txtc{1} = [strrep(sprintf('%d',visc),'e','D'),'       --> viscosity'];

        %txtc{5} = [num2str(odfis),'         --> Output data frequency in steps'];
        %txtc{7} = [num2str(misfve),'         --> Maximum iteration step for velocity equation'];
        %txtc{10} = [num2str(misfppe),'         --> Maximum iteration step for Pressure Possion equation'];
        %txtc{14} = [NITRB,'         --> MAXIMUM ITERATION STEP FOR MESH UPDATE EUQATION '];
        %txtc{15} = [AERB,'         --> ALLOW ERROR FOR SOLVING THE MESH UPDATE EQUATION'];
        fts=0.003858302;
        for j=vnum
            for i=vt
                origin=['./v103t1'];
                destin=['./v',num2str(j),'t',num2str(i)];
                ftsdiv=fts/(2*i);
                txtc{2} = [strrep(sprintf('%d',ftsdiv),'e','D'),'       --> FLOW TIME STEP'];
                tts=floor(1/0.825*40/ftsdiv);
                txtc{4} = [num2str(tts),'         --> Total time steps'];
                
                fid = fopen([destin,'/CALCULATION_PARA.TXT'], 'w');                
                for ii = 1:numel(txtc)
                    if txtc{ii+1} == -1
                        fprintf(fid,'%s', txtc{ii});
                        break
                    else
                        fprintf(fid,'%s\n', txtc{ii});
                    end
                end
            end
        end

        
        
    %%
i=0;
j=0;
s=0;

clear txtv

for j=vnum
    for i=vt       
        fname=['v',num2str(j),'t',num2str(i)];
        s=s+1;
        txtv{s}=['cd ./',fname,'; qsub slurm_submit.txt; cd ../'];
    end
end

current_time = datestr(datetime('today'));

fid = fopen(['mv_suball_slurm_',current_time,'.com'], 'w');
for i = 1:numel(txtv)
        fprintf(fid,'%s\n', txtv{i});
end