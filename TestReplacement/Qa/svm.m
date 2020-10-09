%Test Replacement Project Q1 main code

clear;
clc;

%load('feat_apple.mat');
%image = imread('myapple.jpeg');
load('feat_hand.mat');
image = imread('myhand.jpeg');
x = feature_f;
y = feature_b;
m = 5;
M = size(x,2);
N = size(y,2); 

cvx_begin
variables a(m) b u(M) v(N)
minimize((ones(1,M) * u + ones(1,N) * v))
subject to
a' * x - b >= 1 - u';
a' * y - b <= -(1 - v');
u >= 0;
v >= 0;
cvx_end;

figure
scatter3(x(3,:),x(4,:),x(5,:)) % foreground RGB 
xlabel('R value')
ylabel('G value')
zlabel('B value')
hold on;
scatter3(y(3,:),y(4,:),y(5,:)) % background RGB
xlabel('R value')
ylabel('G value')
zlabel('B value')
[X,Y] = meshgrid(0:255,0:255);
Z = (-b - a(3) * X - a(4) * Y)./a(5); %hyperplane
hold on;
surface(X,Y,Z)

figure,
imshow(image); %original image

figure,
im = double(image);
svmt = zeros(size(im,1),size(im,2));
for i = 1:size(im,1)
    for j = 1:size(im,2)
        svmt(i,j) = [i j im(i,j,1) im(i,j,2) im(i,j,3)]*a-b; 
    end
end

svmt = im2bw(svmt,0); %svm threshold
imshow(svmt);

level = graythresh(image);
sim = im2bw(image,level);
sim = -1 * double(sim);
sim = sim + 1;
figure
imshow(sim) %simple thresholding