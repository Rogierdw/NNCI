function [ w ] = minover( n_max, data, labels)
%MINOVER Summary of this function goes here
%   Detailed explanation goes here


w = zeros(1,size(data,2));
N = size(w,2);

if(N==2)    % for printing in 2D
    scatter_(data, labels);
end

% NO STOPPING IMPLEMENTED YET
for n = 1:n_max % number of epochs
    K_min = 100;
    x = randperm(size(data,1)); % For random picking of data
    data = data(x,:);
    labels = labels(x);
    for t = 1:size(data,1)
        K_v_t = dot(w,data(t,:)*labels(t)); % Stability calculation
        if K_v_t < K_min % Smallest stability search
            K_min = K_v_t;
            u = t;
        end
    end
    w = w + (1/N)*data(u,:)*labels(u); % Actual update
end

if(N==2)
    hold on
    plotv(w', 'black')
    x = [0, w(1)];
    y = [0, w(2)];
    w_coeffs = polyfit(x, y, 1);
    w_orth_a = -1/w_coeffs(1);
    w_orth_b = 0;
    axis equal
    xlims = xlim(gca);
    w_orth = xlims*w_orth_a+w_orth_b;
    line( xlims, w_orth);    
    hold off
end

end

