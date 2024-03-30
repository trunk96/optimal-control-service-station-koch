function plot_custom_time_series(x, ts, y_label, x_label, style)
if nargin == 4
plot(x, ts,'k',  'LineWidth',4, 'DurationTickFormat', 'hh:mm')
else
    plot(x, ts,'k',  'LineWidth',4, 'LineStyle', style, 'DurationTickFormat', 'hh:mm')
end
grid on
ylabel(y_label, 'FontSize',12,'FontWeight','bold')
xlabel(x_label, 'FontSize',12,'FontWeight','bold')
ax = gca;
ax.FontWeight = 'bold';
ax.FontSize = 40;
set(gcf,'color','white')
title('')
end
