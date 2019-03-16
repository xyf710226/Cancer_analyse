function [ess_gene_name,result,Remove_rxns_result]=Remove_Gene(Model)
%   Remove_Gene
%   ����FBA��ģ�ͽ��л����ó����ó��ó�������biomass=0�Ļ�����.
%
%   Model           ��Ҫ�����ó���ģ��
%   ess_gene_name   ����Ҫ��Ļ�����
%
%   �����, 2018-04-12

%addpath('D:\MATLAB\R2014a\toolbox\RAVEN');
rmpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\src\reconstruction\refinement');

result=zeros(size(Model.genes,1),1);
Remove_rxns_result=cell(size(Model.genes,1),1);
%result2=result;
for i=1:size(Model.genes,1)
    Rgene=Model.genes(i,1);
    t=Model;
    remove_reaction=[];
    [Model_reduced,notDeleted,remove_reaction]=removeGenes(Model,Rgene);
    %[model, hasEffect, constrRxnNames, deletedGenes] = deleteModelGenes(t, Rgene);
    %solution_Cobra = optimizeCbModel(Model_reduced, 'max');
    solution=solveLPR(Model_reduced);
%   solution2=solveLPR(model);
    result(i,1)=solution.f;
    Remove_rxns_result{i,1}=remove_reaction;
    %result2(i,1)=solution2.f;
    %result(i,2)=solution_Cobra.obj;
 
end
%rmpath('D:\MATLAB\R2014a\toolbox\RAVEN');
addpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\src\reconstruction\refinement');
result=-result;
ess_gene1=find(result<1e-6);
ess_gene_name=Model.genes(ess_gene1);