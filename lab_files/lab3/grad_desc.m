function [ E, E_test] = grad_desc(t_max, train_data, train_labels, test_data, test_labels )
%GRAD_DESC Summary of this function goes here
%   Detailed explanation goes here
PLOT = 0;

learnrate = 0.05;
P = size(train_data,2);
Q = size(test_data,2);
N = size(train_data,1);
tmax = P*t_max;

if(N==2)    % for printing in 2D
    close all
    scatter_(data, labels);
end

w1 = randn(1,N); % random independent vector init (randn or rand???)
w1 = w1/norm(w1); % normalize to |w1|^2 = 1
w2 = rand(1,N);
w2 = w2/norm(w2);

E = zeros(1,tmax);
E_test = zeros(1,tmax);

for t = 1:tmax
    idx = randi(P);
    sigm = tanh(dot(w1,train_data(:,idx)))+tanh(dot(w2,train_data(:,idx))); % Not sure if this should be seperate for both weight vectors...
    
    sigm_der1 = 1-tanh(dot(w1,train_data(:,idx)))^2;
    sigm_der2 = 1-tanh(dot(w2,train_data(:,idx)))^2;
    
    grad1 = (sigm-train_labels(idx))*sigm_der1*train_data(:,idx);
    grad2 = (sigm-train_labels(idx))*sigm_der2*train_data(:,idx);
    
    w1 = w1 - learnrate*grad1';
    w2 = w2 - learnrate*grad2';
    %output = tanh(dot(w1,data(:,idx)))+tanh(dot(w2,data(:,idx)));
    Ex = 0;
    for i = 1:P
        Ex = Ex + (tanh(dot(w1,train_data(:,i))) + tanh(dot(w2,train_data(:,i))) - train_labels(i))^2;
    end
    E(t) = Ex/(2*P);
    
    E_tx = 0;
    for i = 1:Q
        E_tx = E_tx + (tanh(dot(w1,test_data(:,i))) + tanh(dot(w2,test_data(:,i))) - test_labels(i))^2;
    end
    E_test(t) = E_tx/(2*Q);
end

if PLOT
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
