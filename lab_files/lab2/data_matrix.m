function [ data_matrix, label_vector ] = data_matrix( P, N )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    data_matrix = randn(P,N); % data creation
    label_vector = sign(randn(P,1)); % label creation, labels are -1 or 1
    label_vector(label_vector==0)=1; % 0 labels are converted to 1
end



