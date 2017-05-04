x = -2:1/1000:8;
f = (x.^2 + 10) ./ (sin(x)+1.2);
plot(x,f);
hold on;
pts = [-2 0 2 4 6 8];
ft = interp1(x,f,pts);
plot(pts,ft, '--');