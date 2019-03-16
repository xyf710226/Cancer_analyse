%Exchange_name=unique(reducedModel.subSystems);
%Exchange_name=Exchange_name(44,1);

%直接导入all_Model和all_model_n即可
%all_Model={blca_Model,coad_Model,lihc_Model,prad_Model,read_Model,thca_Model};
%all_model_n={blca_model_n,coad_model_n,lihc_model_n,prad_model_n,read_model_n,thca_model_n}

Flux_Matrix=zeros(size(reducedModel.rxns,1),6);
Delete_Rxns=reducedModel.rxns(7565:7573);

for j=1:6
    solution=solveLP(all_Model{j});
    [exchangeRxns, flag]=getExchangeRxns(all_Model{j});
    %flag=ismember(all_Model{j}.subSystems,Exchange_name);
    %Ex_compare{j}.cancer=all_Model{j}.rxns(find(flag==1));
    Ex_compare{j}.cancer=setdiff(exchangeRxns,Delete_Rxns);
    [exchangeRxns, flag]=getExchangeRxns(all_model_n{j});
    Ex_compare{j}.normal=setdiff(exchangeRxns,Delete_Rxns);
    %flag=ismember(all_model_n{j}.subSystems,Exchange_name);
    %Ex_compare{j}.normal=all_model_n{j}.rxns(find(flag==1));
end
%以下代码用于将数据提取出来，用R语言画图
%%{ 
blcac=Ex_compare{1}.cancer;
blcan=Ex_compare{1}.normal;
coadc=Ex_compare{2}.cancer;
coadn=Ex_compare{2}.normal;
lihcc=Ex_compare{3}.cancer;
lihcn=Ex_compare{3}.normal;
pradc=Ex_compare{4}.cancer;
pradn=Ex_compare{4}.normal;
readc=Ex_compare{5}.cancer;
readn=Ex_compare{5}.normal;
thcac=Ex_compare{6}.cancer;
thcan=Ex_compare{6}.normal;
%%}
clear Exchange_name j flag
