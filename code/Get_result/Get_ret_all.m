function [ret_all,data_all]=Get_ret_all(data)
data=data'; %����װ������
data_all=[];
ret_all=[];
for i=1:size(data)
    data_all=[data_all;data{i}];
end
for i=1:size(data_all)
    data_all{i}=strrep(data_all{i},'[','(');
    data_all{i}=strrep(data_all{i},']',')');
end
ret_all=tabulate(data_all);

%flag=cell2mat(ret_all(:,2))>9; ��python��ʵ����
%ret=ret_all(flag);