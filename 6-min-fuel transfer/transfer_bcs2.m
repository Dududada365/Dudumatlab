function PSI = transfer_bcs(Y0,Yf)

y0=[1.18400000000000;0;0;-0.179200084278805];
y1=[1.19600000000000;0;0;-0.283099790129557];

PSI = [Y0(1)-y0(1) % Initial Condition
Y0(2)-y0(2) % Initial Condition
Y0(3)-y0(3) % Initial Condition
Y0(4)-y0(4) % Initial Condition
Y0(5)-1500
Yf(1)-y1(1) % Final Condition
Yf(2)-y1(2) % Final Condition
Yf(3)-y1(3) % Final Condition
Yf(4)-y1(4) % Final Condition
Yf(10)-0];

return
