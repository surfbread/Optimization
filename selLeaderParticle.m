% Select Leader Particle (Global Best Particle)

function leaderParticle = selLeaderParticle(archivedParticles,beta)

    % Grid Index of All Repository Members
    GridIndices = [archivedParticles.GridIndex];
    
    % Hypercubes Occupied by Particles
    OccupiedHypercubes = unique(GridIndices);
    
    % Number of Particles in Occupied Hypercubes
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
    
    % Selected Particle
    selParticle = selOccupants(occupantIndex);
    
    % Leader Particle
    leaderParticle=archivedParticles(selParticle);

end