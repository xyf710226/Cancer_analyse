function [res] = Private_EvalExpEquation (exp, x)
% x can hold 3 values :  -1,0,1 for low, moderate and high respectivaly
    if (~( strcmp (exp , '') ) & ~isempty(exp))
       res = eval(exp);
       
    else
       res = 0;
    end
end

function res = and(a,b)
    res = min(a,b);
end 

function res = or(a,b)
    res = max(a,b);
end

 
        
   