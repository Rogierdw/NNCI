function [ data, labels] = data_matrix2( P, N )
%DATA_MATRIX Summary of this function goes here
%   Detailed explanation goes here
    data = randn(P,N); % data creation
    w_star = ones(1,N);
    
    labels = zeros(P,1);
    for i = 1:P
        labels(i) = sign(dot(w_star,data(i,:)));
    end  
    labels(labels==0) = 1; % 0 labels are converted to 1

end

