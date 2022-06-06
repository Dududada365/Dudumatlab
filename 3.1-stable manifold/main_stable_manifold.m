clear all;clc
load('all.mat')
d=50/384400;lo=1;tf=-4;
options = odeset('RelTol',1e-12,'AbsTol',1e-12,'Events','my2');
Svy1=[];Sx1=[];Svx1=[];Sy1=[];num1=[];tf1=[];
Svy2=[];Sx2=[];Svx2=[];Sy2=[];num2=[];tf2=[];
figure(1)
grid on
axis equal
xlabel('x');ylabel('y')
for i=1:lo:length(Ys)
%% stable -
y0=y1(:,i);
y0=y0-d*Ys(:,i);
sol=ode45(@vdp0,[0 tf],y0,options);
for j=1:1:length(sol.ie)
    %%
      if sol.ye(1,j)<0.98785 && sol.ye(1,j)>0.88
    [t,xx]=ode45(@vdp0,[0 sol.xe(j)],y0,options);
    plot(xx(:,1),xx(:,2),'r','LineWidth',0.1)
    hold on;axis equal
    %%
   Svy1=[Svy1,sol.ye(5,j)];
   Sy1=[Sy1,sol.ye(2,j)];
   Svx1=[Svx1,sol.ye(4,j)];
   Sx1=[Sx1,sol.ye(1,j)];
   tf1=[tf1,sol.xe(j)];
   num1=[num1,ones(1,j)*i];
 end
end
%% stable +
y0=y1(:,i);
y0=y0+d*Ys(:,i);
sol=ode45(@vdp0,[0 tf],y0,options);
for j=1:1:length(sol.ie)
    %%
        if sol.ye(1,j)<0.98785 && sol.ye(1,j)>0.88
    [t,xx]=ode45(@vdp0,[0 sol.xe(j)],y0,options);
    plot(xx(:,1),xx(:,2),'r','LineWidth',0.1)
    %%
   Svy2=[Svy2,sol.ye(5,j)];
   Sy2=[Sy2,sol.ye(2,j)];
   Svx2=[Svx2,sol.ye(4,j)];
   Sx2=[Sx2,sol.ye(1,j)];
   tf2=[tf2,sol.xe(j)];
   num2=[num2,ones(1,j)*i];
 end
end
end
figure(2)
plot(Svx1,Svy1,'.r')
hold on
plot(Svx2,Svy2,'.r')
hold on

save('result_s.mat','Svy1','Sx1','Svx1','Sy1','num1','tf1',...
    'Sy2','Svy2','Sx2','Svx2','num2','tf2') 
% copy to Floder '4-identify manifold'





