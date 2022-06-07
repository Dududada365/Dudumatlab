clear all;clc
load('0.08_time_multi.mat')

d.r=sol;d.p.T=0.08;
d.f.Ns=100;

d.p.tf=d.r.parameters;d.p.dt=d.p.tf/(d.f.Ns-1);
d.p.xz=[];d.p.dti=0;d.p.real_u=[];d.p.xeZ=[];

d.f.Q=diag([1e6,1e6,1e6,1e6,1e0]);
d.f.R=1e-2*eye(2);

d.f.Nmpc=5;d.f.xdim=5;d.f.udim=2;

d.p.u_max = [1;pi];
d.p.u_min = [0;-pi];

d.p.xe_max=1e-3*[1;1;1;1;1];
d.p.xe_min=-1e-3*[1;1;1;1;1];

d=solve_offline(d);
save('000.mat','d')
load('000.mat')
d.p.y0=[1.1841;0;0;-0.179200084278805;1500];
d=solve_online(d);

plot_figure(d);
