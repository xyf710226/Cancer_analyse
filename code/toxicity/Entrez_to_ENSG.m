[Entrez,ENSG]=Get_genemap();
t=[];
for i=1:size(retGene)
    S{i,1} = strsplit(retGene{i},'.');
    t=[t;str2num(S{i}{1})];
end
[~,loc]=ismember(t,Entrez);
loc(find(loc==0))=[];
delete_gene=ENSG(loc);
