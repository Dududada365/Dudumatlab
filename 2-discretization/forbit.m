function [B,X]=forbit(xx0)
mu=0.01215;options = odeset('RelTol',1e-9,'AbsTol',1e-12);
for ii=1:1
    x0=xx0([1:6]);
    [t,x]=ode45(@vdp0,[0,xx0(7)],x0,options);
    x=x';tf=t(end);num=length(t);
m=0.01215;
r=[x(1,num);x(2,num);x(3,num)];re=[-m;0;0];rm=[1-m;0;0];
r1=norm(r-re);r2=norm(r-rm);
f2=x(5,num);
f4=x(1,num)+2*x(5,num)-(1-m)*(x(1,num)+m)/(r1)^3-m*(x(1,num)+m-1)/(r2)^3;
f5=x(2,num)-2*x(4,num)-(1-m)*x(2,num)/(r1)^3-m*x(2,num)/(r2)^3;
f6=-(1-m)*x(3,num)/(r1)^3-m*x(3,num)/r2^3;
%
for i=1:1:num
Uxx(i)=(mu - 1)/((mu + x(1,i))^2 + x(2,i)^2 + x(3,i)^2)^(3/2) - mu/((mu + x(1,i) - 1)^2 + x(2,i)^2 + x(3,i)^2)^(3/2) + (3*mu*(2*mu + 2*x(1,i) - 2)*(mu + x(1,i) - 1))/(2*((mu + x(1,i) - 1)^2 + x(2,i)^2 + x(3,i)^2)^(5/2)) - ((6*mu + 6*x(1,i))*(mu + x(1,i))*(mu - 1))/(2*((mu + x(1,i))^2 + x(2,i)^2 + x(3,i)^2)^(5/2)) + 1;
Uxy(i)=(3*mu*x(2,i)*(mu + x(1,i) - 1))/((mu + x(1,i) - 1)^2 + x(2,i)^2 + x(3,i)^2)^(5/2) - (3*x(2,i)*(mu + x(1,i))*(mu - 1))/((mu + x(1,i))^2 + x(2,i)^2 + x(3,i)^2)^(5/2);
Uxz(i)=(3*mu*x(3,i)*(mu + x(1,i) - 1))/((mu + x(1,i) - 1)^2 + x(2,i)^2 + x(3,i)^2)^(5/2) - (3*x(3,i)*(mu + x(1,i))*(mu - 1))/((mu + x(1,i))^2 + x(2,i)^2 + x(3,i)^2)^(5/2);
Uyy(i)=(mu - 1)/((mu + x(1,i))^2 + x(2,i)^2 + x(3,i)^2)^(3/2) - mu/((mu + x(1,i) - 1)^2 + x(2,i)^2 + x(3,i)^2)^(3/2) - (3*x(2,i)^2*(mu - 1))/((mu + x(1,i))^2 + x(2,i)^2 + x(3,i)^2)^(5/2) + (3*mu*x(2,i)^2)/((mu + x(1,i) - 1)^2 + x(2,i)^2 + x(3,i)^2)^(5/2) + 1;
Uyz(i)=(3*mu*x(2,i)*x(3,i))/((mu + x(1,i) - 1)^2 + x(2,i)^2 + x(3,i)^2)^(5/2) - (3*x(2,i)*x(3,i)*(mu - 1))/((mu + x(1,i))^2 + x(2,i)^2 + x(3,i)^2)^(5/2);
Uzz(i)=(mu - 1)/((mu + x(1,i))^2 + x(2,i)^2 + x(3,i)^2)^(3/2) - mu/((mu + x(1,i) - 1)^2 + x(2,i)^2 + x(3,i)^2)^(3/2) - (3*x(3,i)^2*(mu - 1))/((mu + x(1,i))^2 + x(2,i)^2 + x(3,i)^2)^(5/2) + (3*mu*x(3,i)^2)/((mu + x(1,i) - 1)^2 + x(2,i)^2 + x(3,i)^2)^(5/2);
end
Uyx=Uxy;Uzx=Uxz;Uzy=Uyz;
tx=t;txx=tx;txy=tx;txz=tx;tyy=tx;tyz=tx;tzz=tx;
%%
tspan = [0 tf];
opts = odeset('RelTol',1e-8,'AbsTol',1e-12);
fd=[];
for ix=1:1:6
    x1=[0;0;0;0;0;0];
    x1(ix)=1;
    [t,y] = ode45(@(t,y) vdp4(t,y,Uxx,txx,Uxy,Uxz,Uyy,Uyz,Uzz), tspan, x1, opts);
    [m,n]=size(y);
    fd=[fd,y(m,1:6)'];
end

clear Uxx Uxy Uxz Uyx Uyy Uyz Uzx Uzy Uzz
end
a=fd;
M=a;
[X,B]=eig(M);
B=diag(B);
B=B;X=X;
end
 
