%plot_script
close all
figure
plot_custom_time_series(w_r_out, 'w_{ev} [kW]', 'time [h]')
figure
plot_custom_time_series(w_ev_out, 'w_{ev} [kW]', 'time [h]')
figure
plot_custom_time_series(u_out, 'Power [kW]', 'time [h]')
figure
plot_custom_time_series(x_out, 'SOC [kWh]', 'time [h]')
figure
plot_custom_time_series(p_out, 'Power [kW]', 'time [h]')
figure
plot_custom_time_series(w_ev_out, '[kW]', 'time [h]')
hold on
plot_custom_time_series(w_r_out, 'Tracking Performances [kW]', 'time [h]', '--')
hold off
figure
plot_custom_time_series(w_pv_out, 'Power [kW]', 'time [h]', '--')
% t = [0:1:numel(w_pv)-1] * 15 * 60;
% t = seconds(t);
% t.Format = 'h';
% plot(t, w_pv ,'k',  'LineWidth',4)
% grid on
% ylabel('w_{pv} [kW]', 'FontSize',12,'FontWeight','bold')
% xlabel('time [h]', 'FontSize',12,'FontWeight','bold')
% ax = gca;
% ax.FontWeight = 'bold';
% ax.FontSize = 30;
% set(gcf,'color','white')