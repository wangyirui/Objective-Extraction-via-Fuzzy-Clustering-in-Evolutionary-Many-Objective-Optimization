function pop=CrowdingDistance(pop,F)

%Number of the rank of F set
nF = numel(F);                         

for i = 1 : nF
    Results = [pop(F{i}).Cost];
    nObjective = size(Results, 1);
    nIndividual = numel(F{i});
    dist = zeros(nIndividual, nObjective);
    
    for j = 1:nObjective
        [SortResult, Index] = sort(Results(j, :));
        
        %Set Fmin = inf
        dist(Index(1), j) = inf;      
        
        %Set Fmax = inf
        dist(Index(end), j) = inf;    
        
        for k = 2 : nIndividual - 1
            dist(Index(k), j) = abs(SortResult(k+1) - SortResult(k-1))/abs(SortResult(end)-SortResult(1));
        end
    end
    
    for  j = 1:nIndividual
        pop(F{i}(j)).CrowdingDistance = sum(dist(j, :));
    end
end

end

