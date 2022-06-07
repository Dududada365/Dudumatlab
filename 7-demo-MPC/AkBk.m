function [Ad,Bd] = AkBk(x,u,dt,T)
% x=cell2mat(x);u=cell2mat(u);
con1=366201.5728e-3;con2=3.75676967e5;mu=0.01215;c=2000*9.8;
r1=sqrt((mu + x(1))^2 + x(2)^2 );r2=sqrt((mu + x(1) - 1)^2 + x(2)^2 );
Uxx=(mu - 1)/((mu + x(1))^2 + x(2)^2)^(3/2) - mu/((mu + x(1) - 1)^2 + x(2)^2)^(3/2) + (3*mu*(2*mu + 2*x(1) - 2)*(mu + x(1) - 1))/(2*((mu + x(1) - 1)^2 + x(2)^2)^(5/2)) - (3*(2*mu + 2*x(1))*(mu + x(1))*(mu - 1))/(2*((mu + x(1))^2 + x(2)^2)^(5/2)) + 1;
Uxy=3*(1-mu)*(x(1)+mu)*x(2)/r1^5+3*mu*(x(1)+mu-1)*x(2)/r2^5;
Uyy=(mu - 1)/((mu + x(1))^2 + x(2)^2)^(3/2) - mu/((mu + x(1) - 1)^2 + x(2)^2)^(3/2) - (3*x(2)^2*(mu - 1))/((mu + x(1))^2 + x(2)^2)^(5/2) + (3*mu*x(2)^2)/((mu + x(1) - 1)^2 + x(2)^2)^(5/2) + 1;
%%
fxu11=zeros(2);fxu12=eye(2);fxu13=zeros(2,1);fxu14=zeros(2);
fxu21=[Uxx,Uxy;Uxy,Uyy];fxu22=[0 2;-2 0];
fxu23=-T*u(1)*con1*x(5)^(-2)*[cos(u(2));sin(u(2))];
fxu24=[T/x(5)*con1*[cos(u(2));sin(u(2))],T*u(1)/x(5)*con1*[-sin(u(2));cos(u(2))]];
fxu31=zeros(1,2);fxu32=zeros(1,2);fxu33=0;fxu34=[-T/c*con2,0];
%大矩阵
fxu=[fxu11,fxu12,fxu13,fxu14;
    fxu21,fxu22,fxu23,fxu24;
    fxu31,fxu32,fxu33,fxu34];
Fx=fxu([1:5],[1:5]);%连续的A
Fu=fxu([1:5],[6:7]);%连续的B
%%
[Ad,Bd]=c2d(Fx,Fu,dt);
end