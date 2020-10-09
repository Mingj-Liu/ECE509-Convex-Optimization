%%%%%%%%Q2.m%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
load('initialization2.mat')

w = (inv(C))*d;
result = [0];
result(1) = norm((A*w - b),2)^2;
thresh = 0.01;

Grad1 = 2*A'*A*w - 2*A*b;
Grad2 = 2*A'*A;
linda = Grad1'*(inv(Grad2))*Grad1;
while linda/2 > thresh
    Grad1 = 2*A'*A*w - 2*A*b;
    Grad2 = 2*A'*A;
    linda = Grad1'*(inv(Grad2))*Grad1;
    if(norm((A*(w - t*Grad1) - b),2)^2 > norm((A*w - b),2)^2 - alpha*t*(norm(Grad1,2)^2))
        t = beta*t;
    else
        w = w - t*(inv(Grad2))*Grad1;
        result = [result,norm((A*w - b),2)^2];
    end
end
plot(result,'-*b')
ylabel('Loss')