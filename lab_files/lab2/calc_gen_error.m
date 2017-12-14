function [ error ] = calc_gen_error( w )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
w_star = ones(1, length(w));
error = (1 / pi) * acos(dot(w_star, w)/(norm(w_star)*norm(w)));
end

