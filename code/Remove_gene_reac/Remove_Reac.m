function [ess_reac_name,result]=Remove_Reac(Model)
%   Remove_Reac
%   利用FBA对模型进行反应敲除，得出敲除后满足biomass=0的反应名.
%
%   Model           需要进行敲除的模型
%   ess_reac_name   符合要求的反应名
%
%   熊宇峰, 2018-04-12

%addpath('D:\MATLAB\R2014a\toolbox\RAVEN');
rmpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\src\reconstruction\refinement');
result=zeros(size(Model.rxns,1),1);
for i=1:size(Model.rxns,1)
    Model_reduced=removeReactions(Model,i);
    solution=solveLPR(Model_reduced);
    if(~isempty(solution.f))
        result(i,1)=solution.f;
    else
        result(i,1)=inf;
    end
end
%rmpath('D:\MATLAB\R2014a\toolbox\RAVEN');
addpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\src\reconstruction\refinement');
result=-result;
ess_reac1=find(result<1e-6);
ess_reac_name=Model.rxns(ess_reac1);