clc;
%%载入测试数据
X_test = xlsread('备选模态_变点实验数据.xlsx');
Xtest= X_test(:,1);

%%
Xmiu = mean(Xtest); % 按列求平均值
Xsigma = std(Xtest); % 求标准差
[X_row,X_col] = size(Xtest); % 求行列数

theta = 0.05;
X_row=500;
Yt_T(1,:)=10;

for i = 2:X_row     %r=i
    u = i/X_row;
    Yt_T(i,:) = Xtest(i,:)^0.5;%+randn(1);
    %Yt_T(i,:) = 10+randn(1);
    for j = 1:i-1     %l=j
        v = j/X_row;
        K1 = 0;
        K2 = 0;
        K3=0;
        for k = 1:j
            K1 = K1+exp(-0.5*(Yt_T(k,:)-(Xmiu/X_row+randn(1))).^2);
        end 
        for K = j+1:i
            K2 = K1+exp(-0.5*(Yt_T(k,:)-(Xmiu*((j+1)/X_row)+randn(1))).^2);
        end
        %%
        S_within(i,j) = 0.5*j^(-2)*K1+0.5*(i-j)^(-2)*K2;
        %%
        for k1 = 1:j
            for k2 = j+1:i
                K3=K3+exp(-0.5*(Yt_T(k1,:)-Yt_T(k2,:)).^2);
            end
        end
        %%
        S_between(i,j) = (j*(i-j))^(-1)*K3;
        K_T(i,j) = abs(S_within(i,j)-S_between(i,j))*2*v^2*(u-v)^2/(u^2);
        %%
    end
end
for g=1:X_row
    
    D_T (g,1)= max(K_T(g,:));
end
%%
figure(1)
plot(1:X_row,Yt_T,'b.'); 
title('Yt_T图像化');
xlabel('采样数');
ylabel('Yt_T');
hold on;

figure(2)
plot(1:X_row,D_T,'k'); 
title('D_T图像化');
xlabel('采样数');
ylabel('D_T');
hold on;

    