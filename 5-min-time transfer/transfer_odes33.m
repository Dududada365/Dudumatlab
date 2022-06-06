function dX_dtau = transfer_odes33(tau,x,tf)
mu=0.01215;
global T
r=[x(1);x(2)];re=[-mu;0];rm=[1-mu;0];
r1=norm(r-re);r2=norm(r-rm); u=1;c=2000*9.8;
alpha1=-x(8)/norm([x(8),x(9)]);
alpha2=-x(9)/norm([x(8),x(9)]);
%%
dx_dtau = x(3)*tf;
dy_dtau = x(4)*tf;
dvx_dtau = (x(1)+2*x(4)-(1-mu)*(x(1)+mu)/r1^3-mu*(x(1)+mu-1)/r2^3+T*u/x(5)*alpha1*1e-3*366201.5728)*tf;
dvy_dtau = (x(2)-2*x(3)-(1-mu)*x(2)/r1^3-mu*x(2)/r2^3+T*u/x(5)*alpha2*1e-3*366201.5728)*tf;
dm_dtau = (-T*u/c*3.75676967e5)*tf;

dpx_dtau = (- x(9)*((3*mu*x(2)*(2*mu + 2*x(1) - 2))/(2*(r2^2)^(5/2)) - (3*x(2)*(2*mu + 2*x(1))*(mu - 1))/(2*(r1^2)^(5/2))) - x(8)*((mu - 1)/(r1^2)^(3/2) - mu/(r2^2)^(3/2) + (3*mu*(2*mu + 2*x(1) - 2)*(mu + x(1) - 1))/(2*(r2^2)^(5/2)) - (3*(2*mu + 2*x(1))*(mu + x(1))*(mu - 1))/(2*(r1^2)^(5/2)) + 1))*tf;
dpy_dtau = (- x(9)*((mu - 1)/(r1^2)^(3/2) - mu/(r2^2)^(3/2) - (3*x(2)^2*(mu - 1))/(r1^2)^(5/2) + (3*mu*x(2)^2)/(r2^2)^(5/2) + 1)+x(8)*((3*x(2)*(mu + x(1))*(mu - 1))/(r1^2)^(5/2) - (3*mu*x(2)*(mu + x(1) - 1))/(r2^2)^(5/2)))*tf ;
dpvx_dtau = (-x(6)+2*x(9))*tf;
dpvy_dtau = (-x(7)-2*x(8))*tf;
dpm_dtau = (-T/x(5)^2*(norm([x(8),x(9)]))*1e-3*366201.5728)*tf;

dX_dtau = [dx_dtau; dy_dtau; dvx_dtau; dvy_dtau;dm_dtau; ...
dpx_dtau; dpy_dtau; dpvx_dtau;dpvy_dtau;dpm_dtau];

return
