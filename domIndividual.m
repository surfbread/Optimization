% Domination:
%A feasible solution is non-dominated
%whether does not exist another feasible solution
%better than the current one in some criterion
%without worsening at least one other criterion

function domination = domIndividual(individualX,individualY)
    
    % Check if Input is Structure-Array
    if isstruct(individualX)
        individualX = individualX.ObjFuncVal;
    end
    
    if isstruct(individualY)
        individualY = individualY.ObjFuncVal;
    end
    
    % Check if any Solution is Dominated by Another One
    domination = all(individualX <= individualY) && any(individualX < individualY);

end