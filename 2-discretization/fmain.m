function [Ys,Yu]=fmain(xx1)
[B,X]=forbit(xx1);
[minS,indexS]=min(real(B));
[maxU,indexU]=max(real(B));
YS=real(X(:,indexS));
Ys=YS/norm([YS(1),YS(2),YS(3)]);
YU=real(X(:,indexU));
Yu=YU/norm([YU(1),YU(2),YU(3)]);
YS0=YS;YU0=YU;

     