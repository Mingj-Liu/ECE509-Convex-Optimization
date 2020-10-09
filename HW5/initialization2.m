%%%%%%%%%%initialization_q2.m%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
%initialize bias
b = randn(3,1);
%calculate step size;
%backtracking searching
beta = rand(1);
alpha = 0.5*rand(1);
t = 1;
%generate positive martix with different
%condition number 
a = 2*rand(3,3)-1 + 2*rand(3,3)-1;     
a = a+a';  
%condition number
C = 2;              
[u s v] = svd(a);
s = diag(s);           
s = s(1)*( 1-((C-1)/C)*(s(1)-s)/(s(1)-s(end))) ;
s = diag(s);           
A = u*s*v';

C = randn(3,3);
d = randn(3,1);save('initialization2.mat')

