function d = plot_figure(d)
yz=d.p.yz;real_u=d.p.real_u;
figure(1)
plot(yz(:,1),yz(:,2),'ok')
hold on
plot(d.r.y(1,:),d.r.y(2,:),'b','LineWidth',2)
axis equal
xlabel('x')
ylabel('y','rotation',0)

figure(2)
subplot(1,2,1)
plot(4.3481*real_u(1,:),real_u(2,:),'--r','LineWidth',3)
hold on
stairs(4.3481*real_u(1,:),real_u(4,:),'b','LineWidth',2)
grid on
grid minor
axis([0 1.05*4.34*max(real_u(1,:)) -0.1 1.1])
set(gca,'linewidth',1,'Fontname','Times New Roman','fontsize',20);
xlabel('t day')
ylabel('\itu','rotation',0)

subplot(1,2,2)
plot(4.3481*d.p.tf*d.r.x,atan2d(-d.r.y(9,:),-d.r.y(8,:)),':r','LineWidth',1)
hold on
stairs(4.3481*real_u(1,:),real_u(5,:)*180/pi,'-b','LineWidth',1)
% stairs(4.3481*real_u(1,:),real_u(6,:)*180/pi,'k','LineWidth',2)
grid on
grid minor
set(gca,'linewidth',1,'Fontname','Times New Roman','fontsize',20);
xlabel('t day')
ylabel('ж┴, бу','rotation',0)

end

