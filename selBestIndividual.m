% Select Best Individual (Global Best Particle)

function bestIndividual = selBestIndividual(bestIndividuals,beta)

    % Grid Index of Best Individuals
    GridIndices = [bestIndividuals.GridIndex];
    
    % Hypercubes Occupied by Individuals
    OccupiedHypercubes = unique(GridIndices);
    
    % Number of Individuals in Occupied Hypercubes
    N = zeros(size(OccupiedHypercubes));
    
    for i=1:numel(OccupiedHypercubes)
        
        N(i) = numel(find(GridIndices == OccupiedHypercubes(i)));
        
    end
    
    % Selection Probabilities
    selProb = exp(-beta*N);
    selProb = selProb/sum(selProb);
    
    % Selected Grid Index
    selGridIndex = selRouletteWheel(selProb);
    
    % Selected Hypercube
    selHypercube = OccupiedHypercubes(selGridIndex);
    
    % Selected Hypercube Occupants
    selOccupants = find(GridIndices == selHypercube);
    
    % Random Occupant Index
    occupantIndex = randi([1 numel(selOccupants)]);
    
    % Selected Individual
    selIndividual = selOccupants(occupantIndex);
    
    % Best Individual
    bestIndividual = bestIndividuals(selIndividual);

end