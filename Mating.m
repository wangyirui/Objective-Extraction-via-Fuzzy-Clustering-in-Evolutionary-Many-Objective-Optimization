function  Mating()
global mop  pop popc;

popcIndex = 1;
RandRange = size(pop, 1);
RandTemp1 = randperm(RandRange);
CandidateIndex1 = RandTemp1(1 : size(pop, 1));

for i1 = 1 : 4 : (size(pop, 1) - mod(size(pop,1), 4))
    Candidate1 = pop(CandidateIndex1(i1));
    Candidate2 = pop(CandidateIndex1(i1 + 1));
    Parent1 = tournament(Candidate1, Candidate2);
    Candidate1 = pop(CandidateIndex1(i1 + 2));
    Candidate2 = pop(CandidateIndex1(i1 + 3));
    Parent2 = tournament(Candidate1, Candidate2);
    [popc(popcIndex).Position, popc(popcIndex + 1).Position] = Crossover(Parent1.Position, Parent2.Position);
    [popc(popcIndex).RawCost, popc(popcIndex).Cost, popc(popcIndex).Constrains] ...
        = costFunction(mop, popc(popcIndex).Position);
    [popc(popcIndex + 1).RawCost, popc(popcIndex + 1).Cost, popc(popcIndex + 1).Constrains] ...
        = costFunction(mop, popc(popcIndex + 1).Position);
    popcIndex = popcIndex + 2;
end

% Merge
pop=[pop; popc];

end


