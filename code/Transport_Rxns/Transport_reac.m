function [Trans_name,Trans_count,Trans_type, ret, Tinfo]=Transport_reac(all_Model)
%目前返回的是超过16个癌症都包括的传输反应
Trans_name=cell(1,17);
Trans_count=zeros(17,1);

for j=1:17
    %这里的getTransportRxns是经过修改的反应
    [transportRxns]=getTransportRxns(all_Model{j});
    Trans_name{j}=all_Model{j}.rxns(transportRxns);
    Trans_type{j}=all_Model{j}.subSystems(transportRxns);
    Trans_count(j,1)=size(Trans_name{j},1);
end

%求17种癌症的交集传输反应
ret = Trans_name{1};
all_Trans=Trans_name{1};
for k = 2:17
    ret = intersect(ret, Trans_name{k});
    all_Trans=[all_Trans;Trans_name{k}];
end

Tinfo=tabulate(all_Trans);
%通过修改这里修改得到的trans_port_rxns
Tinfo=Tinfo(cell2mat(Tinfo(:,2))>15);
ret=Tinfo;
clear j flag k
