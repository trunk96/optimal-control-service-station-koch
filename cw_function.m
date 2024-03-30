function pol = cw_function(divisions,treshold, c_max, c_min, x_max, d)
close all
x = zeros(divisions,1);
c = zeros(divisions,1);
j=1;
delta_X = x_max/divisions;
x_0 = 0;
for i=1:divisions
    x(i) = x_0;
    if i<treshold
        c(i) = c_max;
    else
        c(i) = (c_max-c_min)/j;
        j=j+1;
    end
    x_0  = x_0 + delta_X;
end
plot(x, c);
pol = polyfit(x,c,d);
y = polyval(pol,x);
figure
plot(x, y)
end

