%Test Replacement Project Q1 ginput extraction

clear
clc

%data=imread('myapple.jpeg');
data=imread('myhand.jpeg');
%get the foreground label
figure 
image(data)
[x, y] = ginput(150);
hold on
plot(x, y, '-wx')
pixels_f = impixel(data,x,y);
feature_f=[x y pixels_f]';
%save('feat_apple.mat','feature_f');
save('feat_hand.mat','feature_f');

%get the background label
figure
image(data)
[m,n]=ginput(150);
hold on
plot(m, n, '-yx')
pixels_b = impixel(data,m,n);
feature_b=[m n pixels_b]';
%save('feat_apple.mat','feature_b','-append');
save('feat_hand.mat','feature_b','-append');