%Problem 2
clc;
clear;

b = randn(3,1);

%backtracking searching
beta = rand(1);
alpha = 0.5*rand(1);
t = 1;

%generate positive martix with different
%condition number 
a = 2*rand(3,3)-1 + 2*rand(3,3)-1;     
a = a+a';  
c = 2;%condition number              
[U, S, V] = svd(a);
S = diag(S);           
S = S(1)*( 1-((c-1)/c)*(S(1)-S)/(S(1)-S(end))) ;
S = diag(S);           
A = U*S*V';

p = randn(3,3);
q = randn(3,1);

x = (inv(p))*q;
result = [];
result(1) = norm((A*x - b),2)^2;
thresh = 0.01;

Gd1 = 2*A'*A*x - 2*A'*b;
Gd2 = 2*A'*A;
lambda = Gd1'*(inv(Gd2))*Gd1;
while (lambda/2)^2 > thresh
    Gd1 = 2*A'*A*x - 2*A'*b;
    Gd2 = 2*A'*A;
    lambda = Gd1'*(inv(Gd2))*Gd1;
    if(norm((A*(x - t*Gd1) - b),2)^2 > norm((A*x - b),2)^2 - alpha*t*(norm(Gd1,2)^2))
        t = beta*t;
    else
        x = x - t*(inv(Gd2))*Gd1;
        result = [result,norm((A*x - b),2)^2];
    end
end
plot(result,'-')
xlabel('iteration')
ylabel('Result')