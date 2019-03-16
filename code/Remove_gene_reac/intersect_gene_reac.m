c=ess_gene_name{1};
all_gene=c;
for i=2:size(ess_gene_name)
    c=intersect(ess_gene_name{i},c);
    all_gene=[all_gene;ess_gene_name{i}];
end
t=tabulate(all_gene);
c_16up=t(cell2mat(t(:,2))>10);
clear i Model_gene Model_reac 