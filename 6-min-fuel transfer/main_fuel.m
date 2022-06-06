clear all
global T xy tf
chr=['T=0.08,tf=6.1407,minfuel.mat'];
c=2000*9.8;T=0.08;tol=1e-6;
load(chr)
for i=1:1:50
xy=1e-14;
solinit.y =sol.y;solinit.x = sol.x;
opts = odeset('Reltol',tol,'AbsTol',tol);
sol = bvp4c(@transfer_odes34,@transfer_bcs2,solinit,opts);
if sol.tol<tol
    save('000.mat','sol','tf')
    break
end
end
%---------------------------------------------------------------------------
%% Plots
figure(1)
subplot(1,3,1)
plotmoon2d
axis equal
hold on;grid on

%%
y0=[1.18400000000000;0;0;0;-0.179200084278805;0];
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t,x]=ode45('vdp0',[0 3.43205599407947],y0,options);
plot(x(:,1),x(:,2),'r','LineWidth',2)

y0=[1.19600000000000;0;0;0;-0.283099790129557;0];
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t,x]=ode45('vdp0',[0 3.574561422058390],y0,options);
plot(x(:,1),x(:,2),'r','LineWidth',2)

plot(sol.y(1,:),sol.y(2,:),'b','LineWidth',1)

set(gca,'linewidth',1,'Fontname','Times New Roman','fontsize',20);
%%
subplot(1,3,2)
tr=tf*sol.x/2.665314945662769e-06;
ax=atan2d(-sol.y(9,:),-sol.y(8,:));
plot(tr/86400,(ax),'LineWidth',2)
hold on
xlabel('day');ylabel('{\it¦È} ¡ã')
grid on
set(gca,'linewidth',1,'Fontname','Times New Roman','fontsize',20);
subplot(1,3,3)
for n=1:length(sol.y)
rhox=1-sol.y(10,n)-norm([sol.y(8,n),sol.y(9,n)])*c/sol.y(5,n)*1e-3*366201.5728/3.75676967e5;
if rhox>xy
 u=0;
elseif rhox<-xy
    u=1;
else
    u=(xy-rhox)/2/xy;
end
uu(n)=u;
end
plot(tr/86400,uu,'LineWidth',2)
hold on
xlabel('day');ylabel('u')
grid on
axis([0,1.01*tr(end)/86400,-0.1,1.1])
set(gca,'linewidth',1,'Fontname','Times New Roman','fontsize',20);