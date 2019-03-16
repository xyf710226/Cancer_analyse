function [counts]=Count_cancerM_info(Model)
%统计每个癌症模型的规模
for i=1:17
    x=Model{i};
    counts(i,1)=size(x.rxns,1);
    counts(i,2)=size(x.mets,1);
    counts(i,3)=size(x.genes,1);
end