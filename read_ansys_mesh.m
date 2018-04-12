clc
clear all
close all
filelocation='C:/Users/Zhonglu Lin/OneDrive/PhDWorks/VIV/file.msh';
[ msh_file_contents ] = mshread( '' , 1); % load file // show progress

f1 = figure(1); set(f1,'color','w'); axis off; hold on
colors = {'r','g','b','m','y','k','r','g','b','m','y','k','r','g','b','m','y','k','r','g','b','m','y','k','r','g','b','m','y','k','r','g','b','m','y','k','r','g','b','m','y','k'};
fnames = fieldnames(msh_file_contents);
fnames = fnames(~strcmpi(fnames,'vertices')'); lg=1;
for i = 1:numel(fnames)
    if strcmp(msh_file_contents.(fnames{i}).facetype,'wall')
       patch('Faces',msh_file_contents.(fnames{i}).faces,'Vertices',msh_file_contents.vertices,'FaceColor',colors{i},'edgecolor','k'); hold on
       legend_names{lg} = fnames{i}; lg = lg+1;
    end
end
legend(legend_names{:})
view(3); axis equal vis3d tight