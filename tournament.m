function parent = tournament(Candidate1, Candidate2)

r1 = rand;
tmp = Dominates(Candidate1.Cost, Candidate2.Cost, Candidate1.Constrains,Candidate2.Constrains);
if tmp==1
    parent = Candidate1;
elseif tmp==-1
    parent = Candidate2;
elseif Candidate1.CrowdingDistance > Candidate2.CrowdingDistance
    parent = Candidate1;
elseif Candidate1.CrowdingDistance < Candidate2.CrowdingDistance
    parent = Candidate2;
elseif r1<= 0.5
    parent = Candidate1;
elseif r1 > 0.5
    parent = Candidate2;
end

end

