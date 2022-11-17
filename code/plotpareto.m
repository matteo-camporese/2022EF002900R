close all
clear all

figure
hold on

load pareto_lt1.mat
fval=sortrows(fval,1);
plot(fval(:,1),fval(:,2),'o--','Color',[1 0 0],'MarkerEdgeColor','k','MarkerFaceColor',[1 0 0]);
clear all

load pareto_lt2.mat
fval=sortrows(fval,1);
plot(fval(:,1),fval(:,2),'o--','Color',[0.93 0 0.07],'MarkerEdgeColor','k','MarkerFaceColor',[0.93 0 0.07]);
clear all

load pareto_lt3.mat
fval=sortrows(fval,1);
plot(fval(:,1),fval(:,2),'o--','Color',[0.74 0 0.26],'MarkerEdgeColor','k','MarkerFaceColor',[0.74 0 0.26]);
clear all

load pareto_lt4.mat
fval=sortrows(fval,1);
plot(fval(:,1),fval(:,2),'o--','Color',[0.58 0 0.42],'MarkerEdgeColor','k','MarkerFaceColor',[0.58 0 0.42]);
clear all

load pareto_lt5.mat
fval=sortrows(fval,1);
plot(fval(:,1),fval(:,2),'o--','Color',[0.34 0 0.66],'MarkerEdgeColor','k','MarkerFaceColor',[0.34 0 0.66]);
clear all

load pareto_lt6.mat
fval=sortrows(fval,1);
plot(fval(:,1),fval(:,2),'o--','Color',[0 0 1],'MarkerEdgeColor','k','MarkerFaceColor',[0 0 1]);
clear all

load pareto_lt7.mat
fval=sortrows(fval,1);
plot(fval(:,1),fval(:,2),'o--','Color',[0.38 0.43 0.19],'MarkerEdgeColor','k','MarkerFaceColor',[0.38 0.43 0.19]);
clear all

load pareto_lt8.mat
fval=sortrows(fval,1);
plot(fval(:,1),fval(:,2),'o--','Color',[0 0 0],'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0]);
clear all

legend('0B:100R%','7B:93R%','26B:74R%','42B:58R%','66B:34R%','100B:0R%','Broad-spectrum','Solar light',...
    'Location','Best','Orientation','vertical')
set(gca,'FontSize',14)
ylabel('WUE (gCO_2/gH_2O)')
xlabel('A_n (\mumol m^{-2} s^{-1})')

