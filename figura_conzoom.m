close all

plot(x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,'linewidth',1)
legend('uncontrolled','MPC')
ax = gca
set(gca, 'LineWidth', 1, 'FontSize', 11, 'fontweight', 'b')
set(gcf, 'Color', 'w')
xticks([0,[5:5:50]-1])
xlim([0,49])
xticklabels({'1','5','10','15','20','25','30','35','40','45','50'})
ylabel('Accuracy','FontSize', 11 , 'fontweight', 'b')
xlabel('Communication round n°','FontSize', 11 , 'fontweight', 'b')
set(gcf,'position',[0,0,500,230])
legend({'Centralised','Circle','Sparse','Star','Complete'},'Orientation','horizontal','FontSize',7,'Location','northoutside');


% create a new pair of axes inside current figure
axes('position',[.6 .4 .25 .25])
box on % put box around new pair of axes
indexOfInterest = (x1 < 52) & (x1 > 38); % range of t near perturbation
plot(x1(indexOfInterest),y1(indexOfInterest),x2(indexOfInterest),y2(indexOfInterest),x3(indexOfInterest),y3(indexOfInterest),x4(indexOfInterest),y4(indexOfInterest),x5(indexOfInterest),y5(indexOfInterest),'linewidth',1) % plot on new axes
%ylim([0.92,0.99])
%yticks([0.0,0.95,0.98])
xlim([39,49])
xticks([0,[5:5:50]-1])
xticklabels({'1','5','10','15','20','25','30','35','40','45','50'})
set(gca, 'LineWidth', 1, 'FontSize', 11, 'fontweight', 'b')


