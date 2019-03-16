function [Ex_name, Ex_count, ret, result]=Exchange_reac(all_Model)

Ex_name=cell(1,17);
Ex_count=zeros(17,1);

for j=1:17
    %通过统计subsystem得到交换反应
    %flag=ismember(all_Model{j}.subSystems,Exchange_name);
    %Ex_name{j}.index=find(flag==1);
    %Ex_name{j}.name=all_Model{j}.rxns(find(flag==1));
    
    %直接通过getExchangeRxns
    [exchangeRxns, flag]=getExchangeRxns(all_Model{j});
    Ex_name{j}.index=flag;
    Ex_name{j}.name=exchangeRxns;
    Ex_name{j}.subSystems=all_Model{j}.subSystems(flag);
    Ex_count(j,1)=size(Ex_name{j}.index,1);
end

%求17种癌症的交集传输反应
ret = Ex_name{1}.name;
count_name=ret;
for k = 2:17
    ret = intersect(ret, Ex_name{k}.name);
    count_name=[count_name;Ex_name{k}.name]
end
result=tabulate(count_name);
%result=result(cell2mat(result(:,2))>15);
%这是因为在excel文件中是使用（)，提前进行转化方便后面映射到excel文件
for i=1:size(result)
    result{i}=strrep(result{i},'[','(');
    result{i}=strrep(result{i},']',')');
end
