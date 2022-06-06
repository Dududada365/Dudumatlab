clear all
clc
load('sol0.mat')
Ys=[];Yu=[];y1=[];
dt=linspace(0,tf,1000);
Z=deval(sol,dt);
save('position.mat','Z','dt')
for i=1:1:length(Z)
    i
    xx1=[Z(:,i);tf];
    [Yss,Yuu]=fmain(xx1);
    y1=[y1,Z(:,i)];
    Ys=[Ys,Yss];Yu=[Yu,Yuu];
end
save('all.mat','y1','Ys','Yu') %copy to Folder "3.1 and 3.2"