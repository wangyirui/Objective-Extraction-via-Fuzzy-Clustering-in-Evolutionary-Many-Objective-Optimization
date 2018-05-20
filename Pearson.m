function r = Pearson( x, y )

% r1= sum(x .* y) - (sum(x) * sum(y)) / length(x);  
% 
% r2 = sqrt((sum(x .^2) - (sum(x))^2 / length(x))) * sqrt((sum(y .^2) - (sum(y))^2 / length(y)));  
% r2=1/r2;
% r= r1*r2;
x_avg = mean(x);
y_avg = mean(y);
tmp = (sum((x - x_avg) .* (y - y_avg))) ...
    / (sqrt(sum((x - x_avg).^2)) * sqrt(sum((y - y_avg).^2)));

if abs(tmp - 1.0) < 10e-5
    tmp = 0.9999;
end

r = 1 - tmp;
% r = 1.0 - tmp; %将相关性变为[0,2], 0表示完全相关，2表示完全不相关(OK)
% if r < 0                           % Avoid one of the data points is exactly
%     r = 1.0e-5;                                    % The same as one of the cluster centers
% end



if r < 0
    aaa=111;
end

end

