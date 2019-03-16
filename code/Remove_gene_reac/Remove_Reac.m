function [ess_reac_name,result]=Remove_Reac(Model)
%   Remove_Reac
%   ����FBA��ģ�ͽ��з�Ӧ�ó����ó��ó�������biomass=0�ķ�Ӧ��.
%
%   Model           ��Ҫ�����ó���ģ��
%   ess_reac_name   ����Ҫ��ķ�Ӧ��
%
%   �����, 2018-04-12

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