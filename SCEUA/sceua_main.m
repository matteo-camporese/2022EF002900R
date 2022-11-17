close all;
clear all;
delete sceua_main.m~;
delete objfun.txt;

Anobs=csvread('An_obs.csv',0,1,[0 1 5 1]);
Tobs=csvread('T_obs.csv',0,1,[0 1 5 1]);
gsobs=csvread('gs_obs.csv',0,1,[0 1 5 1]);

global Anobs Tobs gsobs BESTX BESTF ICALL PX PF

bl=[ 30 1.5   1 0.0  50];
bu=[150 2.0 100 1.0 300];
x0=[73.4 2.0 1.47 0 146.];

maxn=2000;
kstop=5;
pcento=0.01;
peps=0.01;
iseed=-1;
iniflg=1;
ngs=4;

[bestx,bestf] = sceua(x0,bl,bu,maxn,kstop,pcento,peps,ngs,iseed,iniflg);

save sceua_results.mat
