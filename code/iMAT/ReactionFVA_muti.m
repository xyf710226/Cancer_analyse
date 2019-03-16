% Do FVA for each reactions: max optimization when set current reaction to be active.
function [React_High,React_Low] = ReactionFVA(HighSet,LowSet,Network,MaxFlux)
	% the flux bounds value
    tic;
	MaxFluxVal = MaxFlux;

	% the threshold value
	SITA = 1;                                                        
	StoichMatrix = Network.S;
	[metaboliteNum,reactionNum] = size(StoichMatrix);
    
    reverse=zeros(reactionNum,1);
    for i=1:reactionNum
        if(Network.lb(i)<0 & Network.ub(i)>0)
            reverse(i,1)=1;
        end
    end
    
	%reverse = Network.rev;

	% low and up bounds, depending on reactions' direction. If reverse = 1, it is a reversable reaction.
	lowBounds = zeros(length(reverse),1);
	upBounds = zeros(length(reverse),1) + MaxFluxVal;
	index = find(reverse == 1);
	lowBounds(index) = -MaxFluxVal;

	%% variables definition
	LowNum = length(LowSet);                       % record the reaction number of each set
	HighNum = length(HighSet);
	inEqualConstraintNum = 2*(HighNum + LowNum);   % total inequal constraints number
	equalConstraintNum = metaboliteNum;
	variableNumer = reactionNum + 2*HighNum + LowNum;                         % total variables number

	%% Set the matrixes used in the problem, using sparse matrix
	Aeq = sparse(equalConstraintNum,variableNumer);
	Beq = zeros(equalConstraintNum,1);
	Aineq = sparse(inEqualConstraintNum,variableNumer);
	Bineq = (zeros(inEqualConstraintNum,1));

	%% S*V = 0 
	for i = 1:metaboliteNum
		for j = 1:reactionNum
			tempValue = full(StoichMatrix(i,j));
			if tempValue ~= 0
				Aeq(i,j) = tempValue;                                    % V[N,i]
			end
		end
	end
	% because it is not used in the following part, clear it to save space.
	clear StoichMatrix;    

	%% HighSet: Constraints
	%   Vi + Yi[+]*(V[min,i] - SITA) >= V[min,i]  ==>  -Vi - Yi[+]*(V[min,i] - SITA) <= -V[min,i]
	constraint_number_now = 0;                     
	for i =1: HighNum
		Aineq(constraint_number_now + i,HighSet(i)) = -1;      % Vi
		Aineq(constraint_number_now + i,reactionNum + (i-1)*2 + 1) = -(lowBounds(HighSet(i)) - SITA);
		Bineq(constraint_number_now + i) = -lowBounds(HighSet(i));
	end
	constraint_number_now = constraint_number_now + HighNum;

	%   equation 4:  Vi + Yi[-]*(V[max,i] + SITA) <= V[max,i] 
	for i =1: HighNum
		Aineq(constraint_number_now + i,HighSet(i)) = 1;      % Vi
		Aineq(constraint_number_now + i,reactionNum + (i-1)*2 + 2) = upBounds(HighSet(i)) + SITA;
		Bineq(constraint_number_now + i) = upBounds(HighSet(i));
	end
	constraint_number_now = constraint_number_now + HighNum;

	%% LowSet: Constraints
	% equation 5.1:   Vi +Yi[+]*V[max,i] <= V[max,i]          
	for i =1: LowNum
		Aineq(constraint_number_now + i,LowSet(i)) = 1;      % Vi
		Aineq(constraint_number_now + i,reactionNum + HighNum*2 + i) = upBounds(LowSet(i));
		Bineq(constraint_number_now + i) = upBounds(LowSet(i));
	end
	constraint_number_now = constraint_number_now + LowNum;

	% equation 5.2:   Vi +Yi[+]*V[min,i] >= V[min,i]   ==>    -(Vi +Yi[+]*V[min,i]) <= -V[min,i]
	for i =1: LowNum
		Aineq(constraint_number_now + i,LowSet(i)) = -1;      % Vi
		Aineq(constraint_number_now + i,reactionNum + HighNum*2 + i) = -lowBounds(LowSet(i));
		Bineq(constraint_number_now + i) = -lowBounds(LowSet(i));
	end
	constraint_number_now = constraint_number_now + LowNum;


	%% set the cofficients of the objective function. 
	f = zeros(variableNumer,1); 
	for i = reactionNum + 1: variableNumer
		f(i,1) = -1;
	end

	%% set types of variables
	ctype = '';
	for i = 1:reactionNum
		ctype = strcat(ctype,'C');
	end
	for i = 1 + reactionNum:variableNumer
		ctype = strcat(ctype,'I');
	end

	%% set the upper&lower bounds of all the variables
	ub = zeros(variableNumer,1);
	lb = zeros(variableNumer,1);
	for i = 1: reactionNum        % set the bounds of flux of reactions
		ub(i) = upBounds(i);
		lb(i) = lowBounds(i);
	end
	for i = reactionNum + 1: variableNumer   % set the bounds of the integer variables
		ub(i) = 1;
		lb(i) = 0;
	end

	%% Solve problem
	options = cplexoptimset;
	options.Diagnostics = 'on';
	options.BranchStrategy = 3;
	options.NodeSearchStrategy = 2;
	options.MaxTime = 200;
    options.Display='off';

	% Find first best opt value.
	[xo,fval,exitFlag,outPut] = cplexmilp(f,Aineq,Bineq,Aeq,Beq,[],[],[],lb,ub,ctype,[],options);
	
	%% save previous matrixes
	preAeq = Aeq;
	preBeq = Beq;
	preAineq = Aineq;
	preBineq = Bineq;
	preLB = lb;
	preUB = ub;
	preCtype = ctype;
	preF = f;
	preXO = xo;
	
	%% variables 
	%React_High.objective = zeros(reactionNum,1);  
	%React_High.exitFlag = zeros(reactionNum,1);
	%React_High.outPut = cell(reactionNum,1);
    Robjective = zeros(reactionNum,1);  
	RexitFlag = zeros(reactionNum,1);
	RoutPut = cell(reactionNum,1);

	%for i=2601:5317 %for i = 1:reactionNum
    %for i = 1:reactionNum
    beginNum=1;
    endNum=500;
    %parfor i=1:reactionNum
    for i=beginNum:endNum
		% reset the matrixes
        fprintf('Hbegin: %d\n', i)
		Aeq = preAeq;
		Beq = preBeq;
		Aineq = preAineq;
		Bineq = preBineq;      
		lb = preLB;
		ub = preUB;
		ctype = preCtype;
		f = preF;	
		xo = preXO;
		
		temp = find(HighSet == i);	
		if ~isempty(temp)
			%% Solve the MILP problem when reaction i belongs to Up-changed Reaction Set
			% Add a constaint as Y[Au,i] + Y[Bu,i] + Y[Cu,i] + Y[Du,i] = 1
			[rowNum,columnNum] = size(Aeq);
			Aeq(1 + rowNum,reactionNum + (temp - 1)*2 +1) = 1; 
			Aeq(1 + rowNum,reactionNum + (temp - 1)*2 +2) = 1; 
			Beq(1 + rowNum,1) = 1;

			[x,fval,exitFlag,outPut] = cplexmilp(f,Aineq,Bineq,Aeq,Beq,[],[],[],lb,ub,ctype,xo,options);
%			RexitFlag(i,1) = exitFlag;
%			RoutPut{i,1} = outPut;
			if exitFlag < 1
				Robjective(i,1) = 0;
			else 
				Robjective(i,1) = fval;
			end        
			%clear Aeq Beq Aineq Bineq ub lb;
			continue;
		end

		%% Solve the MILP problem when reaction i belongs to Down/Const-changed Reaction Set.
		%  Then add several constraints as Up-changed reaction. 
		[rowNum,columnNum] = size(Aineq);	
		 %   Vi + Yi[+]*(V[min,i] - SITA) >= V[min,i]  ==>  -Vi - Yi[+]*(V[min,i] - SITA) <= -V[min,i]            
		Aineq(rowNum + 1,i) = -1;      % Vi
		Aineq(rowNum + 1,columnNum + 1) = -(lowBounds(i) - SITA);
		Bineq(rowNum + 1) = -lowBounds(i);

		%   equation 4:  Vi + Yi[-]*(V[max,i] + SITA) <= V[max,i] 
		Aineq(rowNum + 2,i) = 1;      % Vi
		Aineq(rowNum + 2,columnNum + 2) = upBounds(i) + SITA;
		Bineq(rowNum + 2) = upBounds(i);

		% Add a constaint as Y[Ad,i] + Y[Bd,i] = 1
		[rowNum,columnNum] = size(Aeq);
		Aeq(1 + rowNum,columnNum + 1) = 1;
		Aeq(1 + rowNum,columnNum + 2) = 1;
		Beq(1 + rowNum,1) = 1;
		
		% change the bounds,and the ctype string. Pay attention that reactions in Const-Changed Set do not contribute
		% to the objective value. So, the vector of cofficients of objective function has to be setted carefully. 
		for j = 1:2
			f(columnNum + j,1) = 0;
			lb(columnNum + j) = 0;
			ub(columnNum + j) = 1;
		end
		ctype = strcat(ctype,'II');	
		xo(length(xo) + 2,1) = 0;
		
		temp = find(LowSet == i);		
		if ~isempty(temp)
			% As a Down-changed reaction,it has Y[Ad,i]~Y[Dd,i] variables in the previous problem description. 
			% Add a constaint as Y[Ad,i] + Y[Bd,i] + Y[Cd,i] + Y[Dd,i] = 0
			[rowNum,columnNum] = size(Aeq);
			Aeq(1 + rowNum,reactionNum + 2*HighNum + temp) = 1; 
			Beq(1 + rowNum,1) = 0;
			
			% Solve the problem
			[x,fval,exitFlag,outPut] = cplexmilp(f,Aineq,Bineq,Aeq,Beq,[],[],[],lb,ub,ctype,xo,options);     
%			RexitFlag(i,1) = exitFlag;
%			RoutPut{i,1} = outPut;
			if exitFlag < 1
				Robjective(i,1) = 0;
			else 
				Robjective(i,1) = fval;
			end        
			%clear Aeq Beq Aineq Bineq ub lb;
			continue;
		end
		
		% Solve the problem if the current reaction is Const-changed state.
		[x,fval,exitFlag,outPut] = cplexmilp(f,Aineq,Bineq,Aeq,Beq,[],[],[],lb,ub,ctype,xo,options);		
%		RexitFlag(i,1) = exitFlag;
%		RoutPut{i,1} = outPut;
		if exitFlag < 1
			Robjective(i,1) = 0;
		else 
			Robjective(i,1) = fval;
		end        
		%clear Aeq Beq Aineq Bineq ub lb;
		continue;
        
	end


	%% Variable to store the final result of FVA. Write it to a File each time.
	RLobjective = zeros(reactionNum,1);  
	RLexitFlag = zeros(reactionNum,1);
	RLowoutPut = cell(reactionNum,1);
	%% FVA: each reaction is setted to be Down-changed.
	%for i=2601:5317  %for i = 1:reactionNum
    %for i = 1:reactionNum
    %parfor i=1:reactionNum
    toc
    for i=beginNum:endNum
    %for i = 1:100
		% reset the matrixes
        fprintf('Lbegin: %d\n', i)
		Aeq = preAeq;
		Beq = preBeq;
		Aineq = preAineq;
		Bineq = preBineq;      
		lb = preLB;
		ub = preUB;
		ctype = preCtype;
		f = preF;
		xo = preXO;
		
		temp = find(LowSet == i);	
		if ~isempty(temp)
		   %% Solve the MILP problem when reaction i belongs to Down-changed Reaction Set
			% Add a constaint as Y[Ad,i] + Y[Bd,i] + Y[Cd,i] + Y[Dd,i] = 1
			[rowNum,columnNum] = size(Aeq);
			Aeq(1 + rowNum,reactionNum + 2*HighNum + temp) = 1; 
			Beq(1 + rowNum,1) = 1;
			
			[x,fval,exitFlag,output] = cplexmilp(f,Aineq,Bineq,Aeq,Beq,[],[],[],lb,ub,ctype,xo,options);	
			
			% record the result value and write to a file
%			RLexitFlag(i,1) = exitFlag;
%			RLoutPut{i,1} = outPut;
			if exitFlag < 1
				RLobjective(i,1) = 0;
			else 
				RLobjective(i,1) = fval;
			end        
%			clear Aeq Beq Aineq Bineq ub lb;
			continue;
		end

		%% Solve the MILP problem when reaction i belongs to Up/Const-changed Reaction Set
		[rowNum,columnNum] = size(Aineq);	
		 % equation 5.1:   Vi +Yi[+]*V[max,i] <= V[max,i]        
		Aineq(rowNum + 1,i) = 1;      % Vi
		Aineq(rowNum + 1,columnNum + 1) = upBounds(i);
		Bineq(rowNum + 1) = upBounds(i);

		% equation 5.2:   Vi +Yi[+]*V[min,i] >= V[min,i]   ==>    -(Vi +Yi[+]*V[min,i]) <= -V[min,i]
		Aineq(rowNum + 2,i) = -1;      % Vi
		Aineq(rowNum + 2,columnNum + 1) = -lowBounds(i);
		Bineq(rowNum + 2) = -lowBounds(i);

		% Add a constaint as Y[Ad,i] + Y[Bd,i] + Y[Cd,i] + Y[Dd,i] = 1. Set reaction to be React_Low-state...
		[rowNum,columnNum] = size(Aeq);
		Aeq(1 + rowNum,columnNum + 1) = 1;
		Beq(1 + rowNum,1) = 1;
		
		% change the bounds,and the ctype string
		for j = 1
			f(columnNum + j,1) = 0;
			lb(columnNum + j) = 0;
			ub(columnNum + j) = 1;
		end
		ctype = strcat(ctype,'I');	
		xo(length(xo) + 1,1) = 0;
		
		temp = find(HighSet == i);		
		if ~isempty(temp)
			% As a Up-changed reaction,it has Y[Ad,i]~Y[Dd,i] variables in the previous problem description. 
			% Add a constaint as Y[Ad,i] + Y[Bd,i] + Y[Cd,i] + Y[Dd,i] = 0
			[rowNum,columnNum] = size(Aeq);
			Aeq(1 + rowNum,reactionNum + (temp - 1)*2 +1) = 1; 
			Aeq(1 + rowNum,reactionNum + (temp - 1)*2 +2) = 1; 
			Beq(1 + rowNum,1) = 0;
			
			% Solve the problem
			[x,fval,exitFlag,outPut] = cplexmilp(f,Aineq,Bineq,Aeq,Beq,[],[],[],lb,ub,ctype,xo,options);
			
			% record the result value and write to a file
%			RLexitFlag(i,1) = exitFlag;
%			RLoutPut{i,1} = outPut;
			if exitFlag < 1
				RLobjective(i,1) = 0;
			else 
				RLobjective(i,1) = fval;
			end        
			%clear Aeq Beq Aineq Bineq ub lb;
			continue;
		end
		
		% Solve the problem if the current reaction is Const-changed state.
		[x,fval,exitFlag,outPut] = cplexmilp(f,Aineq,Bineq,Aeq,Beq,[],[],[],lb,ub,ctype,xo,options);		
		
		% record the result value and write to a file
%		RLexitFlag(i,1) = exitFlag;
%		RLoutPut{i,1} = outPut;
		if exitFlag < 1
			RLobjective(i,1) = 0;
		else 
			RLobjective(i,1) = fval;
		end        
		%clear Aeq Beq Aineq Bineq ub lb;
    end
    React_High.objective = Robjective;  
%	React_High.exitFlag = RexitFlag;
%	React_High.outPut = RoutPut;
    React_Low.objective = RLobjective;  
%	React_Low.exitFlag = RLexitFlag;
%	React_Low.outPut = RLoutPut;
    toc