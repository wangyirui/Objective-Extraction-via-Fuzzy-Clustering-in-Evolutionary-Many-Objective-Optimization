function U = Weight(F1)

global mop  Cluster;


CostMatrix = zeros(mop.odim, size(F1, 1));
for i1 = 1 : size(F1, 1)
    CostMatrix(:, i1) = F1(i1).RawCost(:);
end

U_tmp = fcm(CostMatrix, Cluster);

U = zeros(size(U_tmp,1), size(U_tmp,2));
U_round = round(U_tmp);
order = zeros(Cluster, 1);
for i = 1 : Cluster
order(i) = find(U_round(i,:)==1,1);
end
[~,index]=sort(order, 'ascend');
for i = 1 : Cluster
U(i, :) = U_tmp(index(i),:);
end

end


