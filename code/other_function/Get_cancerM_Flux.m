%all_Model={blca_Model,chol_Model,coad_Model,esca_Model,gbm_Model,hnsc_Model,kich_Model,kirc_Model,kirp_Model,lihc_Model,luad_Model,lusc_Model,prad_Model,read_Model,stad_Model,thca_Model,ucec_Model};
function [Flux_Matrix, Flux_Matrix_Cobra, save_index]=Get_cancerM_Flux(param)
%param=1 The function will delete the rxns whose flux equal zero in all cancer
%     =0 not delete
load('J:\My_reserach\Recon3D_experiment\data\Recon3D_301\SubNetworkRecon.mat');
load('J:\My_reserach\Recon3D_experiment\data\CancerModel\Cancer_Model.mat')
addpath('D:\MATLAB\R2014a\toolbox\RAVEN-master\solver');
rmpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\src\reconstruction\refinement');
%这个被我删了
rmpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\binary\glnxa64\bin\minos\solveLP');
%统计所有癌症在biomass最大化下的流量分布
Flux_Matrix=zeros(size(modelConsistent.rxns,1),17);
Flux_Matrix_Cobra=zeros(size(modelConsistent.rxns,1),17);
for j=1:17
    solution=solveLPR(Cancer_Model{j});
    solution_Cobra = optimizeCbModel(Cancer_Model{j}, 'max');
    [tf index]=ismember(Cancer_Model{j}.rxns,modelConsistent.rxns);
    %index=find(ismember(reducedModel.rxns,all_Model{j}.rxns));
    %%{
    for i=1:size(solution.x,1)
        t=solution.x(i,1);
        
        
        if(t<=1 & t>=-1)
            solution.x(i,1)=0;
        elseif(t>1)
            solution.x(i,1)=log10(t);
        else
            solution.x(i,1)=-log10(-t);
        end
        
        
    end
    
    for i=1:size(solution_Cobra.x,1)
        t=solution_Cobra.x(i,1);
        if(t<=1 & t>=-1)
            solution_Cobra.x(i,1)=0;
        elseif(t>1)
            solution_Cobra.x(i,1)=log10(t);
        else
            solution_Cobra.x(i,1)=-log10(-t);
        end
    end
    %}
    Flux_Matrix_Cobra(index,j)=solution_Cobra.x;
    Flux_Matrix(index,j)=solution.x;
    %以下代码会将全0流量的反应删除，并将最后的流量矩阵写入cancer_flux.txt
    %index=find(strcmp(all_Model.subSystems,'Exchange reactions'));
    %count(id,1)=count(id,1)+1;
end

%以下代码会将全0流量的反应删除，并将最后的流量矩阵写入cancer_flux.txt
%%{
save_index=[];
if param==1
    delete_index=[];
    for i=1:size(modelConsistent.rxns,1)
        index=find(Flux_Matrix(i,:)~=0);
        if(isempty(index))
            delete_index=[delete_index,i];
        else
            save_index=[save_index;i];
        end
    end
    Flux_Matrix(delete_index,:)=[];
    dlmwrite('cancer_flux.txt',Flux_Matrix,' ');
end
%}
rmpath('D:\MATLAB\R2014a\toolbox\RAVEN-master\solver');
addpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\src\reconstruction\refinement');
addpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\binary\glnxa64\bin\minos');
clear i j index index_b t solution