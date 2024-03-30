% plot w

set(gcf,'color','white')
set(gcf,'defaultaxescolororder',[0 0 0])
set(gcf,'DefaultLineLineWidth',4)
set(gcf,'defaultAxesFontSize',30,'defaultAxesFontWeight','bold', 'DefaultAxesXGrid','on', 'DefaultAxesYGrid','on')
%set(gcf,'defaultaxeslinestyleorder',{'-','--',':', '-.'})

set(gcf, 'Position', get(0, 'Screensize'))

%% Plot w
plot(x,'-','color',[0,0,0]+0.5)
legend('$x^{(5)}$','$x^{(2)}$','Interpreter','latex','FontSize',35)
xlabel('Time [hours]')
ylabel('SOC [kWh]')

saveas(gcf, 'fig_x', 'png') %Save figure