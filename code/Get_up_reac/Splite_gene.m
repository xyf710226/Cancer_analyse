gene=modelConsistent.genes
t=[];
for i=1:size(gene)
    S{i,1} = strsplit(gene{i},'.');
    t=[t;str2num(S{i}{1})];
end
modelConsistent.genes=t;