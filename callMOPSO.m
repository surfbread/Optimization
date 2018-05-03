function NonDominatedSolutions = callMOPSO(problem,param)

% Multi-Objective Particle Swarm Optimization:

%% Problem

objFunction = problem.objFunction;

varMin = problem.varMin;       
varMax = problem.varMax;

nVar = problem.nVar;     

varSize = problem.varSize ;

%% Parameters

nIt = param.nIt;        
nParticles = param.nParticles;   
nArchivedParticles = param.nArchivedParticles;           

w = param.w;             
wDamp = param.wDamp;      
c1 = param.c1;              
c2 = param.c2;               

nGrid = param.nGrid;   
alpha = param.alpha;       

beta = param.beta;           
gamma = param.gamma;

mu = param.mu;

%% Initialization

% Particle defined by Structure
empty_particle.Position = [];              % Personal Positon
empty_particle.Velocity = [];              % Personal Velocity
empty_particle.ObjFuncVal = [];            % Personal Objecitve Function Value
empty_particle.Best.Position = [];         % Personal Best Position
empty_particle.Best.ObjFuncVal = [];       % Personal Best Object Function Value
empty_particle.IsDominated = [];           % Tag for Non-Dominated Solution
empty_particle.GridIndex = [];             % Objective Function Space Grid Index
empty_particle.GridSubIndex = [];          % Objective Function Space Grid Sub-Index

% Create Particles (in nParticle Rows)
particle = repmat(empty_particle,nParticles,1);

% Initialize Particles
for i=1:nParticles
    
    % Create Random Particle Positions within the Search Space
    for j=1:nVar
        particle(i).Position(j) = unifrnd(varMin(j),varMax(j),1);
    end
    
    % Initialize Particle Velocity
    particle(i).Velocity = zeros(varSize);
    
    % Evaluate Objective Function Value
    particle(i).ObjFuncVal = objFunction(particle(i).Position);
    
    % Update Personal Best Position
    particle(i).Best.Position = particle(i).Position;
    
    % Update Personal Best Function Value
    particle(i).Best.ObjFuncVal = particle(i).ObjFuncVal;
    
end

% Determine Domination
particle = detDomination(particle);

% Store Non-Dominated Particles (Global Best) in Archive
archivedParticles = particle(~[particle.IsDominated]);

% Create Grid within Objective Function Space
ObjFuncSpaceGrid = createObjFuncSpaceGrid(archivedParticles,nGrid,alpha);

% Determine Index of Archived Particle within Objective Function Space Grid
for i=1:numel(archivedParticles)
    
    archivedParticles(i) = detObjFuncSpaceGridIndex(archivedParticles(i),ObjFuncSpaceGrid);
    
end


%% Main Loop

% Iterations
for iter=1:nIt
    
    % Particles
    for i=1:nParticles
        
        leaderParticle = selLeaderParticle(archivedParticles,beta);
        
        % Update Particle Velocity (Elementwise)
        % Equation: v(t+1) = w*v(t) + c1*r1*(P(t)-x(t))+c2*r2*(g(t)-x(t))
        particle(i).Velocity = w*particle(i).Velocity ...
            + c1*rand(varSize).*(particle(i).Best.Position - particle(i).Position) ...
            + c2*rand(varSize).*(leaderParticle.Position - particle(i).Position);
        
        % Update Particle Position (Elementwise)
        % Equation: x(t+1) = x(t) + v(t+1)
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        
        % Apply Lower und Upper Boundary Vector Limits
        for j=1:nVar
            
            particle(i).Position(j) = max(particle(i).Position(j), varMin(j));
            particle(i).Position(j) = min(particle(i).Position(j), varMax(j));
            
        end
        
        % Evaluate Object Function Value with Particle
        particle(i).ObjFuncVal = objFunction(particle(i).Position);
        
        % Apply Random Mutation
        % Equation Mutation-Operator: (1 - currentGen/totalGen)^(5/mu)
        mutation_op = (1 - (iter - 1)/(nIt - 1))^(5/mu);
        if ( rand < mutation_op )
            for j=1:nVar
                
                mutatedParticle.Position(j) = mutateParticle(particle(i).Position(j),mutation_op,varMin(j),varMax(j));
                                
            end
            
            % Evaluated mutated Object Function Value
            mutatedParticle.ObjFuncVal = objFunction(mutatedParticle.Position);
            
            % Check if Mutated Particle is Dominated
            if ( domParticle(mutatedParticle,particle(i)) )
                particle(i).Position = mutatedParticle.Position;
                particle(i).ObjFuncVal = mutatedParticle.ObjFuncVal;

            elseif ( domParticle(particle(i),mutatedParticle) )
                % Do Nothing: Mutated Particle is Dominated

            else
                % In Case Of Mutual (Non-)Domination
                if ( rand < 0.5 )
                    particle(i).Position = mutatedParticle.Position;
                    particle(i).ObjFuncVal = mutatedParticle.ObjFuncVal;
                end
            end
        end
        
        % Check for Personal Best Objective Function Value
        if ( domParticle(particle(i),particle(i).Best) )
            particle(i).Best.Position = particle(i).Position;
            particle(i).Best.ObjFuncVal = particle(i).ObjFuncVal;
            
        elseif domParticle(particle(i).Best,particle(i))
            % Do Nothing: Particle is Dominated
            
        else
            % In Case Of Mutual (Non-)Domination
            if ( rand < 0.5 )
                particle(i).Best.Position = particle(i).Position;
                particle(i).Best.ObjFuncVal = particle(i).ObjFuncVal;
            end
        end
        
    end
    
    % Add Non-Dominated Particles to Archive
    archivedParticles = [archivedParticles
                         particle(~[particle.IsDominated])];
    
    % Determine Domination of Archived Particles
    archivedParticles = detDomination(archivedParticles);
    
    % Keep only Non-Dominated Particles in Archive
    archivedParticles = archivedParticles(~[archivedParticles.IsDominated]);
    
    % Update Objective Function Space Grid
    ObjFuncSpaceGrid = createObjFuncSpaceGrid(archivedParticles,nGrid,alpha);

    % Update Grid Indices
    for i=1:numel(archivedParticles)
        
        archivedParticles(i) = detObjFuncSpaceGridIndex(archivedParticles(i),ObjFuncSpaceGrid);
        
    end
    
    % Check if Archive is Full
    if ( numel(archivedParticles) > nArchivedParticles )
        
        % Empty Archive
        renewArchive = numel(archivedParticles)- nArchivedParticles;
        for i=1:renewArchive
            
            archivedParticles = removeArchivedParticle(archivedParticles,gamma);
            
        end
        
    end
    
    % Plot Objective Function Values
    plotFuncVal(particle,archivedParticles);
    
    % Plot Growth of Hypervolume
    plotHyperVol(archivedParticles,iter);
    
    % Show Iteration Information
    disp(['Iteration ' num2str(iter) ': Non-Dominated Solutions = ' num2str(numel(archivedParticles))]);

    % Damping Inertia Weight
    w = w*wDamp;
    
end

%% Results (Last Non-Dominated Solutions)
NonDominatedSolutions = archivedParticles;


end

