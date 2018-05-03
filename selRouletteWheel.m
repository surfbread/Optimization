% Roulette Wheel Selection

function selIndex = selRouletteWheel(selProb)

    r = rand;
    
    C = cumsum(selProb);
    
    selIndex = find(r <= C,1,'first');

end