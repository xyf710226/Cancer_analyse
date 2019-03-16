function [Cancer_Model]=reconstruction(Rxns_up)
%重构所有的癌症网络
load('J:\My_reserach\Recon3D_experiment\data\Recon3D_301\SubNetworkRecon.mat');
solverOK = changeCobraSolver('ibm_cplex', 'LP', 0);
addpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\src\reconstruction\refinement');
Cancer_Model=cell(17,1);
for i=1:17
    %Cancer_Model{i}=fastcore(Recon3DModel,Rxns_up{i},1e-4,0);
    Cancer_Model{i}=fastcore(modelConsistent,Rxns_up{i},1e-4,0);
    [~,loc]=ismember(Cancer_Model{i}.rxns,'biomass_reaction');
    Cancer_Model{i}.c(find(loc>0))=1;
end