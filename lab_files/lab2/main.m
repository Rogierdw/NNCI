%% 
clear all
close all
clc

alphas = [0.1:0.1:5];
nD = 10;
nMax = 200;
N = 10;
errs = zeros(1, length(alphas));

for i = 1:length(alphas)
    alpha = alphas(i);
    for j = 1:nD
        P = round(N*alpha);
        [data, labels] = data_matrix2(P, N);
        w = minover(nMax, data, labels);
        errs(i) = errs(1) + calc_gen_error(w); 
    end
    errs(i) = errs(i) / nD;
end

plot(alphas,errs)

title('Minover learning curve - N = 10, n_D = 10, n_{max} = 200')
xlabel('\alpha (P/N)')
ylabel('Generalization error')
