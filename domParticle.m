% Domination:
%A feasible solution is non-dominated
%whether does not exist another feasible solution
%better than the current one in some criterion
%without worsening at least one other criterion

function domination=domParticle(particleX,particleY)
    
    % Check if Input is Structure-Array
    if isstruct(particleX)
        particleX=particleX.ObjFuncVal;
    end
    
    if isstruct(particleY)
        particleY=particleY.ObjFuncVal;
    end
    
    % Check if any Solution is Dominated by Another One
    domination=all(particleX<=particleY) && any(particleX<particleY);

end