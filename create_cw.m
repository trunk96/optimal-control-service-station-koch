function [x, c] = create_cw(divisions, c_nom, u_nom, x_max)
close all
x = linspace(0,x_max,divisions);
c = linspace(c_nom*(1+u_nom),c_nom*(1+u_nom-x_max),divisions);
plot(x, c);
end

