function fy=vdp4(t,x,Uxx,txx,Uxy,Uxz,Uyy,Uyz,Uzz)
fxx = interp1(txx,Uxx,t,'spline');
fxy=interp1(txx,Uxy,t,'spline');
fxz=interp1(txx,Uxz,t,'spline');
fyx=fxy;
fyy=interp1(txx,Uyy,t,'spline');
fyz=interp1(txx,Uyz,t,'spline');
fzx=fxz;
fzy=fyz;
fzz=interp1(txx,Uzz,t,'spline');
fy=[x(4);...
    x(5);...
    x(6);...
    fxx*x(1)+fxy*x(2)+fxz*x(3)+2*x(5);...
    fyx*x(1)+fyy*x(2)+fyz*x(3)-2*x(4);...
    fzx*x(1)+fzy*x(2)+fzz*x(3)];
%
end