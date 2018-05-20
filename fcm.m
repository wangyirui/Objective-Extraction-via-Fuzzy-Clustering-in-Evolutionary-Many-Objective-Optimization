function U = fcm(data, cluster_n)
global U_old weightStatus fuzzyExpo;
%% Initialize
max_iter = 100;                                  % Max. iteration
obj_fcn = zeros(max_iter, 1);             % Array for objective function
data_n = size(data, 1);
if strcmp(weightStatus, 'Initialize')
    U = initfcm(cluster_n, data_n);			  % Initial fuzzy partition
else
    U = U_old;
end

%% Main loop
for i = 1:max_iter,
    [U, obj_fcn(i)] = stepfcm(data, U, cluster_n, fuzzyExpo);
    
    % check termination condition
    if i > 1
        if abs(obj_fcn(i) - obj_fcn(i-1)) < 1.0e-5
            break;
        end
    end
end

% Actual number of iterations
iter_n = i;
obj_fcn(iter_n+1:max_iter) = [];

end