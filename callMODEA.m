function bestIndividuals = callMODEA(problem,param)

% Multi-Objective Differential Evolution Algorithm

%% Problem

objFunc = problem.objFunc;
varMin = problem.varMin;
varMax = problem.varMax;
nVar = problem.nVar;
varSize = problem.varSize;

%% Parameters

% Differential Evolution Algorithm:

nIt = param.nIt;
nPop = param.nPop;     
nBest = param.nBest; 

F_min = param.F_min; 
F_max = param.F_max;
F1 = param.F1; 
F2 = param.F2; 
Cr = param.Cr;   
mutation_scheme = param.mutation_scheme;

% Multi-Objective:

nGrid = param.nGrid;           
alpha = param.alpha;           

beta = param.beta;              
gamma = param.gamma;            


%% Initialization

% Create Empty Individual
empty_individual.Position = [];         % Position within Objective Function Space
empty_individual.ObjFuncVal = [];       % Objective Function Value
empty_individual.Domination = [];       % Tag for (Non-)Dominated Solution
empty_individual.GridIndex = [];        % Objective Function Space Grid Index
empty_individual.GridSubIndex = [];     % Objective Function Space Sub-Grid Index

% Recreate Empty Individual
individual = repmat(empty_individual,nPop,1);

for i=1:nPop

    % Evaluate Objective Function Values
    for j=1:nVar
        
        individual(i).Position(j) = unifrnd(varMin(j),varMax(j),1);
    
    end
    
    individual(i).ObjFuncVal = objFunc(individual(i).Position);
       
end

% Determine Domination
individual = detDomination(individual);
    
% Non-Dominated Individuals (Global Best)
bestIndividuals = individual(~[individual.Domination]);

% Create Grid within Objective Function Space
ObjFuncSpaceGrid = createObjFuncSpaceGrid(bestIndividuals,nGrid,alpha);

% Determine Index of Best Individuals within Objective Function Space Grid
for i=1:numel(bestIndividuals)
    
    bestIndividuals(i) = detObjFuncSpaceGridIndex(bestIndividuals(i),ObjFuncSpaceGrid);
    
end


%% Differential Evolution Alogorithm

for iter=1:nIt
    
    for i=1:nPop
        
        %% Mutation
        
        % Pick Best Individual        
        bestIndividual = selBestIndividual(bestIndividuals,beta);
        
        % Initialize Permutation
        permutation = randperm(nPop);
        
        % Avoid Mutation with Itself
        permutation(permutation==i) = [];
        
        % Randomize Scaling Factor
        F  = unifrnd(F_min,F_max,varSize);
        
        % Create Mutant
        switch mutation_scheme
            
            case 1
                mutant.Position = individual(permutation(1)).Position + ...
                                  F.*(individual(permutation(2)).Position - individual(permutation(3)).Position);
            case 2
            	mutant.Position = bestIndividual.Position + ...
                                  F.*(individual(permutation(1)).Position - individual(permutation(2)).Position);
            
            case 3
            	mutant.Position = individual(i).Position + ...
                                  F1.*(bestIndividual.Position - individual(permutation(1)).Position) + ... 
                                  F2.*(individual(permutation(2)).Position - individual(permutation(3)).Position);
                                 
            case 4
            	mutant.Position = bestIndividual.Position + ...
                                  F1.*(individual(permutation(1)).Position - individual(permutation(2)).Position)+ ...
                                  F2.*(individual(permutation(3)).Position - individual(permutation(4)).Position);
                                 
            otherwise
            	mutant.Position = individual(permutation(1)).Position + ...
                                  F.*(individual(permutation(2)).Position - individual(permutation(3)).Position);
                                 
        end
        
        % Apply Lower und Upper Boundary Vector Limits
        for j=1:nVar
            
            mutant.Position(j) = max(mutant.Position(j), varMin(j));
            mutant.Position(j) = min(mutant.Position(j), varMax(j));
            
        end
                    
        %% Recombination
        
        crossover = randi([1 nVar]);
        for j=1:nVar
            
            % Check for (Random) Crossover
            if ( (j == crossover) || (rand <= Cr) )
                candidate(i).Position(j) = mutant.Position(j);
            else
                candidate(i).Position(j) = individual(i).Position(j);
            end
            
        end
        
        %% Selection 
        
        % Evaluate Candidate Solution
        candidate(i).ObjFuncVal = objFunc(candidate(i).Position);
        % Check Candidate's Solution
        if ( domIndividual(candidate(i),individual(i)) )
            individual(i).Position = candidate(i).Position;
            individual(i).ObjFuncVal = candidate(i).ObjFuncVal;
        end
        
    end

    % Determine Domination of Individuals (among each other)
    individual = detDomination(individual);
    
    % Add Non-Dominated Individuals to Best Individuals
    bestIndividuals = [bestIndividuals
                       individual(~[individual.Domination])];
    
    % Determine Domination of Best Individuals (among each other)
    bestIndividuals = detDomination(bestIndividuals);
    
    % Keep only Non-Dominated Best Individuals
    bestIndividuals = bestIndividuals(~[bestIndividuals.Domination]);
    
    % Update Objective Function Space Grid
    ObjFuncSpaceGrid = createObjFuncSpaceGrid(bestIndividuals,nGrid,alpha);
    
    % Update Grid Indices
    for i=1:numel(bestIndividuals)
        
        bestIndividuals(i) = detObjFuncSpaceGridIndex(bestIndividuals(i),ObjFuncSpaceGrid);
        
    end
    
    % Check Number of Best Individuals
    if ( numel(bestIndividuals) > nBest )
        
        % Remove Past Best Individuals
        renewBest = numel(bestIndividuals) - nBest;
        
        for i=1:renewBest
            
            bestIndividuals = removeBestIndividuals(bestIndividuals,gamma);
            
        end
        
    end
    
    % Plot Objective Function Values
    plotFuncVal(individual,candidate,bestIndividuals);
    
    % Plot Growth of Hypervolume
    plotHyperVol(bestIndividuals,iter);
    
    % Show Iteration Information
    disp(['Iteration ' num2str(iter) ': Non-Dominated Solutions = ' num2str(numel(bestIndividuals))]);
            
end

end

