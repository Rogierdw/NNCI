function [ w, success ] = rosenblatt( n_max, data, labels )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


w = zeros(1,size(data,2)); % create w(0), size of dimensions
N = size(w,2);     % placeholder

if(N==2)    % for printing in 2D
    scatter_(data, labels);
end

for n = 1:n_max % number of epochs
    changed = 0;
    for t = 1:size(data,1) % for each data-point
        E_mu_t = sign(dot(w,data(t,:)*labels(t)));
        if (E_mu_t <= 0)
            w = w + (1/N)*data(t,:)*labels(t);
            changed = 1;
        end
    end
    if (changed==0)
        break
    end
end

success = 1;
if (changed ~= 0) % only when n == n_max, check if maybe is still successful
    for t = 1:size(data,1)
        E_v = sign(dot(w,data(t,:)*labels(t)));
        if(E_v) <= 0
            success = 0;
            break
        end
    end
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

