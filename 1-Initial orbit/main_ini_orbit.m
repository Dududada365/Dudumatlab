clear all;clc
y0=[1.18400000000000;0;0;0;-0.179200084278805;0];tf=3.43205599407947;
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t,x]=ode45('vdp0',[0 tf],y0,options);
sol=ode45(@vdp0,[0 tf],y0,options);

figure(1)
plot(x(:,1),x(:,2),'r','LineWidth',2)
grid on;hold on;axis equal
xlabel('x');ylabel('\ity','Rotation',0)
%%
plotmoon2d
set(gca,'linewidth',1,'Fontname','Times New Roman','fontsize',20);
save('sol0.mat','sol','tf') % copy to Folder "2-discretization"