r=0.00452133; theta=0:pi/100:2*pi;
xx=r*cos(theta)+1-0.01215; yy=r*sin(theta);
rho=r*sin(theta);
fill(xx,yy,'y')