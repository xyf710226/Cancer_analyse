function [HighSet,LowSet]=ALL_work(file_name)
%[HighSet,LowSet]=ALL_work('J:\TCGA-FPKM\gbm_fpkm\gbm.xlsx')
[A]=read_matrix(file_name);
[Entrez,ENSG]=Get_genemap();
gene_name=A.textdata;
splite_gene=[];
for i=1:size(gene_name)
    S{i,1} = strsplit(gene_name{i},'.');
    splite_gene=[splite_gene;S{i}{1}];
end
clear S
[~,loc]=ismember(splite_gene,ENSG);
%gene_loc是60483个基因中也在模型中存在的基因的位置,一定更要注意loc和gene_loc的不同
data_loc=find(loc>0);
loc=loc(data_loc);
gene_name=Entrez(loc);
A.data=A.data(data_loc,:);
splite_Mgene=[];
load('J:\My_reserach\Recon3D_experiment\data\Recon3D_301\SubNetworkRecon.mat');
for i=1:size(modelConsistent.genes)
    S = strsplit(modelConsistent.genes{i},'.');
    splite_Mgene=[splite_Mgene;S(1,1)];
end
clear S
splite_Mgene=str2num(char(splite_Mgene));
%[~,Mloc]=ismember(gene_name,splite_Mgene);
%gene_Mloc=find(Mloc>0);
%data_loc=data_loc(Mloc);

specify_gene_expression=[];
for i=1:size(modelConsistent.genes)
    [~,loc]=ismember(splite_Mgene(i),gene_name);
    
    if loc
        specify_gene_expression=[specify_gene_expression;A.data(loc,:)];
    else 
        specify_gene_expression=[specify_gene_expression;zeros(1,size(A.data,2))];
    end
        
end


%loc是对应的表中的位置
%specify_gene_expression=A.data(gene_loc);
[ SampleGeneState ] = GeneState( specify_gene_expression );
[ ModelGeneState ] = GeneStateThreshold( SampleGeneState  );



[ ReaState ] = reaction_grrule( modelConsistent,ModelGeneState );
HighSet=find(ReaState>0);
LowSet=find(ReaState<0);
%[React_High,React_Low] = ReactionFVA(HighSet,LowSet,modelConsistent,1000);
%[High,Low,con3] = confid(React_High,React_Low);
clear ENSG Entrez i splite_gene k ans data_loc 