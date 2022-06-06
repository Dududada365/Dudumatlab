function PSI = transfer_bcs(Y0,Yf,tf)
global T 
y0=[1.18400000000000;0;0;-0.179200084278805];
y1=[1.19600000000000;0;0;-0.283099790129557];

mu=0.01215;
alpha1=-Yf(8)/norm([Yf(8),Yf(9)]);
alpha2=-Yf(9)/norm([Yf(8),Yf(9)]); u=1;c=2000*9.8;

r1=sqrt((Yf(1)+mu)^2+Yf(2)^2);
r2=sqrt((Yf(1)-1+mu)^2+Yf(2)^2);


PSI = [Y0(1)-y0(1) % Initial Condition
Y0(2)-y0(2) % Initial Condition
Y0(3)-y0(3) % Initial Condition
Y0(4)-y0(4) % Initial Condition
Y0(5)-1500
Yf(1)-y1(1) % Final Condition
Yf(2)-y1(2) % Final Condition
Yf(3)-y1(3) % Final Condition
Yf(4)-y1(4) % Final Condition

Yf(6)*Yf(3)+Yf(7)*Yf(4)+Yf(8)*(Yf(1)+2*Yf(4)-(1-mu)*(Yf(1)+mu)/r1^3-mu*(Yf(1)+mu-1)/r2^3+T*u/Yf(5)*alpha1*1e-3*366201.5728)+Yf(9)*(Yf(2)-2*Yf(3)-(1-mu)*Yf(2)/r1^3-mu*Yf(2)/r2^3+T*u/Yf(5)*alpha2*1e-3*366201.5728)-Yf(10)*T*u/c*3.75676967e5+1-0;

Yf(10)-0];

return
