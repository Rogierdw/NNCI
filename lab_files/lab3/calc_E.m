function [ E ] = calc_E( data, labels, w1, w2 )
%CALC_E Summary of this function goes here
%   Detailed explanation goes here
Ex = 0;    
P = size(data,2);

for i = 1:P
    Ex = Ex + (tanh(dot(w1,data(:,i))) + tanh(dot(w2,data(:,i))) - labels(i))^2;
end
E = Ex/(2*P);

end

