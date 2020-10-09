%%%%%%%%%%Q1.m%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
load('initialization.mat')

%Grad = 2*A*2 - 2*b'*A;
result = [0];
%result(1) = norm((A*w - b),2)^2;
result(1) = norm((A*w - b),2)^2;
%Number of iterations = 2
thresh = 0.01;
Grad = 2*A'*A*w - 2*A*b;
while norm(Grad) > thresh 
     Grad = 2*A'*A*w - 2*A*b;
     if(norm((A*(w - t*Grad) - b),2)^2 > norm((A*w - b),2)^2 - alpha*t*(norm(Grad,2)^2))
         t = beta*t;
     else
         w = w - t*Grad;
         result = [result,norm((A*w - b),2)^2];
     end
end
plot(result,'-*b')
ylabel('Loss')
