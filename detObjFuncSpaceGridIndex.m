% Determine Index of Hypercube within Object Function Space Grid

function archivedParticle = detObjFuncSpaceGridIndex(archivedParticle,ObjFuncSpaceGrid)

    nObj = numel(archivedParticle.ObjFuncVal);
    
    nGrid = numel(ObjFuncSpaceGrid(1).LB);
    
    archivedParticle.GridSubIndex = zeros(1,nObj);
    
    % Find Archived Particle within Object Function Space Grid
    for i=1:nObj
        
        archivedParticle.GridSubIndex(i)=...
            find(archivedParticle.ObjFuncVal(i) < ObjFuncSpaceGrid(i).UB,1,'first');
        
    end
    
    % Determine Index of Hypercube within Object Function Space Grid
    archivedParticle.GridIndex = archivedParticle.GridSubIndex(1);
    for i=2:nObj
        
        archivedParticle.GridIndex = archivedParticle.GridIndex-1;
        archivedParticle.GridIndex = nGrid*archivedParticle.GridIndex;
        archivedParticle.GridIndex = archivedParticle.GridIndex + archivedParticle.GridSubIndex(i);
        
    end
    
end