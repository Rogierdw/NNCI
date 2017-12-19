function [ K_min, dat_min, lab_min ] = calc_k_min( w, data, labels )
%UNTITLED3 Summary of this function goes here
    % Maximum stability calculation
K_min = 100;
for t = 1:size(data,1)
    K_v_t = dot(w,data(t,:)*labels(t)); % Stability calculation
    if K_v_t < K_min % Smallest stability search
        K_min = K_v_t;
        dat_min = data(t,:);
        lab_min = labels(t);
    end
end

end

