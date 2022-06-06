function fy=vdp0(t,x)
m=0.01215;
r=[x(1);x(2);x(3)];re=[-m;0;0];rm=[1-m;0;0];
r1=norm(r-re);r2=norm(r-rm);
fy=[x(4);...
    x(5);...
    x(6);...
    x(1)+2*x(5)-(1-m)*(x(1)+m)/(r1)^3-m*(x(1)+m-1)/(r2)^3;...
    x(2)-2*x(4)-(1-m)*x(2)/(r1)^3-m*x(2)/(r2)^3;...
    -(1-m)*x(3)/(r1)^3-m*x(3)/r2^3];

end