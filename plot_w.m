% plot w


set(gcf,'color','white')
set(gcf,'defaultaxescolororder',[0 0 0])
set(gcf,'DefaultLineLineWidth',4)
set(gcf,'defaultAxesFontSize',30,'defaultAxesFontWeight','bold', 'DefaultAxesXGrid','on', 'DefaultAxesYGrid','on')
%set(gcf,'defaultaxeslinestyleorder',{'-','--',':', '-.'})

set(gcf, 'Position', get(0, 'Screensize'))

%% Plot w: in grigio i valori medi, in nero la sol ottima problema 5
plot(w_r)
hold on
%plot(E_w,'color',[0,0,0]+0.5)
legend('$w_^r$','Interpreter','latex','FontSize',35)
xlabel('Time [hours]')
ylabel('Power [kW]')

saveas(gcf, 'fig_w', 'png') %Save figure