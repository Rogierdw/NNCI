function [ w, K_max ] = minover( n_max, data, labels)
%MINOVER Summary of this function goes here
%   Detailed explanation goes here

P = size(data,1);
N = size(data,2);
w = zeros(1,N);
threshold = 0.15;  % How do we calculate this one? has to do with changed

if(N==2)    % for printing in 2D
    close all
    scatter_(data, labels);
end

time_since_changed = 0;

for n = 1:n_max % number of epochs
    if time_since_changed >= P % No changes in last P runs
        break
    end
    x = randperm(size(data,1)); % For random picking of data
    data = data(x,:);
    labels = labels(x);
    [~, dat_min, lab_min] = calc_k_min(w, data, labels);
    w_old = w; % placeholder for stopping mehanism
    w = w + (1/N)*dat_min*lab_min; % Actual update
    
    %stopping mechanism
    changed = w_old-w;
    temp = 0;
    for i = 1:N
        if abs(changed(i)) < threshold
            temp = 1;
        else
            temp = 0;
            break
        end
    end
    if temp ~= 0   % Gone through previous loop without breaking, so all dimensions changed were below threshold
        time_since_changed = time_since_changed + 1;
    end
end

% Maximum stability calculation
K_max = calc_k_min(w,data,labels);

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

