close all

% % sensitivity analysis
% subplot(2,2,1)
% plot(TOTIRR',An);
% xlabel('Irradiance (W m^{-2})')
% ylabel('A_n (\mumol m^{-2} s^{-1})')
% axis tight
% % yyaxis right
% % plot(br,1000*86400*T,'+--');
% % ylabel('T (mm d^{-1})')
% ax = gca;
% ax.ColorOrder = [1 0 0; 0.9 0 0.1; 0.75 0 0.25; 0.5 0 0.5; 0.2 0 0.8; 0.1 0 0.9; 0 0 1; 0 0 0; 0 1 0];
% % ax.LineStyleOrder = {'-','--'};
% 
% subplot(2,2,2)
% plot(TOTIRR',1000*86400*T);
% xlabel('Irradiance (W m^{-2})')
% ylabel('T (mm d^{-1})')
% axis tight
% ax = gca;
% ax.ColorOrder = [1 0 0; 0.9 0 0.1; 0.75 0 0.25; 0.5 0 0.5; 0.2 0 0.8; 0.1 0 0.9; 0 0 1; 0 0 0; 0 1 0];
% % yyaxis right
% % plot(br,1./rs,'+--');
% % ylabel('g_s (m s^{-1})')
% 
% subplot(2,2,3)
% plot(TOTIRR',1./rs);
% xlabel('Irradiance (W m^{-2})')
% ylabel('g_s (m s^{-1})')
% axis tight
% ax = gca;
% ax.ColorOrder = [1 0 0; 0.9 0 0.1; 0.75 0 0.25; 0.5 0 0.5; 0.2 0 0.8; 0.1 0 0.9; 0 0 1; 0 0 0; 0 1 0];
% legend('0B:100R%','10B:90R%','25B:75R%','50B:50R%','80B:20R%','90B:10R%','100B:0R%','Solar light','100G%',...
%     'Location','Best','Orientation','vertical')
% 
% subplot(2,2,4)
% plot(TOTIRR',WUE);
% xlabel('Irradiance (W m^{-2})')
% ylabel('WUE (gCO_2/gH_2O)')
% axis tight
% ax = gca;
% ax.ColorOrder = [1 0 0; 0.9 0 0.1; 0.75 0 0.25; 0.5 0 0.5; 0.2 0 0.8; 0.1 0 0.9; 0 0 1; 0 0 0; 0 1 0];

% Muneer et al (2014)
subplot(2,2,1)
bar(An');
xlabel('Treatment')
ylabel('A_n (\mumol m^{-2} s^{-1})')

subplot(2,2,2)
bar(1.64e-06*gsCO2');
xlabel('Treatment')
ylabel('g_s (mol m^{-2} s^{-1})')

subplot(2,2,3)
bar(Fvp'./Fmp')
xlabel('Treatment')
ylabel('F_v/F_m')

subplot(2,2,4)
bar(Tr');
xlabel('Treatment')
ylabel('T (\mumol H_2O m^{-2} s^{-1})')

