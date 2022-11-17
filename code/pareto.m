%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SPECTRA-AWARE PHOTOSYNTHESIS MODEL %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% search tradeoff between WUE and An %%
close all
clear all

tic ;

fun = @(x)parfun(x);
options = optimoptions('paretosearch','PlotFcn','psplotparetof');
lb = [15,60,405,100];
ub = [35,80,520,500];
rng default % For reproducibility
[z,fval] = paretosearch(fun,4,[],[],[],[],lb,ub,[],options);

% WUE=GPP./(T.*1.0e6.*86400);
%close(bau)
Computational_Time = toc;
%profile off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('COMPUTATIONAL TIME [s] ')
disp(Computational_Time)

