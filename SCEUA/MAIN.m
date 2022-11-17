%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% MAIN_FRAME OF SVAT-WL %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% INPUT ENVIRONMENTAL VARIABLES %%%
% load('temp.dat');
% load('pfd.dat');
% load('vpd.dat');
% close all
clear all
load('bestx.txt');
Ta = 25; % Ambient temperature [°C]
Pa = 101325; % Atmospheric pressure [Pa]
RH = 70; % Relative humidity [%]
Ca = 397.20; % Ambient CO2 concentration [umol/mol]
Csl = Ca; % we assume CO2 concentration at the leaf surface is equal to atmospheric
Oa = 0.209e+06; % oxygen concentration [umol mol-1]
%%% INPUT LIGHT or ENERGY FORCING %%%
% pfd = load('bs.dat'); % incident light spectrum [umol m-2 s-1 nm-1]
ri = load('rpfd.txt'); % relative irradiance spectra [-]
sp = load('../spectra/lettuce.txt'); % relative quantum yield and absorptance spectra [-]
qy = [sp(:,1) sp(:,2)]; % relative quantum yield spectrum
ab = [sp(:,1) sp(:,3)]; % relative absorptance spectrum
% a = load('../spectra/a_herb_pfd.dat'); % plant action spectrum [-]
%%% PARAMETERS %%%
Vcmax0 = bestx(1); % maximum Rubisco capacity [umol m-2 s-1] at reference temperature
T0 = 25; % reference temperature [°C]
CT = 3; % plant type (C3 or C4)
ra = bestx(3); % atmospheric resistance [s m-1]
rb = ra; % leaf boundary layer resistance [s m-1]
% D0 = 300; % parameter in water vapor defici function [Pa] Leuning -> 300; Jarvis -> 1250
% g1 = 1.90; % empirical parameter in Eq. (11) by Medlyn et al. (2011)
g1 = bestx(5); % empirical parameter in Eq. (2) by Kromdijk et al. (2019)
rjv = bestx(2); % ratio between Jmax0 and Vcmax0
g0 = bestx(4)/1.6; % minimum stomatal conductance or cuticular conductance [umol CO2 m-2 leaf s -1]


tic ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% j=1; %%% time dt = 1 day  %%%%%%%%%%%%%%%%
% Tstm0= Ts(1);
%%% i time dt = 1h
%%% ms soil layer
%%% cc Crown Area present
%%%%%%%%%%%%%%%% NUMERICAL METHODS OPTIONS
%Opt_CR = optimset('TolX',3);
%Opt_ST = optimset('TolX',0.1);
%Opt_ST = optimset('TolX',0.1,'Display','iter');
% Opt_CR = optimset('TolFun',1);%,'UseParallel','always');
% Opt_ST = optimset('TolFun',0.1);%,'UseParallel','always');
% OPT_SM=  odeset('AbsTol',0.05,'MaxStep',dth);
% OPT_VD=  odeset('AbsTol',0.05);
% OPT_STh = odeset('AbsTol',5e+3);
% OPT_PH= odeset('AbsTol',0.01);
% OPT_VegSnow = 1;
% OPT_SoilTemp = 0;
% OPT_PlantHydr = 0;
% OPT_EnvLimitGrowth = 0;

TOTPFD=[70 88 80; 180 238 238]; % imposed total PFD [umol m-2 s-1]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:size(TOTPFD,1)
    for i=1:size(ri,2)-1
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% compute photosynthetic photon flux density and leaf available
        %%% energy
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Q=PHI*4.56;
        %PHI=Q/4.56;
        %Ta=temp(i,2);
        %Ds=vpd(i,2)*1000;
        %es=0.6108*exp(17.27*Ta/(Ta+237.3))*1000; % saturation vapor pressure [Pa]
        %RH=(1-Ds/es)*100; % relative humidity [%]
        bs=[ri(:,1) TOTPFD(k,i)*ri(:,i+1)];
        [Q(k,i),K2Q(k,i),PHI(k,i)] = parabs(bs,qy,ab);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% compute carbon assimilation rate with a Picard-style iteration
        %%% procedure
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        CiF(k,i)=Ca;
        Ci=Ca-10;
        while abs(Ci-CiF(k,i)) > 0.1
            Ci=CiF(k,i);
            [CiF(k,i),An(k,i),rs(k,i),Rd(k,i),gsCO2(k,i),J(k,i),NPQ(k,i),Fvp(k,i),Fmp(k,i)]=photosynthesis(Ci,Q(k,i),K2Q(k,i),Csl,...
                ra,rb,Ta,Pa,RH,CT,T0,Vcmax0,Oa,g1,g0,rjv);
        end
        %Psi_L,Psi_sto_50,Psi_sto_99,...
        %%% compute transpiration
        GPP(k,i) = 1.0368*(An(k,i) + Rd(k,i)); %% [gC / m^2 d]  Gross Primary Productivity
        T(k,i)=transpiration(ra,rb,rs(k,i),RH,PHI(k,i),Ta,Pa); %%[m/s] transpiration
        Tr(k,i)= 1.0e+6.*T(k,i)*(273.15)/(0.0224*(Ta+273.15)); %%[umol H2O m-2 s-1] transpiration
    end
end
WUE=44.01.*An./(18.01528.*Tr);
% WUE=GPP./(T.*1.0e6.*86400);
%close(bau)
Computational_Time = toc;
%profile off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('COMPUTATIONAL TIME [s] ')
disp(Computational_Time)

% br=100*[0 0.1 0.25 0.5 0.8 0.9 1.0];
% subplot(2,2,1)
% plot(br,An,'ko--');
% xlabel('Blue ratio (%)')
% ylabel('A_n (\mumol m^{-2} s^{-1})')
% yyaxis right
% plot(br,1000*86400*T,'+--');
% ylabel('T (mm d^{-1})')
% 
% subplot(2,2,2)
% plot(br,PHI,'ko--');
% xlabel('Blue ratio (%)')
% ylabel('\phi (W m^{-2})')
% yyaxis right
% plot(br,1./rs,'+--');
% ylabel('g_s (m s^{-1})')
% 
% subplot(2,2,3)
% plot(br,GPP,'ko--');
% xlabel('Blue ratio (%)')
% ylabel('GPP (gC m^{-2} d^{-1})')
% 
% subplot(2,2,4)
% plot(br,WUEG,'ko--');
% xlabel('Blue ratio (%)')
% ylabel('WUE')
