function d = solve_terminal_set(A_d, B_d, ue_max, ue_min, d, t,Q,R,Kd)
model = LTISystem('A',A_d,'B',B_d);
% constraints on inputs and states
model.u.min = ue_min;
model.u.max = ue_max;
model.x.min = d.p.xe_min;
model.x.max = d.p.xe_max;

% constraint sets represented as polyhedra
X = Polyhedron('lb',model.x.min,'ub',model.x.max);
% U = Polyhedron('lb',model.u.min,'ub',model.u.max);
model.x.penalty = QuadFunction(Q);
model.u.penalty = QuadFunction(R);
K = Kd;

autnmodel = LTISystem('A',A_d+B_d*K);
autnmodel.x.min = model.x.min;
autnmodel.x.max = model.x.max;
Kx = Polyhedron([K;-K],[model.u.max;-model.u.min]);
X0 = X.intersect(Kx);
for i=1:50
Xpre = autnmodel.reachableSet('X', X0, 'direction', 'backward');
XpreandX = Xpre.intersect(X0).minHRep();
XpreandX=outerApprox(XpreandX);
if XpreandX==X0
    break
else
    X0=XpreandX;
end
end

d.p.X_f{t,1} = XpreandX ; %终端约束集d.p.X_f是变化的


end