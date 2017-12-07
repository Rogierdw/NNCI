function [ data, labels] = data_matrix( P, N )
%DATA_MATRIX Summary of this function goes here
%   Detailed explanation goes here
    data = randn(P,N); % data creation
    w_star = ones(1,N);
    
    labels = zeros(P,1);
    for i = 1:N
        labels = labels + w_star(i)*data(:,i);
    end  
    labels = sign(labels); % label creation, labels are -1 or 1
    labels(labels==0) = 1; % 0 labels are converted to 1

end

