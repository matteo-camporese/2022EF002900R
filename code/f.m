%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CLOSURE CO2 Concentration inside the stomatal           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function[DCi]=CO2_Concentration(Ci,IPAR,Ca,ra,rb,Ts,Pre,Ds,...
%    O,Owp,Oss,CT,VRmax,DS,Ha,FI,Oa,Do,a1,go,gmes,rjv)
%%%
%[CiF]= PHOTOSYNTESIS(Ci,IPAR,Ca,ra,rb,Ts,Ts,Pre,Ds,...
%    O,Owp,Oss,...
%    CT,VRmax,NaN,NaN,DS,Ha,FI,Oa,Do,a1,go);
%DCi = Ci - CiF;
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[DCi]=f(Cc,IPAR,PPFD,Csl,ra,rb,Ts,Pre,RH,CT,T0,Vmax,Oa,g1,go,rjv,theta,alpha)
[CcF]= photosynthesis(Cc,IPAR,PPFD,Csl,ra,rb,Ts,Pre,RH,...
    CT,T0,Vmax,Oa,g1,go,rjv,theta,alpha);
DCi = Cc - CcF;
return
end