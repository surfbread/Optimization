% Determine Index of Hypercube within Object Function Space Grid

function bestIndividual = detObjFuncSpaceGridIndex(bestIndividual,ObjFuncSpaceGrid)

    nObj = numel(bestIndividual.ObjFuncVal);
    
    nGrid = numel(ObjFuncSpaceGrid(1).LB);
    
    bestIndividual.GridSubIndex = zeros(1,nObj);
    
    % Find Best Individual within Objective Function Space Grid
    for i=1:nObj
        
        bestIndividual.GridSubIndex(i)=...
            find(bestIndividual.ObjFuncVal(i) < ObjFuncSpaceGrid(i).UB,1,'first');
        
    end
    
    % Determine Index of Hypercube within Objective Function Space Grid
    bestIndividual.GridIndex = bestIndividual.GridSubIndex(1);
    for i=2:nObj
        
        bestIndividual.GridIndex = bestIndividual.GridIndex-1;
        bestIndividual.GridIndex = nGrid*bestIndividual.GridIndex;
        bestIndividual.GridIndex = bestIndividual.GridIndex + bestIndividual.GridSubIndex(i);
        
    end
    
end