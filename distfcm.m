function out = distfcm(center, data)

global mop;

out = zeros(size(center, 1), size(data, 1));

% fill the output matrix
for i1 = 1:size(center, 1)
    for i2 = 1 : mop.odim
        out(i1, i2) = Pearson(center(i1,:), data(i2, :));
    end
%     for k = 1:size(center, 1),
%         out(k, :) = sqrt(sum(((data-ones(size(data, 1), 1)*center(k, :)).^2)'));
%     end
end

end
