global T 
load('000.mat')
for T=0.05:0.01:0.05
T
for i=1:1:10
tol=1e-6;
% solinit.y = Z;solinit.x = tau;
solinit.y = sol.y;solinit.x = sol.x;
solinit.parameters = sol.parameters;
opts = odeset('Reltol',tol,'AbsTol',tol);
 sol = bvp4c(@transfer_odes33,@transfer_bcs,solinit,opts);
if sol.tol<tol
    save('000.mat','sol','tau','Z','T')
    break
end
Nt =500;
tau2 = linspace(0,1,Nt); 
tau=tau2;
Z = deval(sol,tau);
end
end
%---------------------------------------------------------------------------
%% Plots
figure(2)
subplot(1,2,1)
plotmoon2d
hold on;grid on ;axis equal
%%
y0=[1.18400000000000;0;0;0;-0.179200084278805;0];
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t,x]=ode45('vdp0',[0 3.43205599407947],y0,options);
plot(x(:,1),x(:,2),'r','LineWidth',2)

y0=[1.19600000000000;0;0;0;-0.283099790129557;0];
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t,x]=ode45('vdp0',[0 3.57380997277454],y0,options);
plot(x(:,1),x(:,2),'r','LineWidth',2)
plot(sol.y(1,:),sol.y(2,:),'b','LineWidth',1)
set(gca,'linewidth',1,'Fontname','Times New Roman','fontsize',20);
%%
subplot(1,2,2)
tr=sol.x/2.665314945662769e-06*sol.parameters;
% ax=acosd(-sol.y(8,:)./sqrt(sol.y(8,:).^2+sol.y(9,:).^2));
% ay=asind(-sol.y(9,:)./sqrt(sol.y(8,:).^2+sol.y(9,:).^2));
ax=atan2d(-sol.y(9,:),-sol.y(8,:));
plot(tr/86400,(ax),'LineWidth',2)
hold on
% plot(tr/86400,(ay),'LineWidth',2)
xlabel('day')
ylabel('{\it¦È} ¡ã')
grid on
% legend('ax','ay')
set(gca,'linewidth',1,'Fontname','Times New Roman','fontsize',20);
Z1=Z';
