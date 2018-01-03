function [ E, E_test] = grad_desc(t_max, train_data, train_labels, test_data, test_labels )
%GRAD_DESC Summary of this function goes here
%   Detailed explanation goes here
PLOT = 0; % Boolean for plotting of weight vectors

learnrate = 0.05;
P = size(train_data,2);
Q = size(test_data,2);
N = size(train_data,1);
%tmax = P*t_max;

if(N==2)    % for data-plotting in 2D
    close all
    scatter_(data, labels);
end

w1 = randn(1,N); % random independent vector init
w1 = w1/norm(w1); % normalize to |w1|^2 = 1
w2 = rand(1,N);
w2 = w2/norm(w2);

E = zeros(1,t_max);
E_test = zeros(1,t_max);

for t = 1:t_max
    for k = 1:P     % actual epochs = t_max*P
        idx = randi(P);
        sigm = tanh(dot(w1,train_data(:,idx)))+tanh(dot(w2,train_data(:,idx))); % Not sure if this should be seperate for both weight vectors...

        sigm_der1 = 1-tanh(dot(w1,train_data(:,idx)))^2; %derivation with respect to w1
        sigm_der2 = 1-tanh(dot(w2,train_data(:,idx)))^2;

        grad1 = (sigm-train_labels(idx)) * sigm_der1 * train_data(:,idx); % Three parts gradient
        grad2 = (sigm-train_labels(idx)) * sigm_der2 * train_data(:,idx);

        w1 = w1 - learnrate*grad1'; % Update step using gradient
        w2 = w2 - learnrate*grad2';
    end
    E(t) = calc_E(train_data, train_labels, w1, w2); % Error calculation with weights on part of data
    E_test(t) = calc_E(test_data, test_labels, w1, w2);
end

if PLOT
    figure
    bar(w1)
    title('Gradient Descent - Weight vector w_1')
    xlabel('Dimension')
    ylabel('weight')

    figure
    bar(w2)
    title('Gradient Descent - Weight vector w_2')
    xlabel('Dimension')
    ylabel('weight')
end
