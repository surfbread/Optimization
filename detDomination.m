% Determine, if any Particle is or all Particles are dominated

function individual = detDomination(individual)
    
    % Determine Number of Particles
    nIndividuals = numel(individual);
    
    % Initialize Non-Domination
    for i=1:nIndividuals
        
        individual(i).Domination = false;
        
    end
    
    % Check if any Particle / all Particles is / are dominated
    for i=1:nIndividuals-1
        
        for j=i+1:nIndividuals
            
            % Particle dominated by another one
            if ( domIndividual(individual(i),individual(j)) )
               individual(j).Domination = true;
            end
            
            % Particle dominated by another one
            if ( domIndividual(individual(j),individual(i)) )
               individual(i).Domination = true;
            end
            
        end
        
    end

end