%运行此程序前，请先运行Transport_reac,生成交换反应的共性反应ret
load('J:\My_reserach\Recon3D_experiment\data\Recon3D_301\SubNetworkRecon.mat')
[tf locret] = ismember(ret,modelConsistent.rxns) 
 %trans_subSystems=reducedModel.subSystems(ismember(reducedModel.rxns,ret));
 Trans_ret_subSystems=modelConsistent.subSystems(locret);
 t_info=tabulate(Trans_ret_subSystems(:));
addpath('D:\MATLAB\R2014a\toolbox\RAVEN-master\solver');
rmpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\src\reconstruction\refinement');
%统计所有癌症在biomass最大化下的流量分布
%Flux_Matrix=zeros(size(reducedModel.rxns,1),17);
%{
for j=1:17
    solution=solveLP(all_Model{j});
    [tf index]=ismember(all_Model{j}.rxns,reducedModel.rxns);
    %index=find(ismember(reducedModel.rxns,all_Model{j}.rxns));
    %{
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
    %}
    Flux_Matrix(index,j)=solution.x;
    %以下代码会将全0流量的反应删除，并将最后的流量矩阵写入cancer_flux.txt
    %index=find(strcmp(all_Model.subSystems,'Exchange reactions'));
    %count(id,1)=count(id,1)+1;
end
%只用一部分传输反应分析可用这
%}
Transport_ret_Flux=Flux_Matrix_Cobra(locret,:);

dlmwrite('Transport_ret_flux.txt',Transport_ret_Flux,' ');

%以下代码会将全0流量的反应删除，并将最后的流量矩阵写入cancer_flux.txt
%{
delete_index=[];
save_index=[];
for i=1:size(Flux_Matrix,1)
    index=find(Flux_Matrix(i,:)~=0);
%    if(isempty(index))
    if(size(index,2)<9)
        delete_index=[delete_index,i];
    else
        save_index=[save_index;i];
    end
end
Flux_Matrix(delete_index,:)=[];
dlmwrite('transport_flux.txt',Flux_Matrix,' ');
%}
%dlmwrite('transport1_flux.txt',Flux_Matrix,' ');
rmpath('D:\MATLAB\R2014a\toolbox\RAVEN-master\solver');
addpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\src\reconstruction\refinement');
clear i j index index_b t
%反应物
S_index=modelConsistent.S(:,locret)
[x1,y1]=find(S_index>0);
retMet=modelConsistent.mets(x1);
retMetName=modelConsistent.metNames(x1);