%% Single training with visual
clear all
close all
clc

[data, labels] = data_matrix(3,2);
[w, success] = rosenblatt(1000, data, labels, 0)



%% Assignment
clear all
close all
clc

N = 20;
alpha = 0.75:0.25:3.0;
n_D = 50;
n_max = 100;
c = 0;

y = zeros(size(alpha,2),1);
for j = 1:size(alpha,2) % For each alpha
    for k = 1:n_D       % for 
        P = int8(alpha(j)*N);
        [data, labels] = data_matrix(P, N);
        [w, success] = rosenblatt(n_max, data, labels, c);
        y(j) = y(j) + success;
    end
    y(j) = y(j)/n_D;
end
plot(alpha,y)

title('Rosenblatt perceptron training - N = 20, n_D = 50, n_{max} = 100, c = 0')
xlabel('\alpha (P/N)')
ylabel('Q_{l.s.}')

%% More alpha, higher n_D, higher n_max
clear all
close all
clc

N = 20;
alpha = 0.75:0.05:3.0;
n_D = 100;
n_max = 200;
c = 0;

y = zeros(size(alpha,2),1);
for j = 1:size(alpha,2) % For each alpha
    for k = 1:n_D       % for 
        P = int8(alpha(j)*N);
        [data, labels] = data_matrix(P, N);
        [w, success] = rosenblatt(n_max, data, labels, c);
        y(j) = y(j) + success;
    end
    y(j) = y(j)/n_D;
end
plot(alpha,y)



title('Rosenblatt perceptron training - N = 20, n_D = 100, n_{max} = 200, c = 0')
xlabel('\alpha (P/N)')
ylabel('Q_{l.s.}')


%% Bonus 1
clear all
close all
clc

N = [5, 20, 50, 100];
alpha = 0.75:0.05:3.0;
n_D = 100;
n_max = 200;
y = zeros(size(alpha,2),size(N,2));
c = 0;

for i = 1:size(N,2)
    for j = size(alpha,2):-1:1
        for k = 1:n_D
            [data, labels] = data_matrix(int8(alpha(j)*N(i)), int8(N(i)));
            [w, success] = rosenblatt(n_max, data, labels, c);
            y(j,i) = y(j,i) + success;
        end
        y(j,i) = y(j,i)/n_D;
    end
end

plot(alpha, y)

title('Rosenblatt perceptron training - n_D = 100, n_{max} = 200, c = 0')
xlabel('\alpha (P/N)')
ylabel('Q_{l.s.}')
legend('N = 5', 'N = 20', 'N = 50','N = 100')




