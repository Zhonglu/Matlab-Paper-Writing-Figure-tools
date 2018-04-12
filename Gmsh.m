clc
clear all
close all

%prefix='G0.5mesh';
gmsh_to_fem 'G0.5mesh'





% 
% clc
% clear all
% close all
% filename='G3.0_nastran.geo';
% fid = fopen(filename);
% i = 1;
% tline = fgetl(fid);
% txt{i} = tline;
% while ischar(tline)
%     i = i+1;
%     tline = fgetl(fid);
%     txt{i} = tline;
% end
% fclose(fid);
% 
% for i=12:21
%     str=txt{i}(11:end);
%     str(or((str=='{'),(str=='}')))=[];
%     num{i}=str2num(str);
%     num{i}(2)
% end

% Change cell 
% txt{3} = strrep(sprintf('%d',a1),'e','D');
% txt{4} = strrep(sprintf('%d',f1),'e','D');
% txt{9} = mstr;
% 