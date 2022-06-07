function d = solve_offline(d)
d.f.Q_bar=kron(eye(d.f.Nmpc),d.f.Q);
d.f.R_bar=kron(eye(d.f.Nmpc),d.f.R);
A_bar=cell(d.f.Ns,d.f.Nmpc,1);B_bar=cell(d.f.Ns,d.f.Nmpc,d.f.Nmpc);

for i=1:d.f.Ns
    i
    AAd=eye(d.f.xdim);
    for j=0:d.f.Nmpc-1
        if i+j>d.f.Ns
            xr=d.r.y([1:5],end);
            ur=[0;0];
        else
            ddt=d.p.dt*(i+j-1)/d.p.tf;if ddt>1;ddt=1;end
            rrx=deval(d.r,ddt);
            xr=rrx(1:5);
            ur=[1;atan2(-rrx(9),-rrx(8))];
        end
        [Ad,Bd]=AkBk(xr,ur,d.p.dt,d.p.T);Adk{j+1}=Ad;Bdk{j+1}=Bd;
        AAd=Ad*AAd;A_bar{i,j+1,1}=AAd;
    end
    [Kd,~,~] = dlqr(Ad, Bd, d.f.Q, d.f.R);
    Kd = -Kd; AK = Ad + Bd*Kd; d.p.Pf{i}= dlyap(AK',d.f.Q);
    ue_max = d.p.u_max - ur;ue_min = d.p.u_min - ur;
    H = [eye(d.f.xdim);-eye(d.f.xdim)];
    h = [d.p.xe_max;-d.p.xe_min];
    X_e = Polyhedron('A',H,'b',h);
    d.p.X_e = X_e;
    d = solve_terminal_set(Ad, Bd, ue_max, ue_min, d, i,d.f.Q,d.f.R,Kd);
    %%
    B_bar{i,2,1}=Adk{2}*Bdk{1};
    B_bar{i,3,1}=Adk{3}*Adk{2}*Bdk{1};B_bar{i,3,2}=Adk{3}*Bdk{2};
    B_bar{i,4,1}=Adk{4}*Adk{3}*Adk{2}*Bdk{1};B_bar{i,4,2}=Adk{4}*Adk{3}*Bdk{2};B_bar{i,4,3}=Adk{4}*Bdk{3};
    B_bar{i,5,1}=Adk{5}*Adk{4}*Adk{3}*Adk{2}*Bdk{1};B_bar{i,5,2}=Adk{5}*Adk{4}*Adk{3}*Bdk{2};B_bar{i,5,3}=Adk{5}*Adk{4}*Bdk{3};B_bar{i,5,4}=Adk{5}*Bdk{4};
    for u=1:d.f.Nmpc
        B_bar{i,u,u}=Bdk{u}; 
        for m=u+1:d.f.Nmpc
        B_bar{i,u,m}=zeros(d.f.xdim,d.f.udim);
        end
    end
    %%
end
d.p.A_bar=A_bar;d.p.B_bar=B_bar;




end

