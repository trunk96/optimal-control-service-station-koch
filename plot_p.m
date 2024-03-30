% plot w


set(gcf,'color','white')
set(gcf,'defaultaxescolororder',[0 0 0])
set(gcf,'DefaultLineLineWidth',4)
set(gcf,'defaultAxesFontSize',30,'defaultAxesFontWeight','bold', 'DefaultAxesXGrid','on', 'DefaultAxesYGrid','on')
set(gcf,'defaultaxeslinestyleorder',{'-','--',':', '-.'})

set(gcf, 'Position', get(0, 'Screensize'))

%% Plot w
%plot(u5)
hold on
plot(p,'-','color',[0,0,0]+0.5)
legend('$u^{(5)}$','$p^{(2)}$','Interpreter','latex','FontSize',35)
xlabel('Time [hours]')
ylabel('Power [kW]')

saveas(gcf, 'fig_p', 'png') %Save figure