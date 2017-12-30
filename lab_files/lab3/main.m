%% Main assignment, single training, 10-fold still needed
clear all
close all

load data3.mat

t_max = 40;
folds = 10;

dat_size=size(xi,2)/(2*folds);
P = t_max*dat_size;
E_final = zeros(folds,P);
Et_final = zeros(folds,P);

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
t = 1:size(E_res,2);
res = [E_res;Et_res];
figure
plot(t,res)

title('Gradient Descent - Cost Function (10-fold)')
xlabel('Epochs (t)')
ylabel('Mean Cost')
legend('E', 'E_{test}')