function [U_new, obj_fcn] = stepfcm(data, U, cluster_n, expo)

mf = U.^expo;                                                            % MF matrix after exponential modification
center = mf*data./(sum(mf,2)*ones(1,size(data,2))); % New center
dist = distfcm(center, data);                                       % Fill the distance matrix
if find(dist == 0)
    [row, column] = find(dist == 0);                            % Avoid one of the data points is exactly
    dist(row, column) = 1.0e-5;                                    % The same as one of the cluster centers
end
obj_fcn = sum(sum((dist.^2).*mf));                            % Objective function
tmp = dist.^(-2/(expo-1));                                          % Calculate new U, suppose expo != 1
U_new = tmp./(ones(cluster_n, 1)*sum(tmp));

end

