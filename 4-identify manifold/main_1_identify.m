clear all;clc
load('result_u.mat')
plot(Uvx1,Uvy1,'.b')
hold on
plot(Uvx2,Uvy2,'.b')
hold on
%%
load('result_s.mat')
plot(Svx1,Svy1,'.r')
hold on
plot(Svx2,Svy2,'.r')
hold on
% axis equal