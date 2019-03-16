modelConsistent.c = zeros(length(modelConsistent.rxns),1);
modelConsistent = changeObjective(modelConsistent,'biomass_reaction');
modelConsistent.csense(1:size(modelConsistent.S,1),1) = 'E';
FBA1 = optimizeCbModel(modelConsistent,'max','zero');
%solution1=solveLPR(modelConsistent);