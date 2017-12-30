function [ data_matrix, label_vector ] = data_matrix( P, N )
%DATA_MATRIX Summary of this function goes here
%   Detailed explanation goes here
    data_matrix = randn(P,N); % data creation
    label_vector = randn(P,1); % label creation, labels are continuous
end

