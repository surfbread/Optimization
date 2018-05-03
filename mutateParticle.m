%% Mutate Particle

function mutatedParticle = mutateParticle(particle,mutation_op,varMin,varMax)

    nVar = numel(particle);
    j = randi([1 nVar]);

    dVar = mutation_op*(varMax - varMin);
    
    lowerBoundary = particle(j) - dVar;
    if lowerBoundary < varMin
        lowerBoundary = varMin;
    end
    
    upperBoundary = particle(j) + dVar;
    if ( upperBoundary > varMax )
        upperBoundary = varMax;
    end
    
    mutatedParticle = particle;
    mutatedParticle(j) = unifrnd(lowerBoundary,upperBoundary);

end