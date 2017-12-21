clear all
close all
clc

alphas = 0.1:0.1:5;
nD = 10;
nMax = 500;
N = 20;
errs = zeros(1, length(alphas));

for i = 1:length(alphas)
    P = int8(N*alphas(i));
    for j = 1:nD
        [data, labels] = data_matrix2(P,N,0);
        w = minover(nMax, data, labels);
        errs(i) = errs(i) + calc_gen_error(w); 
    end
end
errs = errs / nD;

plot(alphas,errs)

title('Minover learning curve - N = 20, n_D = 10, n_{max} = 200')
xlabel('\alpha (P/N)')
ylabel('Generalization error')

%% k_{max} vs. alpha (Bonus 1)
clear all
close all
clc

alphas = 0.1:0.1:5;
n_D = 10;
nMax = 200;
N = 50;
k_max = zeros(2,length(alphas));
for i = 1:length(alphas)
    P = int8(N*alphas(i));
    for j = 1:n_D
        [data, labels] = data_matrix2(P,N,0);
        [~, k] = minover(nMax, data, labels);
        k_max(1,i) = k_max(1,i) + k;
        
        [data, labels] = data_matrix(P,N);
        [~, k] = minover(nMax, data, labels);
        k_max(2,i) = k_max(2,i) + k;
    end
end
k_max = k_max / n_D;

plot(alphas, k_max)
title('Perceptron stability curve - N = 50, n_D = 10, n_{max} = 200')
xlabel('\alpha (P/N)')
ylabel('Maximum stability')
legend('Minover - Teacher outputs', 'Minover - Random output')

%% Comparison with rosenblatt (Bonus 2)
clear all
close all
clc

alphas = 0.1:0.1:5;
n_D = 10;
nMax = 200;
N = 50;
errs = zeros(2,length(alphas));

for i = 1:length(alphas)
    P = int8(N*alphas(i));
    for j = 1:n_D
        [data, labels] = data_matrix2(P,N,0);
        w = minover(nMax, data, labels);
        errs(1,i) = calc_gen_error(w);
        
        w = rosenblatt(nMax, data, labels, 0);
        errs(2,i) = calc_gen_error(w);
    end
end
errs = errs / n_D;

plot(alphas,errs)

title('Perceptron learning curve - N = 50, n_D = 10, n_{max} = 200')
xlabel('\alpha (P/N)')
ylabel('Generalization error')
legend('Minover', 'Rosenblatt')

%% learning from noise examples

clear all
close all
clc

alphas = 0.1:0.1:5;
nD = 10;
nMax = 500;
N = 20;
lambda = 0.0:0.1:0.5;
errs = zeros(length(lambda), length(alphas));

for i = 1:length(alphas)
    P = int8(N*alphas(i));
    for j = 1:length(lambda);
        for k = 1:nD
            [data, labels] = data_matrix2(P,N,lambda(j));
            w = minover(nMax, data, labels);
            errs(j,i) = errs(j,i) + calc_gen_error(w); 
        end
    end
end
errs = errs / nD;

plot(alphas,errs)

title('Minover learning curve - N = 20, n_D = 10, n_{max} = 200')
xlabel('\alpha (P/N)')
ylabel('Generalization error')
legend('lambda = 0.0', 'lambda = 0.1', 'lambda = 0.2', 'lambda = 0.3', 'lambda = 0.4', 'lambda = 0.5', 'Location', 'southwest')

%% Iris dataset (extra bonus)
clear all
close all

%preprocess the iris data for binary classification with minover
load('fisheriris'); 
data = meas(:,[3,4]); % here we just use the third and forth features  
labels=grp2idx(species); 
labels(labels==2)=-1; 
labels(labels==3)=-1;

%clamp the input with an extra dimension to find an inhomogeneous solution
data = [data, (-1*ones(length(data), 1))];
    
nMax = 200;
part = 30; % twenty percent of the data for testing
% select train and test on randomly selected data with Monte Carlo cross validation
cv = 10;
data_ind = 1:length(data);
pred_err = zeros(1, cv);
for i = 1:cv
    % draw indices randomly for the test data without replacement, and calculate
    % the indices for the train data using the set difference
    test_ind = datasample(data_ind,part,'Replace',false);
    train_ind = setdiff(data_ind, test_ind);
    
    test_data = data(test_ind,:);
    test_labels = labels(test_ind);
    train_data = data(train_ind,:);
    train_labels = labels(train_ind);
    
    w = minover(nMax, train_data, train_labels);
    
    for j = 1:part
        test_vec = test_data(j,:);
        prediction = sign(dot(w, test_vec));
        pred_err(i) = pred_err(i) + (test_labels(j) ~= prediction);
    end
    
end
pred_err = pred_err / part;

mean(pred_err)

