function d = solve_online(d)
y0=d.p.y0;d.p.yz=y0';
for i=1:d.f.Ns-1
            ddt=d.p.dt*(i-1)/d.p.tf;if ddt>1;ddt=1; end
    rrx=deval(d.r,ddt);
    xr=rrx(1:5);
    ur=[1;atan2(-rrx(9),-rrx(8))];
    xe=y0-xr;d.p.xeZ=[d.p.xeZ,xe];
    F=[];G=[];
            for j=1:d.f.Nmpc
                F = [F;d.p.A_bar{i,j,1}];
                for jj=1:d.f.Nmpc
                    G{j,jj}=d.p.B_bar{i,j,jj};
                end
            end
G=cell2mat(G);
    %%
    Uu=kron(ones(d.f.Nmpc,1),d.p.u_max - ur);Ul=kron(ones(d.f.Nmpc,1),d.p.u_min - ur);
    Xu=kron(ones(5,1),d.p.xe_max);Xl=kron(ones(5,1),d.p.xe_min);
    si=size(d.f.Q_bar);
    d.f.Q_bar(si(1)-d.f.xdim+1:si(1),si(2)-d.f.xdim+1:si(2))=(d.p.Pf{i});
    
    opti = casadi.Opti();
    x = opti.variable(d.f.Nmpc*d.f.udim);xy = opti.variable(d.f.xdim*d.f.Nmpc);xyz=xy{end-d.f.xdim+1:end};
    opti.minimize(  xy'*d.f.Q_bar*xy+x'*d.f.R_bar*x   );
    opti.subject_to( xy==F*xe+G*x );
    opti.subject_to( Ul <=x<= Uu);
    opti.subject_to( Xl <=xy<= Xu);
    opti.subject_to( d.p.X_f{i}.A*xyz<=d.p.X_f{i}.b);
    
    p_opts = struct('print_time',false,'verbose',false);s_opts = struct('print_level',false);
    opti.solver('ipopt',p_opts,s_opts)
    so = opti.solve();x=so.value(x);d.p.xz=[d.p.xz,x(1:2)];
    %%
d.e.uu=(x(1)+ur(1));
rrdd=deg2rad(1)/3*randn;if abs(rrdd)>deg2rad(1); rrdd=0;end
alpha=(x(2)+ur(2))+rrdd;alphax=(x(2)+ur(2));
% alpha=(x(2)+ur(2))*(1.025-rand/20);alphax=(x(2)+ur(2));
% alpha=(x(2)+ur(2))*(1.05-rand/10);alphax=(x(2)+ur(2));
% alpha=(x(2)+ur(2));alphax=(x(2)+ur(2));
d.e.alpha1=cos(alpha);d.e.alpha2=sin(alpha);
%%
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
tspan=[d.p.dti  d.p.dti+d.p.dt];d.p.real_u=[d.p.real_u,[d.p.dti;ur(1);ur(2);d.e.uu;alpha;alphax]];
[t,y]=ode45(@(t,y) vdp2d(t,y,d),tspan,y0,options);  
d.p.dti=d.p.dti+d.p.dt;
y0=y(end,:)';d.p.yz=[d.p.yz;y0'];









end

