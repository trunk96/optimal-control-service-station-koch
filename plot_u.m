% plot w

set(gcf,'color','white')
set(gcf,'defaultaxescolororder',[0 0 0])
set(gcf,'DefaultLineLineWidth',4)
set(gcf,'defaultAxesFontSize',30,'defaultAxesFontWeight','bold', 'DefaultAxesXGrid','on', 'DefaultAxesYGrid','on')
set(gcf,'defaultaxeslinestyleorder',{'-','--',':', '-.'})

set(gcf, 'Position', get(0, 'Screensize'))

title('eqthqrth')

%% Plot w
plot(u)
legend('$(u^{(5)}-w)$','$u^{(2)}$','Interpreter','latex','FontSize',35)
xlabel('Time [hours]')
ylabel('Power [kW]')

saveas(gcf, 'fig_u', 'png') %Save figure