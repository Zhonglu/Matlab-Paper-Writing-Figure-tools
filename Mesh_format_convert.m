clc
clear all
close all
fclose all;
%cd ('Mesh_convert_test')
writeing_directory='./meshes_validation_results';
fid = fopen('mesh_viv_version1.msh','r');
i = 0;
disp(writeing_directory)
while true
    i = i+1;
    tline = fgetl(fid);
    txt{i} = tline;
    
    tf1 = strcmp(txt{i},'$Nodes');
    if tf1
        Nodes=i;
    end
    
    tf2 = strcmp(txt{i},'$Elements');
    if tf2
        Elements=i;
    end
    
    if ischar(tline)
        txt{i}=str2num(txt{i});
    else
        break
    end
end
fclose(fid);

num_Nodes=txt{Nodes+1};
num_Elements=txt{Elements+1};

%txtout{}


NodesMat=cell(1,num_Nodes);
j=0;%first two lines for preset
for i = (Nodes+2):(Nodes+num_Nodes+1)
    j=j+1;
    NodesMat{j}=txt{i}(2:3);
end

k1=0;k2=0;k3=0;k4=0;
for i = (Elements+2):(Elements+num_Elements+1)
    if txt{i}(4)==2 %1 2 "Cylinder 1"
        k1=k1+1;
        cylinder1{k1}=[2 3 txt{i}(6:7)];
    end
    if txt{i}(4)==3 % 1 3 "Cylinder 2"
        k2=k2+1;
        cylinder2{k2}=[2 3 txt{i}(6:7)];
    end
    if txt{i}(4)==4 % 1 79 "Outer Wall"
        k3=k3+1;
        outerwall{k3}=[2 1 txt{i}(6:7)];
    end
    if txt{i}(4)==1 % 2 1 "Main mesh"
        k4=k4+1;
        if txt{i}(2)==2
            quadcells{k4}=[4 txt{i}(6:8) txt{i}(8)];
        elseif txt{i}(2)==3
            quadcells{k4}=[4 txt{i}(6:9)];
        else
            disp('error:',i)
        end
    end
end



%meshtxt=cell(1,num_Nodes+num_Elements+2);
premeshtxt{1}=[4 2];
premeshtxt{2}=[num_Nodes k4 (k1+k2+k3)];

boundary=[cylinder1 cylinder2 outerwall];
meshtxt=[premeshtxt NodesMat quadcells boundary];

cd (writeing_directory)

fid = fopen('MESH.TXT', 'w');
for i = 1:length(meshtxt)
        fprintf(fid,'%s\n', num2str(meshtxt{i},20));
end
fclose(fid);



%FORCE_PARA.TXT
num=k1+k2;
for i=1:num
    if i<=k1
        forcetxt{i}=[i 1];
    else
        forcetxt{i}=[i 2];
    end
end
numc{1}=num;
forcetxt=[num forcetxt];
fid = fopen('FORCE_PARA.TXT', 'w');
for i = 1:length(forcetxt)
        fprintf(fid,'%s\n', num2str(forcetxt{i},20));
end
fclose(fid);

fclose all;
disp(['record: Num_Cylinder_Boundary=',num2str(num)])
disp(['record: Num_Nodes=',num2str(num_Nodes)])
disp(['Num_Elements=',num2str(num_Elements)])
