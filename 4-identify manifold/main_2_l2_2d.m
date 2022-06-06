clear all
% y0=[1.13094873117452;0.100748803075929;-1.26704449294213e-26;0.0639376687593907;0.0176801908714712;4.98492892161383e-26];tf=3.68902167457007;
% y0=[1.13072886540582;-0.100686410248537;-1.36840864217381e-20;-0.0636092727387474;0.0187845627963058;5.69988997970544e-21];tf=-3.69022925757530;
y0=[1.18400000000000,0,0,0,-0.188988946131820,0];tf=5.601494791392805;

options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t,x]=ode45('vdp0',[0 tf],y0,options);
sol=ode45(@vdp0,[0 tf],y0,options);
% sol1=sol;save('1.mat','sol1')
% sol2=ode45(@vdp0,[0 -tf],sol.y(:,end),options);save('2.mat','sol2')

figure(1)
plot(x(:,1),x(:,2),'k','LineWidth',2)
grid on
hold on
axis equal
xlabel('x')
ylabel('y')
y0=[1.18400000000000;0;0;0;-0.179200084278805;0];
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t1,x1]=ode45('vdp0',[0 3.43205599407947],y0,options);
plot(x1(:,1),x1(:,2),'--b','LineWidth',1)
%%
plotmoon2d

set(gca,'linewidth',1,'Fontname','Times New Roman','fontsize',20);

save('sol01.mat','sol') %copy to Floder "5-min-time transfer"