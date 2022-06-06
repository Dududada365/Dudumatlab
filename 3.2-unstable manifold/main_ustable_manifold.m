clear all;clc
load('all.mat')
d=50/384400;lo=1;tf=4;
options = odeset('RelTol',1e-12,'AbsTol',1e-12,'Events','my2');
Uvy1=[];Ux1=[];Uvx1=[];Uy1=[];num1=[];tf1=[];
Uvy2=[];Ux2=[];Uvx2=[];Uy2=[];num2=[];tf2=[];
figure(1)
grid on
axis equal
xlabel('x');ylabel('y')
for i=1:lo:length(Ys)
%% unstable -
y0=y1(:,i);
y0=y0-d*Yu(:,i);
sol=ode45(@vdp0,[0 tf],y0,options);
for j=1:1:length(sol.ie)
    %%
    if sol.ye(1,j)<0.98785 && sol.ye(1,j)>0.88
    [t,xx]=ode45(@vdp0,[0 sol.xe(j)],y0,options);
    plot(xx(:,1),xx(:,2),'b','LineWidth',0.1)
    hold on;axis equal
    %%
   Uvy1=[Uvy1,sol.ye(5,j)];
   Uy1=[Uy1,sol.ye(2,j)];
   Uvx1=[Uvx1,sol.ye(4,j)];
   Ux1=[Ux1,sol.ye(1,j)];
   tf1=[tf1,sol.xe(j)];
   num1=[num1,ones(1,j)*i];
    end
end
%% unstable +
y0=y1(:,i);
y0=y0+d*Yu(:,i);
sol=ode45(@vdp0,[0 tf],y0,options);
for j=1:1:length(sol.ie)
    %%
    if sol.ye(1,j)<0.98785 && sol.ye(1,j)>0.88
    [t,xx]=ode45(@vdp0,[0 sol.xe(j)],y0,options);
    plot(xx(:,1),xx(:,2),'b','LineWidth',0.1)
    %%
   Uvy2=[Uvy2,sol.ye(5,j)];
   Uy2=[Uy2,sol.ye(2,j)];
   Uvx2=[Uvx2,sol.ye(4,j)];
   Ux2=[Ux2,sol.ye(1,j)];
   tf2=[tf2,sol.xe(j)];
   num2=[num2,ones(1,j)*i];
end
end
end
figure(2)
plot(Uvx1,Uvy1,'.b') % x vx; x vy ;vx vy
hold on
plot(Uvx2,Uvy2,'.b')
hold on

save('result_u.mat','Uvy1','Ux1','Uvx1','Uy1','num1','tf1',...
    'Uy2','Uvy2','Ux2','Uvx2','num2','tf2')

% copy to Floder '4-identify manifold'




