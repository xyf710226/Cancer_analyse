function [A]=read_matrix(file_name)
%读取文件，将正常样本剔除
A = importdata(file_name);
k=A.textdata;
Sample_name=k(1,:);
Sample_name(:,1)=[];
flag=[];
for i=1:size(Sample_name,2)
    str=strsplit(Sample_name{i},'-');
    TN=str{4}(1:2);
    if strcmp(TN,'01')
        flag=[flag,i];
    end
end
k=k(:,1);
k(1,:)=[];
A.textdata=k;
A.data=A.data(:,flag);
