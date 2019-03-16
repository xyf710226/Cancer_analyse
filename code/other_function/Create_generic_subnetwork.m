%删除模型中的Xeno，Transport of Xenobiotic，Drug metabolism，HMR这四类反应，因为这些反应会影响我们对网络的重构

solverName = 'gurobi';

changeCobraSolver(solverName, 'LP');

global CBTDIR


fileName= 'J:\My_reserach\Recon3D_experiment\data\Recon3D_301\Recon3DModel_301.mat'; % if using Recon 3 model, amend filename.

model = readCbModel(fileName);

for i=1:size(model.subSystems)
    model.subSystems{i}=char(model.subSystems{i});
end

model.csense(1:size(model.S,1),1) = 'E';
model.lb(find(ismember(model.rxns, 'biomass_reaction'))) = 0;
model.lb(find(ismember(model.rxns, 'biomass_maintenance_noTrTr'))) = 0;
model.lb(find(ismember(model.rxns, 'biomass_maintenance'))) = 0;
DMs = (strmatch('DM_', model.rxns));
model.lb(DMs) = 0;
Sinks = (strmatch('sink_', model.rxns));
model.lb(Sinks) = 0;
model.ub(Sinks) = 1000;
[Table_csourcesOri, TestedRxnsC, Perc] = testATPYieldFromCsources(model);


if ~isempty(strfind(fileName, 'Recon3'))
    [TestSolutionOri,TestSolutionNameClosedSinks, TestedRxnsClosedSinks, PercClosedSinks] = test4HumanFctExt(model, 'all', 0);
    TestedRxns = unique([TestedRxnsC; TestedRxnsClosedSinks]);
    TestedRxnsX = intersect(model.rxns,TestedRxns);
end
%%{
if ~isempty(strfind(fileName, 'Recon3'))
    HMR = model.rxns(strmatch('HMR_',model.rxns));
    HMR_NE = setdiff(HMR,TestedRxnsX);
    model.lb(find(ismember(model.rxns,HMR_NE))) = 0;
    model.ub(find(ismember(model.rxns,HMR_NE))) = 0;
end
%}
if ~isempty(strfind(fileName, 'Recon3'))
    DM = model.rxns(strmatch('Xeno', model.subSystems));
    model.lb(find(ismember(model.rxns, DM))) = 0;
    model.ub(find(ismember(model.rxns, DM))) = 0;
    DMt = (strmatch('Transport of Xenobiotic', model.rxnNames));
    model.lb(DMt) = 0;
    model.ub(DMt) = 0;
end

if ~isempty(strfind(fileName, 'Recon3'))
    DDM = model.rxns(strmatch('Drug metabolism', model.subSystems));
    model.lb(find(ismember(model.rxns, DDM))) = 0;
    model.ub(find(ismember(model.rxns, DDM))) = 0;
end

if ~isempty(strfind(fileName, 'Recon3'))
    DM = model.rxns(strmatch('Peptide metabolism',model.subSystems));
    model.lb(find(ismember(model.rxns, DM))) = 0;
    model.ub(find(ismember(model.rxns, DM))) = 0;
end

param.epsilon = 1e-4;
param.modeFlag = 0;
param.method = 'fastcc'; %'null_fastcc'
printLevel = 2;
[fluxConsistentMetBool, fluxConsistentRxnBool, fluxInConsistentMetBool, fluxInConsistentRxnBool, modelOut] = findFluxConsistentSubset(model, param, printLevel);

modelConsistent = removeRxns(model,model.rxns(find(fluxInConsistentRxnBool)));
modelConsistent.genes = [];
modelConsistent.rxnGeneMat = [];
modelgrRule = modelConsistent.grRules;

for i = 1 : length(modelgrRule)
    if ~isempty(modelgrRule{i})
        modelConsistent = changeGeneAssociation(modelConsistent, modelConsistent.rxns{i}, modelgrRule{i});
    end
end

%save('SubNetworkRecon.mat', 'modelConsistent')
[nMet,nRxn] = size(model.S);

fprintf('%6s\t%6s\n','#mets','#rxns'); fprintf('%6u\t%6u\t%s%s\n',nMet,nRxn,' total in Recon')
[nMet,nRxn] = size(modelConsistent.S);

fprintf('%6s\t%6s\n','#mets','#rxns'); fprintf('%6u\t%6u\t%s%s\n',nMet,nRxn,' total in Recon subnetwork')
%{
将subSystem的cell转换成str
for i=1:size(model.subSystems)
    model.subSystems{i}=char(model.subSystems{i});
end
%}
%子类统计
%t_info=tabulate(model.subSystems);
