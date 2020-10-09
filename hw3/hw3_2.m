%hw3_2 main code
%Mingju Liu
clc;
clear all;
load('points.mat');
m = 50;
n = 3; %150 points in total, 50 segments, 3 points in each segment
t = linspace(0,1,n);
T_tem = [t.^3 ;t.^2; t ;ones(1,length(t))];
T = repmat(T_tem,1,m); %matrix of t

cvx_begin
variables a3(m) a2(m) a1(m) a0(m) b3(m) b2(m) b1(m) b0(m)

for i = 1:1:m 
    coeff_x_tem(i,:) = [a3(i) a2(i) a1(i) a0(i)];
    coeff_y_tem(i,:) = [b3(i) b2(i) b1(i) b0(i)];
end
        
coeff_x = repelem(coeff_x_tem,n,1);
coeff_y = repelem(coeff_y_tem,n,1); %generate the coefficient of x and y in the model

for i = 1:1:size(p,1)
    Fx(i,1) = coeff_x(i,:)*T(:,i);
    Fy(i,1) = coeff_y(i,:)*T(:,i); %generate the parameter expression
end

minimize(norm(Fx - p(:,1)) + norm(Fy - p(:,2)))
subject to
for i=1:1:m-1
   tem1=n*i+1;
   tem2=tem1-1;
   3*coeff_x(tem2,1)+2*coeff_x(tem2,2)+coeff_x(tem2,3) == 3*coeff_x(tem1,1)+2*coeff_x(tem1,2)+coeff_x(tem1,3); %first derivative
   3*coeff_y(tem2,1)+2*coeff_y(tem2,2)+coeff_y(tem2,3) == 3*coeff_y(tem1,1)+2*coeff_y(tem1,2)+coeff_y(tem1,3);
   6*coeff_x(tem2,1)+2*coeff_x(tem2,2) == 6*coeff_x(tem1,1)+2*coeff_x(tem1,2); %second derivative
   6*coeff_y(tem2,1)+2*coeff_y(tem2,2) == 6*coeff_y(tem1,1)+2*coeff_y(tem1,2);
end
cvx_end


figure,
plot(Fx(:,1),Fy(:,1))
hold on;
plot(p(:,1),p(:,2));
legend('Fitted Curve','Original Curve');
xlabel('x-axis');
ylabel('y-axis');
title('river contour (Upside down)');