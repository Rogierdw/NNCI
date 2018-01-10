%% Main assignment, single training, Q,P = 100
clear all
close all

load data3.mat

t_max = 50;
P = 250;
Q = 250;
[E,Et] = grad_desc(t_max, xi(:,1:P), tau(1:P), xi(:,P+1:P+Q), tau(P+1:P+Q));
t = 1:t_max;
res = [E;Et];

figure
plot(t,res)
ylim([0 0.4])
txt = sprintf('Gradient Descent - Cost Function (single training), P=%g, Q=%g', P,Q);
title(txt)
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

txt = sprintf('Gradient Descent - Cost Function (10-fold), P=%g, Q=%g', dat_size, dat_size);
title(txt)
xlabel('Epochs (t)')
ylabel('Mean Cost')
legend('E', 'E_{test}')

%% Bonus 1, different P, fixed Q = 250
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

%% Bonus 2 - Time dependent learning rates

clear all
close all

load data3.mat

a = 1;
b = [1,10,20,50];

t_max = 50;
folds = 10;

dat_size=size(xi,2)/(2*folds);
E_final = zeros(size(b,2)+1,t_max);
Et_final = zeros(size(b,2)+1,t_max);

dat_start = 1;
for i = 1:folds
    train_data = xi(:,dat_start:dat_start+dat_size-1);
    train_labels = tau(dat_start:dat_start+dat_size-1);
    test_data = xi(:,dat_start+dat_size:dat_start+(2*dat_size)-1);
    test_labels = tau(dat_start+dat_size:dat_start+(2*dat_size)-1);
    dat_start = dat_start + (2*dat_size);
    
    [E,Et] = grad_desc(t_max, train_data, train_labels, test_data, test_labels);
    E_final(1,:) = E_final(1,:)+ E;
    Et_final(1,:) = Et_final(1,:) + Et;
end

for i = 2:size(b,2)+1
    dat_start = 1;
    for j = 1:folds
        train_data = xi(:,dat_start:dat_start+dat_size-1);
        train_labels = tau(dat_start:dat_start+dat_size-1);
        test_data = xi(:,dat_start+dat_size:dat_start+(2*dat_size)-1);
        test_labels = tau(dat_start+dat_size:dat_start+(2*dat_size)-1);
        dat_start = dat_start + (2*dat_size);

        [E,Et] = grad_desc(t_max, train_data, train_labels, test_data, test_labels, a, b(i-1));
        E_final(i,:) = E_final(i,:) +  E;
        Et_final(i,:) = Et_final(i,:) + Et;
    end
end

E_res = E_final/folds;
Et_res = Et_final/folds;
t = 1:t_max;

figure
colors = ['k','m', 'c', 'r', 'b'];
hold on
for i = 1:size(E_res,1)
    plot(t,E_res(i,:),['-' colors(i)])
    plot(t,Et_res(i,:),['--' colors(i)])
end
ylim([0 0.5])

%
%figure
%plot(t,res)

txt = sprintf('Gradient Descent - Cost Function (10-fold), P=%g, Q=%g', dat_size,dat_size);
title(txt)
xlabel('Epochs (t)')
ylabel('Mean Cost')
legend('E,\eta = 0.05', 'E_{test}, \eta = 0.05','E,\eta = 1/t', 'E_{test},\eta = 1/t','E,\eta = 1/10t', 'E_{test},\eta = 1/10t',',\eta = 1/20t', 'E_{test},\eta = 1/20t','E,\eta = 1/50t', 'E_{test},\eta = 1/50t')
    
%% Bonus 2 extra, FOR THIS EXPERIMENT > CHANGE THE LEARNING RATE BY HAND IN GRAD_DESC.M
% Constant learning rate vs time-dependent learning rate

clear all
close all

load data3.mat

a = 1;
b = 50;

t_max = 50;
folds = 10;

dat_size=size(xi,2)/(2*folds);
E_final = zeros(2,t_max);
Et_final = zeros(2,t_max);

dat_start = 1;
for i = 1:folds
    train_data = xi(:,dat_start:dat_start+dat_size-1);
    train_labels = tau(dat_start:dat_start+dat_size-1);
    test_data = xi(:,dat_start+dat_size:dat_start+(2*dat_size)-1);
    test_labels = tau(dat_start+dat_size:dat_start+(2*dat_size)-1);
    dat_start = dat_start + (2*dat_size);
    
    [E,Et] = grad_desc(t_max, train_data, train_labels, test_data, test_labels);
    E_final(1,:) = E_final(1,:)+ E;
    Et_final(1,:) = Et_final(1,:) + Et;
end

dat_start = 1;
for i = 1:folds
    train_data = xi(:,dat_start:dat_start+dat_size-1);
    train_labels = tau(dat_start:dat_start+dat_size-1);
    test_data = xi(:,dat_start+dat_size:dat_start+(2*dat_size)-1);
    test_labels = tau(dat_start+dat_size:dat_start+(2*dat_size)-1);
    dat_start = dat_start + (2*dat_size);
    
    [E,Et] = grad_desc(t_max, train_data, train_labels, test_data, test_labels, a, b);
    E_final(2,:) = E_final(2,:)+ E;
    Et_final(2,:) = Et_final(2,:) + Et;
end

E_res = E_final/folds;
Et_res = Et_final/folds;
t = 1:t_max;

figure
colors = ['k','r', 'c', 'm', 'b'];
hold on
for i = 1:size(E_res,1)
    plot(t,E_res(i,:),['-' colors(i)])
    plot(t,Et_res(i,:),['--' colors(i)])
end



txt = sprintf('Gradient Descent - Cost Function (10-fold), P=%g, Q=%g', dat_size,dat_size);
title(txt)
xlabel('Epochs (t)')
ylabel('Mean Cost')
legend('E,\eta = 0.02', 'E_{test}, \eta = 0.02','E,\eta = 1/50t', 'E_{test},\eta = 1/50t')


