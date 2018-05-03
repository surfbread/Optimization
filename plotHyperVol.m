% Plot Hypercubes Occupied by Non-Dominated Solutions

function plotHyperVol(bestIndividuals,iter)
    
    f = figure(2);
    movegui(f,'northeast');

    growthHyperVol = numel(unique([bestIndividuals.GridIndex],'sorted'));
    plot(iter,growthHyperVol,'ks');
    
    xlabel('Number of Iterations');
    ylabel('Number of Hypercubes');
    title('Hypercubes Occupied by Non-Dominated Solutions');
    
    grid on;
    
    hold on;

end