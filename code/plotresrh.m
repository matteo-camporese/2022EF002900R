close all

subplot(2,2,1)
plot(HUM,An,'LineWidth',1.0);
xlabel('Relative humidity (%)')
ylabel('A_n (\mumol m^{-2} s^{-1})')
% axis tight
% yyaxis right
% plot(br,1000*86400*T,'+--');
% ylabel('T (mm d^{-1})')
ax = gca;
ax.ColorOrder = [1 0 0; 0.93 0 0.07; 0.74 0 0.26; 0.58 0 0.42; 0.34 0 0.66; 0 0 1; 0.38 0.43 0.19; 0 0 0];
% ax.LineStyleOrder = {'-','--'};

subplot(2,2,2)
plot(HUM,1000*86400*T,'LineWidth',1.0);
xlabel('Relative humidity (%)')
ylabel('T (mm d^{-1})')
% axis tight
ax = gca;
ax.ColorOrder = [1 0 0; 0.93 0 0.07; 0.74 0 0.26; 0.58 0 0.42; 0.34 0 0.66; 0 0 1; 0.38 0.43 0.19; 0 0 0];
% yyaxis right
% plot(br,1./rs,'+--');
% ylabel('g_s (m s^{-1})')

subplot(2,2,3)
plot(HUM,1./rs,'LineWidth',1.0);
% plot(HUM,rs,'LineWidth',1.0);
xlabel('Relative humidity (%)')
ylabel('g_s (m s^{-1})')
% ylabel('r_s (s m^{-1})')
% axis tight
ax = gca;
ax.ColorOrder = [1 0 0; 0.93 0 0.07; 0.74 0 0.26; 0.58 0 0.42; 0.34 0 0.66; 0 0 1; 0.38 0.43 0.19; 0 0 0];
legend('0B:100R%','7B:93R%','26B:74R%','42B:58R%','66B:34R%','100B:0R%','Broad-spectrum','Solar light',...
    'Location','Best','Orientation','vertical')

subplot(2,2,4)
plot(HUM,WUE,'LineWidth',1.0);
xlabel('Relative humidity (%)')
ylabel('WUE (gCO_2/gH_2O)')
% axis tight
ax = gca;
ax.ColorOrder = [1 0 0; 0.93 0 0.07; 0.74 0 0.26; 0.58 0 0.42; 0.34 0 0.66; 0 0 1; 0.38 0.43 0.19; 0 0 0];

figure(2)
plot(WUE,An,'LineWidth',1.0)
xlabel('WUE (gCO_2/gH_2O)')
ylabel('A_n (\mumol m^{-2} s^{-1})')
% axis tight
ax = gca;
ax.ColorOrder = [1 0 0; 0.93 0 0.07; 0.74 0 0.26; 0.58 0 0.42; 0.34 0 0.66; 0 0 1; 0.38 0.43 0.19; 0 0 0];
legend('0B:100R%','7B:93R%','26B:74R%','42B:58R%','66B:34R%','100B:0R%','Broad-spectrum','Solar light',...
    'Location','Best','Orientation','vertical')
