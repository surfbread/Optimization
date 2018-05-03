% Plot Objective Function Values

function plotHyperVol(archivedParticles,iter)
    
    f = figure(2);
    movegui(f,'northeast');

    growthHyperVol = numel(unique([archivedParticles.GridIndex],'sorted'));
    plot(iter,growthHyperVol,'ks');
    
    xlabel('Number of Iterations');
    ylabel('Number of Hypercubes');
    title('Hypercubes Occupied by Non-Dominated Solutions');
    
    grid on;
    
    hold on;

end