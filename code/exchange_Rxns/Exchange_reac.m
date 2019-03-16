function [Ex_name, Ex_count, ret, result]=Exchange_reac(all_Model)

Ex_name=cell(1,17);
Ex_count=zeros(17,1);

for j=1:17
    %ͨ��ͳ��subsystem�õ�������Ӧ
    %flag=ismember(all_Model{j}.subSystems,Exchange_name);
    %Ex_name{j}.index=find(flag==1);
    %Ex_name{j}.name=all_Model{j}.rxns(find(flag==1));
    
    %ֱ��ͨ��getExchangeRxns
    [exchangeRxns, flag]=getExchangeRxns(all_Model{j});
    Ex_name{j}.index=flag;
    Ex_name{j}.name=exchangeRxns;
    Ex_name{j}.subSystems=all_Model{j}.subSystems(flag);
    Ex_count(j,1)=size(Ex_name{j}.index,1);
end

%��17�ְ�֢�Ľ������䷴Ӧ
ret = Ex_name{1}.name;
count_name=ret;
for k = 2:17
    ret = intersect(ret, Ex_name{k}.name);
    count_name=[count_name;Ex_name{k}.name]
end
result=tabulate(count_name);
%result=result(cell2mat(result(:,2))>15);
%������Ϊ��excel�ļ�����ʹ�ã�)����ǰ����ת���������ӳ�䵽excel�ļ�
for i=1:size(result)
    result{i}=strrep(result{i},'[','(');
    result{i}=strrep(result{i},']',')');
end
