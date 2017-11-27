clear all
close all
clc

[data, labels] = data_matrix(4,2);
[w, success] = rosenblatt(1000, data, labels)



%%
clear all
close all
clc

N = 5;
alpha = 0:0.2:5;
times = 10;
y = zeros(size(alpha,2),1);

for i = 1:size(N,2)
    for j = 1:size(alpha,2)
        for k = 1:times
            [data, labels] = data_matrix(int8(alpha(j)*N), int8(N));
            [w, success] = rosenblatt(1000, data, labels);
            y(j) = y(j) + success;
        end
        y(j) = y(j)/times;
    end
end
plot(alpha,y)

%%

N = [5, 20, 100];
alpha = 0:0.2:5;
times = 10;
y = zeros(size(alpha,2),1);

for i = 1:size(N,2)
    for j = 1:size(alpha,2)
        for k = 1:times
            [data, labels] = data_matrix(int8(alpha(j)*N(i)), int8(N(i)));
            [w, success] = rosenblatt(1000, data, labels);
            y(j) = y(j) + success;
        end
        y(j) = y(j)/times;
    end
end
plot(alpha,y)





