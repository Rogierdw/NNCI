%% Main assignment, single training, Q,P = 100
clear all
close all

load data3.mat

t_max = 50;
P = 100;
Q = 100;
[E,Et] = grad_desc(t_max, xi(:,1:P), tau(1:P), xi(:,P+1:P+Q), tau(P+1:P+Q));
t = 1:t_max;
res = [E;Et];

figure
plot(t,res)
ylim([0 0.4])
title('Gradient Descent - Cost Function (single training), P=100, Q=100')
xlabel('Epochs (t)')
ylabel('Mean Cost')
legend('E', 'E_{test}')


%% Main assignment, 10 fold-training and testing, Q,P = 250
clear all
close all

load data3.mat

t_max = 50;
folds = 10;

dat_size=size(xi,2)/(2*folds);
E_final = zeros(folds,t_max);
Et_final = zeros(folds,t_max);

dat_start = 1;

for i = 1:folds
    train_data = xi(:,dat_start:dat_start+dat_size-1);
    train_labels = tau(dat_start:dat_start+dat_size-1);
    test_data = xi(:,dat_start+dat_size:dat_start+(2*dat_size)-1);
    test_labels = tau(dat_start+dat_size:dat_start+(2*dat_size)-1);
    dat_start = dat_start + (2*dat_size);
    
    [E,Et] = grad_desc(t_max, train_data, train_labels, test_data, test_labels);
    E_final(i,:) = E;
    Et_final(i,:) = Et;
end


E_res = mean(E_final,1);
Et_res = mean(Et_final,1);
t = 1:t_max;
res = [E_res;Et_res];
figure
plot(t,res)
ylim([0 0.4])

title('Gradient Descent - Cost Function (10-fold), P=250, Q=250')
xlabel('Epochs (t)')
ylabel('Mean Cost')
legend('E', 'E_{test}')

%% Bonus 1, different P, set Q = 250
clear all
close all

load data3.mat

t_max = 50;
folds = 10;

P = [20, 50, 100, 200, 500, 1000, 2000];
Q = 250;

for x = 1:size(P,2);
    train_size = P(x);
    E_final = zeros(folds,t_max);
    Et_final = zeros(folds,t_max);

    for i = 1:folds
        y = randperm(size(xi,2)); % For random picking of data
        xi = xi(:,y);
        tau = tau(y);
        
        train_data = xi(:,1:train_size);
        train_labels = tau(1:train_size);
        test_data = xi(:,train_size+1:train_size+Q);
        test_labels = tau(train_size+1:train_size+Q);

        [E,Et] = grad_desc(t_max, train_data, train_labels, test_data, test_labels);
        E_final(i,:) = E;
        Et_final(i,:) = Et;
    end


    E_res = mean(E_final,1);
    Et_res = mean(Et_final,1);
    t = 1:t_max;
    res = [E_res;Et_res];
    figure
    plot(t,res)
    ylim([0 0.4])
    
    txt = sprintf('Gradient Descent - Cost Function (10-fold), P=%g, Q=250', train_size);
    title(txt)
    xlabel('Epochs (t)')
    ylabel('Mean Cost')
    legend('E', 'E_{test}')
end

%% Bonus 2 - Time dependent learning rate

clear all
close all

load data3.mat

a = 1;
b = 50;

t_max = 50;
folds = 10;

dat_size=size(xi,2)/(2*folds);
E_final = zeros(folds,t_max);
Et_final = zeros(folds,t_max);

dat_start = 1;

for i = 1:folds
    train_data = xi(:,dat_start:dat_start+dat_size-1);
    train_labels = tau(dat_start:dat_start+dat_size-1);
    test_data = xi(:,dat_start+dat_size:dat_start+(2*dat_size)-1);
    test_labels = tau(dat_start+dat_size:dat_start+(2*dat_size)-1);
    dat_start = dat_start + (2*dat_size);
    
    [E,Et] = grad_desc(t_max, train_data, train_labels, test_data, test_labels, a, b);
    E_final(i,:) = E;
    Et_final(i,:) = Et;
end


E_res = mean(E_final,1);
Et_res = mean(Et_final,1);
t = 1:t_max;
res = [E_res;Et_res];
figure
plot(t,res)
ylim([0 0.5])

title('Gradient Descent - Cost Function (10-fold), P=250, Q=250, \eta = 1/50t')
xlabel('Epochs (t)')
ylabel('Mean Cost')
legend('E', 'E_{test}')
    
