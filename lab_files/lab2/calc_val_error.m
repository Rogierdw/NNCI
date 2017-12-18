function [ error ] = calc_val_error( w, data, labels )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    error = 0;
    for i = 1:size(data,1)
        expected = sign(dot(w, data(i,:)));
        if expected ~= labels(i)
            error = error + 1;
        end
    end
    error = error/size(data,1);

end

