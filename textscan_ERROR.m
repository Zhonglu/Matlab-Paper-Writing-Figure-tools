cd ('/Users/zhonglulin/Documents/OneDrive - University Of Cambridge/OneDrive/PhDWorks/VIV/ERROR/')
clear all
fid= fopen('Analytical.DAT','r');
i = 1;
tline = fgetl(fid);
txta{i} = tline;
while ischar(tline)
    i = i+1;
    tline = fgetl(fid);
    txta{i} = tline;
end
fclose(fid);

list=dir('b=*');
for j=1:length(list)
    fid = fopen(list(j).name,'r');
    i = 1;
    tline = fgetl(fid);
    txtv{i} = tline;
    while ischar(tline)
        i = i+1;
        tline = fgetl(fid);
        txtv{i} = tline;
    end
    fclose(fid);
    
    sum=0;n=0;
    for i=4880:4978
        n=n+1;
        val=str2num(txtv{i});
        a1=val(4);
        val=str2num(txta{i-4880+2});
        a2=val(3);
        sum=sum+(a1-a2)^2;
    end
    sample_deviation(j)=sqrt(sum/(n-1));
end
    sample_deviation=sample_deviation'