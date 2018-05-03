% Remove Particle from Particle Archive (Renew Archive)

function archivedParticles = removeArchivedParticle(archivedParticles,gamma)

    % Grid Index of All Archived Particles
    GridIndices = [archivedParticles.GridIndex];
    
    % Hypercubes Occupied by Particles
    OccupiedHypercubes = unique(GridIndices);
    
    % Number of Particles in Occupied Hypercubes
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
    
    % Select Particle
    selParticle = selOccupants(occupantIndex);
    
    % Delete Particle from Archive
    archivedParticles(selParticle) = [];

end