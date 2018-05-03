% Define Grid from Non-Dominated Solutions

function Grid = createObjFuncSpaceGrid(archivedParticles,nGrid,alpha)

    % Non-Dominated Solutions to form Grid
    sol = [archivedParticles.ObjFuncVal];
    
    % Minimum / Maximum of Non-Dominated Solutions
    sol_min = min(sol,[],2);
    sol_max = max(sol,[],2);
    
    % Define Grid Boundaries by Non-Dominated Solutions
    dist_sol = sol_max - sol_min;
    sol_min = sol_min - alpha*dist_sol;
    sol_max = sol_max + alpha*dist_sol;
    
    nObj=size(sol,1);
    
    % Create Empty Grid
    empty_grid.LB = [];
    empty_grid.UB = [];
    Grid = repmat(empty_grid,nObj,1);
    
    % Create Grid with Subdivisions
    for i=1:nObj
        
        div = linspace(sol_min(i),sol_max(i),nGrid+1);
        
        Grid(i).LB=[-inf div];
        Grid(i).UB=[div +inf];
        
    end

end