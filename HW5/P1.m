%Problem 1
clc;
clear;

b = randn(3,1);
x = randn(3,1);

%backtracking searching
beta = rand(1);
alpha = 0.5*rand(1);
t = 1;

%generate positive martix with different condition number 
a = 2*rand(3,3)-1 + 2*rand(3,3)-1;     
a = a+a';  
c = 4;%condition number              
[U, S, V] = svd(a);
S = diag(S);           
S = S(1)*( 1-((c-1)/c)*(S(1)-S)/(S(1)-S(end))) ;
S = diag(S);           
A = U*S*V';

result = [];
result(1) = norm((A*x - b),2)^2;
thresh = 0.01;
Gd = 2*A'*A*x - 2*A'*b;
while norm(Gd) > thresh 
     Gd = 2*A'*A*x - 2*A'*b;
     if(norm((A*(x - t*Gd) - b),2)^2 > norm((A*x - b),2)^2 - alpha*t*(norm(Gd,2)^2))
         t = beta*t;
     else
         x = x - t*Gd;
         result = [result,norm((A*x - b),2)^2];
     end
end
plot(result,'-b')
xlabel('iteration')
ylabel('Result')
