function dX_dtau = vdp2d(t,x,d)
T=d.p.T;uu=d.e.uu;alpha1=d.e.alpha1;alpha2=d.e.alpha2;
mu=0.01215;
r=[x(1);x(2)];re=[-mu;0];rm=[1-mu;0];
r1=norm(r-re);r2=norm(r-rm);c=2000*9.8;
%%
dx_dtau = x(3);
dy_dtau = x(4);
dvx_dtau = x(1)+2*x(4)-(1-mu)*(x(1)+mu)/r1^3-mu*(x(1)+mu-1)/r2^3+T*uu/x(5)*alpha1*1e-3*366201.5728;
dvy_dtau = x(2)-2*x(3)-(1-mu)*x(2)/r1^3-mu*x(2)/r2^3+T*uu/x(5)*alpha2*1e-3*366201.5728;
dm_dtau = -T*uu/c*3.75676967e5;


dX_dtau = [dx_dtau; dy_dtau; dvx_dtau; dvy_dtau;dm_dtau];

