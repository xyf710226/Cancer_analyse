function [ ReaState ] = reaction_grrule( Human_Network,ModelGeneState )

 %[row,column]=size(specify_gene_expression);
 % for i=1:length(Human_Network.rules)
 %   for j=1:column
 %     reaction_rule(i,j) = Private_EvalExpEquation (Human_Network.rules{i},specify_gene_expression(:,j));
 %  end
 % end
   for i=1:length(Human_Network.rules)
       disp(i);
       ReaState(i) = Private_EvalExpEquation (Human_Network.rules{i},ModelGeneState);
   end
end

