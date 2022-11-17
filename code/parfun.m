function y = parfun(x)

Ta = x(1);
RH = x(2);
Ca = x(3);
TOTIRR = x(4);
% Ta = 24; % Ambient temperature [°C]
Pa = 101325; % Atmospheric pressure [Pa]
% RH = 70; % Relative humidity [%]
% Ca = 450.00; % Ambient CO2 concentration [umol/mol]
Oa = 0.209e+06; % oxygen concentration [umol mol-1]
%%% INPUT LIGHT or ENERGY FORCING %%%
% pfd = load('bs.dat'); % incident light spectrum [umol m-2 s-1 nm-1]
ri = load('rirr.txt'); % relative irradiance spectra [-]
sp = load('../spectra/lettuce.txt'); % relative quantum yield and absorptance spectra [-]
qy = [sp(:,1) sp(:,2)]; % relative quantum yield spectrum
ab = [sp(:,1) sp(:,3)]; % relative absorptance spectrum
% a = load('../spectra/a_herb_pfd.dat'); % plant action spectrum [-]
%%% PARAMETERS %%%
in=load('bestx.txt');
Vcmax0 = in(1); % maximum Rubisco capacity [umol m-2 s-1] at reference temperature
% Vcmax0 = exp(in(1)); % maximum Rubisco capacity [umol m-2 s-1] at reference temperature
rjv = in(2); % ratio between Jmax0 and Vcmax0
ra = in(3); % atmospheric resistance [s m-1]
% ra = exp(in(3)); % atmospheric resistance [s m-1]
rb = ra; % leaf boundary layer resistance [s m-1]
g0 = in(4)./1.64; % minimum stomatal conductance or cuticular conductance [umol CO2 m-2 leaf s -1]
g1 = in(5); % empirical parameter in Eq. (2) by Kromdijk et al. (2019)
theta = in(6); % shape factor non-rectangular hyperbolic fit of J response to light intensity
alpha = in(7); % initial slope non-rectangular hyperbolic fit of J response to light intensity
% g1 = exp(in(5)); % empirical parameter in Eq. (2) by Kromdijk et al. (2019)
T0 = 25; % reference temperature [°C]
CT = 3; % plant type (C3 or C4)
% D0 = 300; % parameter in water vapor defici function [Pa] Leuning -> 300; Jarvis -> 1250
% g1 = 1.90; % empirical parameter in Eq. (11) by Medlyn et al. (2011)

i=8;
bs=[ri(:,1) TOTIRR*ri(:,i+1)];
[Q,K2Q,PHI] = parabs(bs,qy,ab);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Csl = Ca; % we assume CO2 concentration at the leaf surface is equal to atmospheric
x0 = 0.5*Ca;
fun = @(x)f(x,Q,K2Q,Csl,ra,rb,Ta,Pa,RH,CT,T0,Vcmax0,Oa,g1,g0,rjv,theta,alpha);
z = fzero(fun,x0);
Ci = z;
[CiF,An,rs,Rd,gsCO2,J,NPQ,Fvp,Fmp]=photosynthesis(Ci,Q,K2Q,Csl,...
    ra,rb,Ta,Pa,RH,CT,T0,Vcmax0,Oa,g1,g0,rjv,theta,alpha);
%%% compute transpiration
% GPP(l,i) = 1.0368*(An(l,i) + Rd(l,i)); %% [gC / m^2 d]  Gross Primary Productivity
T=transpiration(ra,rb,rs,RH,PHI,Ta,Pa); %%[m/s] transpiration
Tr= 1.0e+6.*T*(273.15)/(0.0224*(Ta+273.15)); %%[umol H2O m-2 s-1] transpiration
WUE=44.01.*An./(18.01528.*Tr);

y(1)=An;
y(2)=WUE;
return
end

