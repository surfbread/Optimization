% Determine, if any Particle is or all Particles are dominated

function particle=detDomination(particle)
    
    % Determine Number of Particles
    nParticles=numel(particle);
    
    % Initialize Non-Domination
    for i=1:nParticles
        particle(i).IsDominated=false;
    end
    
    % Check if any Particle / all Particles is / are dominated
    for i=1:nParticles-1
        for j=i+1:nParticles
            
            % Particle dominated by another one
            if domParticle(particle(i),particle(j))
               particle(j).IsDominated=true;
            end
            
            % Particle dominated by another one
            if domParticle(particle(j),particle(i))
               particle(i).IsDominated=true;
            end
            
        end
    end

end