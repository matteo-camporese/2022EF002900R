function [out]=functn(in)

global Anobs Tobs gsobs;

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
Vcmax0 = in(1); % maximum Rubisco capacity [umol m-2 s-1] at reference temperature
% Vcmax0 = exp(in(1)); % maximum Rubisco capacity [umol m-2 s-1] at reference temperature
rjv = in(2); % ratio between Jmax0 and Vcmax0
ra = in(3); % atmospheric resistance [s m-1]
% ra = exp(in(3)); % atmospheric resistance [s m-1]
rb = ra; % leaf boundary layer resistance [s m-1]
g0 = in(4)./1.64; % minimum stomatal conductance or cuticular conductance [umol CO2 m-2 leaf s -1]
g1 = in(5); % empirical parameter in Eq. (2) by Kromdijk et al. (2019)
% g1 = exp(in(5)); % empirical parameter in Eq. (2) by Kromdijk et al. (2019)
T0 = 25; % reference temperature [°C]
CT = 3; % plant type (C3 or C4)
% D0 = 300; % parameter in water vapor defici function [Pa] Leuning -> 300; Jarvis -> 1250
% g1 = 1.90; % empirical parameter in Eq. (11) by Medlyn et al. (2011)


% tic ;
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


l=0;
% TOTPFD=[70 88 80; 180 238 238]; % imposed total PFD [umol m-2 s-1]
TOTPFD=[70 180; 88 238; 80 238]; % imposed total PFD [umol m-2 s-1]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:size(TOTPFD,1)
    for i=1:2%size(ri,2)-1
        l=l+1;
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
        bs=[ri(:,1) TOTPFD(k,i)*ri(:,k+1)];
        [Q(k,i),K2Q(k,i),PHI(k,i)] = parabs(bs,qy,ab);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% compute carbon assimilation rate with a Picard-style iteration
        %%% procedure
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        CiF(k,i)=Ca;
        Ci=Ca-10;
        while abs(Ci-CiF(k,i)) > 0.1
            Ci=CiF(k,i);
            [CiF(k,i),An(l),rs(k,i),Rd(k,i),gsCO2(l),J(k,i),NPQ(k,i),Fvp(k,i),Fmp(k,i)]=photosynthesis(Ci,Q(k,i),K2Q(k,i),Csl,...
                ra,rb,Ta,Pa,RH,CT,T0,Vcmax0,Oa,g1,g0,rjv);
        end
        %Psi_L,Psi_sto_50,Psi_sto_99,...
        %%% compute transpiration
        GPP(k,i) = 1.0368*(An(l) + Rd(k,i)); %% [gC / m^2 d]  Gross Primary Productivity
        T(k,i)=transpiration(ra,rb,rs(k,i),RH,PHI(k,i),Ta,Pa); %%[m/s] transpiration
        Tr(l)= 1.0e+6.*T(k,i)*(273.15)/(0.0224*(Ta+273.15)); %%[umol H2O m-2 s-1] transpiration
    end
end
WUE=44.01.*An./(18.01528.*Tr);
% WUE=GPP./(T.*1.0e6.*86400);
% close(bau)
% Computational_Time = toc;
% %profile off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp('COMPUTATIONAL TIME [s] ')
% disp(Computational_Time)

S = [An./max(Anobs) Tr./max(Tobs) 1.64e-06.*gsCO2./max(gsobs)];
O = [Anobs'./max(Anobs) Tobs'./max(Tobs) gsobs'./max(gsobs)];

[KGE,R2] = efficiency(S',O');
% out = 1-KGE;
out = 1-R2;

% diffAn = ((An - repmat(Anobs',size(in,1),1))./max(Anobs)).^2;
% diffTr = ((Tr - repmat(Tobs',size(in,1),1))./max(Tobs)).^2;
% diffGs = ((1.64e-06.*gsCO2 - repmat(gsobs',size(in,1),1))./max(gsobs)).^2;
% out = sum([diffAn diffTr diffGs],2);

save('objfun.txt','KGE','-ascii','-append');

return

