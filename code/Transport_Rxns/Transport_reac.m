function [Trans_name,Trans_count,Trans_type, ret, Tinfo]=Transport_reac(all_Model)
%Ŀǰ���ص��ǳ���16����֢�������Ĵ��䷴Ӧ
Trans_name=cell(1,17);
Trans_count=zeros(17,1);

for j=1:17
    %�����getTransportRxns�Ǿ����޸ĵķ�Ӧ
    [transportRxns]=getTransportRxns(all_Model{j});
    Trans_name{j}=all_Model{j}.rxns(transportRxns);
    Trans_type{j}=all_Model{j}.subSystems(transportRxns);
    Trans_count(j,1)=size(Trans_name{j},1);
end

%��17�ְ�֢�Ľ������䷴Ӧ
ret = Trans_name{1};
all_Trans=Trans_name{1};
for k = 2:17
    ret = intersect(ret, Trans_name{k});
    all_Trans=[all_Trans;Trans_name{k}];
end

Tinfo=tabulate(all_Trans);
%ͨ���޸������޸ĵõ���trans_port_rxns
Tinfo=Tinfo(cell2mat(Tinfo(:,2))>15);
ret=Tinfo;
clear j flag k
