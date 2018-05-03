% Plot Objective Function Values

function plotFuncVal(individual,candidate,bestIndividuals)
    
    f = figure(1);
    movegui(f,'northwest');
    
    individualObjFuncVal=[individual.ObjFuncVal];
    plot(individualObjFuncVal(1,:),individualObjFuncVal(2,:),'ko');
    hold on
    
    candidateObjFuncVal=[candidate.ObjFuncVal];
    plot(candidateObjFuncVal(1,:),candidateObjFuncVal(2,:),'kX');
    hold on
    
    bestObjFuncVal=[bestIndividuals.ObjFuncVal];
    plot(bestObjFuncVal(1,:),bestObjFuncVal(2,:),'k*');
    hold off
    
    xlabel('1^{st} Objective Function');
    ylabel('2^{nd} Objective Function');
    title('Objective Function Values');
    
    legend('Individuals (Initialization, Selection)', 'Candidates (Mutation, Recombination)','Non-Dominated Solutions')
    
    grid on;
    
    hold off;

end