% Remove Past Best Individuals

function bestIndividuals = removeBestIndividuals(bestIndividuals,gamma)

    % Grid Index of Best Individuals
    GridIndices = [bestIndividuals.GridIndex];
    
    % Hypercubes Occupied by Individuals
    OccupiedHypercubes = unique(GridIndices);
    
    % Number of Inviduals in Occupied Hypercubes
    N = zeros(size(OccupiedHypercubes));
    for i=1:numel(OccupiedHypercubes)
        
        N(i) = numel(find(GridIndices == OccupiedHypercubes(i)));
        
    end
    
    % Selection Probabilities
    selProb = exp(gamma*N);
    selProb = selProb/sum(selProb);
    
    % Selected Grid Index
    selGridIndex = selRouletteWheel(selProb);
    
    % Selected Hypercube
    selHypercube = OccupiedHypercubes(selGridIndex);
    
    % Selected Hypercube Occupants
    selOccupants = find(GridIndices == selHypercube);
    
    % Random Occupant Index
    occupantIndex = randi([1 numel(selOccupants)]);
    
    % Select Individual
    selIndividual = selOccupants(occupantIndex);
    
    % Delete Individual from Archive
    bestIndividuals(selIndividual) = [];

end