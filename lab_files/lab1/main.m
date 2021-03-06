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

N = 20;
alpha = 0.75:0.05:3.0;
n_D = 100;
n_max = 200;
c = 0;

y = zeros(size(alpha,2),n_D);
for j = 1:size(alpha,2) % For each alpha
    for k = 1:n_D       % for 
        P = int8(alpha(j)*N);
        [data, labels] = data_matrix(P, N);
        [~, success] = rosenblatt(n_max, data, labels, c);
        y(j,k) = success;
    end
end
res_m = mean(y,2);
res_se = std(y,0,2)/sqrt(size(y,2));

errorbar(alpha,res_m, res_se)
%y = mean(y,2);
%plot(alpha,y)


txt = sprintf('Rosenblatt perceptron training - N = %g, n_D = %gn n_{max} = %g, c = %g', N, n_D, n_max, c);
title(txt)
xlabel('\alpha (P/N)')
ylabel('Q_{l.s.}')


%% Bonus 1
clear all
close all

N = [5, 20, 50, 100];
alpha = 0.75:0.05:3.0;
n_D = 100;
n_max = 200;
y = zeros(size(N,2),size(alpha,2),n_D);
c = 0;
total = size(N,2)*size(alpha,2)*n_D;
now = 1;

for i = 1:size(N,2)
    for j = 1:size(alpha,2)
        for k = 1:n_D
            [data, labels] = data_matrix(round(alpha(j)*N(i)), round(N(i)));
            [~, success] = rosenblatt(n_max, data, labels, c);
            y(i,j,k) = success;
            
            now/total
            now = now+1;
        end
        %y(j,i) = y(j,i)/n_D
    end
end
res_m = mean(y,3);
res_se = std(y,0,3)/sqrt(size(y,3));

hold on
for i = 1:size(res_m,1)
    errorbar(alpha,res_m(i,:),res_se(i,:));
end
%y = mean(y,3);
%plot(alpha, y)

txt = sprintf('Rosenblatt perceptron training - n_D = %g, n_{max} = %g, c = %g', n_D, n_max, c);
title(txt)
xlabel('\alpha (P/N)')
ylabel('Q_{l.s.}')
legend('N = 5', 'N = 20', 'N = 50','N = 100')

%% Bonus 2
clear all
close all
clc

N = 20;
alpha = 0.75:0.25:3.0;
n_D = 100;
n_max = 200;
c = [-0.5, -0.25, 0, 0.25, 0.5];
y = zeros(size(c,2),size(alpha,2),n_D);

total = size(c,2)*size(alpha,2)*n_D;
now = 1;


for i = 1:size(c,2)
    for j = 1:size(alpha,2)
        for k = 1:n_D
            [data, labels] = data_matrix(round(alpha(j)*N), N);
            [~, success] = rosenblatt(n_max, data, labels, c(i));
            y(i,j,k) = success;
            
            now/total
            now = now+1;
        end
        %y(j,i) = y(j,i)/n_D;
    end
end

res_m = mean(y,3);
res_se = std(y,0,3)/sqrt(size(y,3));

hold on
for i = 1:size(res_m,1)
    errorbar(alpha,res_m(i,:),res_se(i,:));
end
%y = mean(y,3);
%plot(alpha, y)

txt = sprintf('Rosenblatt perceptron training - N = %g, n_D = %g, n_{max} = %g', N, n_D, n_max);
title(txt)
xlabel('\alpha (P/N)')
ylabel('Q_{l.s.}')
legend('c = -0.5','c = -0.25', 'c = 0.0', 'c = 0.25', 'c = 0.5')



