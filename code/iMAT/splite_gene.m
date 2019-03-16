clear S t
gene_name=A.textdata;
t=[];
for i=1:size(gene_name)
    S{i,1} = strsplit(gene_name{i},'.');
    t=[t;S{i}{1}];
end
clear i
