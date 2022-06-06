clear all; close all; clc;
%%
load('sol01.mat')
global T 
T=0.05;tol=1e-6;
tf =sol.x(end); 
Nt =200;
tau = linspace(0,1,Nt); 
yinit =[[1.18400000000000;0;0;-0.179200084278805;1500;...
    1;0;1;1;1]];
solinit = bvpinit(tau,yinit,tf);
zz=[1500;1;1;1;1;1].*[ones(6,length(tau))];
sol2=deval(sol,tau*tf);
solinit.x=tau;
solinit.y=[sol2([1,2,4,5],:);zz];
options = odeset('RelTol',tol,'AbsTol',tol);
sol = bvp4c(@transfer_odes33,@transfer_bcs,solinit,options);
Z = deval(sol,tau);
while sol.tol>tol
    solinit.y = Z;solinit.x = tau;
    sol = bvp4c(@transfer_odes33,@transfer_bcs,solinit,options);
    Z = deval(sol,tau);
end
    save('000.mat','sol','tau','Z','T')


%% Plots
figure(2)
subplot(1,2,1)
plot(sol.y(1,:),sol.y(2,:),'g','LineWidth',3)
hold on
grid on
grid minor;axis equal
xlabel('x');ylabel('y')

plotmoon2d

%%
y0=[1.18400000000000;0;0;0;-0.179200084278805;0];
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t,x]=ode45('vdp0',[0 3.43205599407947],y0,options);
plot(x(:,1),x(:,2),'r','LineWidth',2)

y0=[1.19600000000000;0;0;0;-0.283099790129557;0];
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t,x]=ode45('vdp0',[0 3.57380997277454],y0,options);
plot(x(:,1),x(:,2),'r','LineWidth',2)
set(gca,'linewidth',1,'fontsize',20);
%%
subplot(1,2,2)
tr=sol.x/2.665314945662769e-06;
ax=atan2d(-sol.y(9,:),-sol.y(8,:));
plot(tr/86400,(ax),'LineWidth',2)
hold on
xlabel('day')
ylabel('angle')
grid on
set(gca,'linewidth',1,'fontsize',20);

