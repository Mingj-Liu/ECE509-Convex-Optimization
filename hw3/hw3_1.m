%hw3_1 main code
%Mingju Liu
clc
clear all
img = imread('cguitar.tif');
figure;
imshow(img); %display the corrupted picture
title('corrupted guitar')
imgd = double(img); %convert to double format

e = zeros(249,49); %generate the upper left corner coordinates and real image RGB value
for i = 1:1:49
    for j = 1:1:249
        e(j,i) = 255;
    end
end

x = 1:249;
y = 1:49;
[X,Y] = meshgrid(x,y); %generate i,j in the ai + bj + c

cvx_begin
    variables a b c
    minimize(norm(e.*(a*X'+b*Y'+c) - imgd(1:249,1:49)))
    subject to 
        0 <= (a*X'+b*Y'+c) <= 1
cvx_end

for i = 1:1:size(img,1)
    for j = 1:1:size(img,2)
        e_c(i,j) = img(i,j)/(a*i+b*j+c); % to return to the corrected image
    end
end

figure;
imshow(e_c);
title('corrected guitar');