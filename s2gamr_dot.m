function gamr=s2gamr(str)

str(str=='r')=[' '];
str(str=='u')=[];
str(str=='n')=[];
str(str=='_')=[];
str(str=='z')=[];
str(str=='l')=[' '];
%str1=str;
str(str=='g')=' ';
str(str=='a')=' ';
str(str=='m')=' ';
str(str=='d')=' ';
str(str=='e')=' ';
str(str=='R')=' ';
str(str=='.')=' ';
str(str=='d')=' ';
str(str=='a')=' ';
str(str=='t')=' ';
gamr=str2num(str);