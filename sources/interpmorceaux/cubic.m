xi = -3:1/1000:3;

x = -3:1:3;
y = [-1 -1 -1 0 1 1 1];

cu = pchip(x,y,xi);
sp = spline(x,y,xi);

plot(xi, cu, '', xi, sp, '--');