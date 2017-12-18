%% 
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

%% Extra bonus
clear all
close all
clc

% From each class, 80% training, 20% testing
% Minover algorithm for training set
% Resulting weight vector to predict labels of test set
% Compute rate of missclassification

load('fisheriris');
X = meas(:,[3,4]);
labels = grp2idx(species);
labels(labels==2) = -1;
labels(labels==3) = -1;

nMax = 1000;
nD = 5;
err=0;
class1_X = X(1:50,:);
class1_labels = labels(1:50);
class2_X = X(51:150,:);
class2_labels = labels(51:150);

for i = 1:nD
    x = randperm(size(class1_X,1));
    class1_X = class1_X(x,:);
    class1_labels = class1_labels(x);
    
    x = randperm(size(class2_X,1));
    class2_X = class2_X(x,:);
    class2_labels = class2_labels(x);
    
    train_X = [class1_X(1:40,:);class2_X(1:80,:)];
    train_labels = [class1_labels(1:40);class2_labels(1:80)];
    test_X = [class1_X(41:50,:);class2_X(81:100,:)];
    test_labels = [class1_labels(41:50);class2_labels(81:100)];
    
    w = minover(nMax, train_X, train_labels);
    err = err + calc_val_error(w, test_X, test_labels);
end
err = err / nD

% This data is not linearly seperable, use scatter_(X,labels) to confirm...
% Error rate is about the same as the rate of class1 / class2


