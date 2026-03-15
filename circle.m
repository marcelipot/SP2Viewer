function hCircle = circle(x, y, rx, ry, color, axeEC);

% hold on
th = 0:pi/50:2*pi;
xunit = rx * cos(th) + x;
yunit = ry * sin(th) + y;
% hCircle = plot(axeEC, xunit, yunit, 'color', color);
hCircle = fill(axeEC, xunit, yunit, color);
% hold off