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
        [data, labels] = data_matrix2(P,N);
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
        [data, labels] = data_matrix2(P,N);
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
        [data, labels] = data_matrix2(P,N);
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


