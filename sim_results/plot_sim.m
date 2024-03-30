str = "sim_quota_0.";
l = [];
figure
set(gcf,'color','white')
%set(gcf,'defaultaxescolororder',[0 0 0])
set(gcf,'DefaultLineLineWidth',4)
set(gcf,'defaultAxesFontSize',30,'defaultAxesFontWeight','bold', 'DefaultAxesXGrid','on', 'DefaultAxesYGrid','on')
%set(gcf,'defaultaxeslinestyleorder',{'-','--',':', '-.'})
marker = ["^","v","square", "diamond", "pentagram"];

set(gcf, 'Position', get(0, 'Screensize'))


%% Plot x_out
c = 1;
for i=1:2:9
    path = str + i + ".mat";
    l = [l, "$\delta=0."+i+"$"];
    load(path);
    x_out.TimeInfo.Units = 'hours';
    x_out.TimeInfo.StartDate = "06:00";
    x_out.TimeInfo.Format = "HH:MM";
    plot(x_out, "Marker", marker(c), "MarkerIndices", 1:5000:length(x_out.data));
    c = c+1;    
    hold on
end
legend(l, 'Interpreter','latex','FontSize',35)
title("")
ylabel("$x$ [KWh]", "Interpreter", "latex")
xlabel("time [h]", "Interpreter","latex")
ax = gca;
ax.XTickLabel = ax.XTickLabel;
hold off
exportgraphics(gcf, 'fig_x.pdf', 'ContentType', 'vector');

%% Plot u_ess
c = 1;
for i=1:2:9
    path = str + i + ".mat";
    l = [l, "$\delta=0."+i+"$"];
    load(path);
    u_out.TimeInfo.Units = 'hours';
    u_out.TimeInfo.StartDate = "06:00";
    u_out.TimeInfo.Format = "HH:MM";
    plot(u_out, "Marker", marker(c), "MarkerIndices", 1:5000:length(u_out.data));
    c = c+1;    
    hold on
end
legend(l, 'Interpreter','latex','FontSize',35)
title("")
ylabel("$u^{ess}$ [KWh]", "Interpreter", "latex")
xlabel("time [h]", "Interpreter","latex")
ax = gca;
ax.XTickLabel = ax.XTickLabel;
hold off
exportgraphics(gcf, 'fig_u.pdf', 'ContentType', 'vector');

%% Plot p_out
c = 1;
for i=1:2:9
    path = str + i + ".mat";
    l = [l, "$\delta=0."+i + "$"];
    load(path);
    p_out.TimeInfo.Units = 'hours';
    p_out.TimeInfo.StartDate = "06:00";
    p_out.TimeInfo.Format = "HH:MM";
    plot(p_out, "Marker", marker(c), "MarkerIndices", 1:5000:length(p_out.data));
    c = c+1;    
    hold on
end
legend(l, 'Interpreter','latex','FontSize',35)
title("")
ylabel("$p$ [KW]", "Interpreter", "latex")
xlabel("time [h]", "Interpreter","latex")
ax = gca;
ax.XTickLabel = ax.XTickLabel;
hold off
exportgraphics(gcf, 'fig_p.pdf', 'ContentType', 'vector');

%% Plot subplot of quota 0.1 and 0.9 with expected power demand and realization
path = str + "1.mat";
load(path);
set(gcf,'defaultaxescolororder',[0 0 0])
w_r_plot = timeseries(w_r_plot);
w_r_plot = setuniformtime(w_r_plot,'StartTime',0,'EndTime',12);
w_r_plot.TimeInfo.Units = 'hours';
w_r_plot.TimeInfo.StartDate = "06:00";
w_r_plot.TimeInfo.Format = "HH:MM";
plot(w_r_plot, "-")
hold on
w_r_mean_plot = timeseries(w_r_mean_plot);
w_r_mean_plot = setuniformtime(w_r_mean_plot,'StartTime',0,'EndTime',12);
w_r_mean_plot.TimeInfo.Units = 'hours';
w_r_mean_plot.TimeInfo.StartDate = "06:00";
w_r_mean_plot.TimeInfo.Format = "HH:MM";
plot(w_r_mean_plot, ":"); 
legend("$\hat{u}^{ev}(t)$", "$\mathbf{E}[\hat{u}^{ev}(t)]$", 'Interpreter','latex','FontSize',35)
title("")
ylabel("$\hat{u}^{ev}(t)$ [KW]", "Interpreter", "latex")
xlabel("time [h]", "Interpreter","latex")
ax = gca;
ax.XTickLabel = ax.XTickLabel;
hold off
exportgraphics(gcf, 'fig_hat_u_0.1.pdf', 'ContentType', 'vector');

path = str + "9.mat";
load(path);
set(gcf,'defaultaxescolororder',[0 0 0])
w_r_plot = timeseries(w_r_plot);
w_r_plot = setuniformtime(w_r_plot,'StartTime',0,'EndTime',12);
w_r_plot.TimeInfo.Units = 'hours';
w_r_plot.TimeInfo.StartDate = "06:00";
w_r_plot.TimeInfo.Format = "HH:MM";
plot(w_r_plot, "-")
hold on
w_r_mean_plot = timeseries(w_r_mean_plot);
w_r_mean_plot = setuniformtime(w_r_mean_plot,'StartTime',0,'EndTime',12);
w_r_mean_plot.TimeInfo.Units = 'hours';
w_r_mean_plot.TimeInfo.StartDate = "06:00";
w_r_mean_plot.TimeInfo.Format = "HH:MM";
plot(w_r_mean_plot, ":"); 
legend("$\hat{u}^{ev}(t)$", "$\mathbf{E}[\hat{u}^{ev}(t)]$", 'Interpreter','latex','FontSize',35)
title("")
ylabel("$\hat{u}^{ev}(t)$ [KW]", "Interpreter", "latex")
ylim([0, 600])
xlabel("time [h]", "Interpreter","latex")
ax = gca;
ax.XTickLabel = ax.XTickLabel;
hold off
exportgraphics(gcf, 'fig_hat_u_0.9.pdf', 'ContentType', 'vector');
