function [Tspecify_gene_expression]= specify_gene_value(GeneData,model)
%SPECIFY_GENE_VALUE Summary of this function goes here
%   Detailed explanation goes here
    
    specify_gene_num=length(model.genes);
    all_gene_num=length(GeneData.geneName);
%     Ncolumn=size(GeneData.N,2);
    Tcolumn=size(GeneData.T,2);
%     Nspecify_gene_expression=zeros(1,Ncolumn);
    Tspecify_gene_expression=zeros(1,Tcolumn);

    for i=1:specify_gene_num
        flag=0;
		%specify_gene_expression(i,1)=model.genes(i);
        for j=1:all_gene_num

            if strcmpi(model.geneName{i},GeneData.geneName{j}) 
%                 Nspecify_gene_expression(i,:)=GeneData.N(j,:);
                Tspecify_gene_expression(i,:)=GeneData.T(j,:);
                flag=1;
                break;
            end
            if flag==0
%                 Nspecify_gene_expression(i,:)=0;
                Tspecify_gene_expression(i,:)=0;
            end
        end
       % pause;
    end
	%quit force;
end