% Plot Objective Function Values

function plotFuncVal(particle,archivedParticles)
    
    f = figure(1);
    movegui(f,'northwest');
    
    particleObjFuncVal=[particle.ObjFuncVal];
    plot(particleObjFuncVal(1,:),particleObjFuncVal(2,:),'ko');
    hold on;
    
    archivedObjFuncVal=[archivedParticles.ObjFuncVal];
    plot(archivedObjFuncVal(1,:),archivedObjFuncVal(2,:),'k*');
    
    xlabel('1^{st} Objective Function');
    ylabel('2^{nd} Objective Function');
    title('Objective Function Values');
    
    legend('Swarm Particles', 'Non-Dominated Solutions')
    
    grid on;
    
    hold off;

end