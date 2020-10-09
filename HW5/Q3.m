%%%Q3.m%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
load('initialization3.mat')

w = (inv(C))*d;
result = [0];
result(1) = norm((A*w - b),2)^2;
thresh = 0.01;
t_q3 = 1;
Miu = 2;

while (3/t_q3) >= thresh
    cvx_begin
        variable w_buff(3) nonnegative
        minimize t_q3*(w_buff'*A'*A*w_buff-2*b'*A*w_buff+b'*b) -sum(log(P(1,:)*w_buff - q(1))+log(P(2,:)*w_buff - q(2))+log(P(3,:)*w_buff - q(3)))
    cvx_end
    w = w_buff;
    result = [result,norm((A*w - b),2)^2];
    t_q3 = Miu*t_q3;
end
plot(result,'-*b')
ylabel('Loss')
