%hw3_2 ginput
%Mingju Liu
clc
clear all
image=imread('curved_river_wikipedia.jpg');
figure;
imshow(image);
p=ginput;
save('points.mat','p');