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
    %errs(i) = errs(i) / nD;
end
errs = errs / nD;

plot(alphas,errs)

title('Minover learning curve - N = 20, n_D = 10, n_{max} = 200')
xlabel('\alpha (P/N)')
ylabel('Generalization error')

%% Comparison with rosenblatt
clear all
close all
clc

alphas = 0.1:0.1:5;
nD = 10;
nMax = 200;
N = 50;
errs = zeros(2,length(alphas));

for i = 1:length(alphas)
    P = int8(N*alphas(i));
    for j = 1:nD
        [data, labels] = data_matrix2(P,N);
        w = minover(nMax, data, labels);
        errs(1,i) = calc_gen_error(w);
        
        w = rosenblatt(nMax, data, labels, 0);
        errs(2,i) = calc_gen_error(w);
    end
end
errs = errs / nD;

plot(alphas,errs)

title('Perceptron learning curve - N = 50, n_D = 10, n_{max} = 200')
xlabel('\alpha (P/N)')
ylabel('Generalization error')
legend('Minover', 'Rosenblatt')

