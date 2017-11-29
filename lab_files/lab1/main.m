clear all
close all
clc

[data, labels] = data_matrix(3,2);
[w, success] = rosenblatt(1000, data, labels)



%%
clear all
close all
clc

N = 20;
alpha = 0.75:0.25:3.0;
n_D = 50;
n_max = 100;
y = zeros(size(alpha,2),1);

for j = 1:size(alpha,2) % For each alpha
    for k = 1:n_D       % for 
        P = int8(alpha(j)*N);
        [data, labels] = data_matrix(P, N);
        [w, success] = rosenblatt(n_max, data, labels);
        y(j) = y(j) + success;
    end
    y(j) = y(j)/n_D;
end
plot(alpha,y)
title('Rosenblatt perceptron training - percentage succcesfull')
xlabel('\alpha (P/N)')
ylabel('Q_{l.s.}')

%%

N = [5, 20, 100];
alpha = 0.75:0.25:3.0;
n_D = 50;
n_max = 100;
y = zeros(size(alpha,2),1);

for i = 1:size(N,2)
    for j = 1:size(alpha,2)
        for k = 1:n_D
            [data, labels] = data_matrix(int8(alpha(j)*N(i)), int8(N(i)));
            [w, success] = rosenblatt(n_max, data, labels);
            y(j) = y(j) + success;
        end
        y(j) = y(j)/n_D;
    end
end
plot(alpha,y)





