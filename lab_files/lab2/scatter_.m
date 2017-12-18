function [ ] = scatter_( data, labels )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    hold on
    
    for i = (1:size(labels))
        if (labels(i) > 0)
            scatter(data(i,1), data(i,2), 'filled', 'blue' )
            xlim([0 8])
            ylim([0 3])
        else
            scatter(data(i,1), data(i,2), 'blue')
        end
    end

end

