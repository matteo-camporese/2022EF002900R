close all;
clear all;
delete sceua_main.m~;
delete objfun.txt;

WUEobs=csvread('WUE.csv',0,1);
gsobs=csvread('gs.csv',0,1);

global WUEobs gsobs BESTX BESTF ICALL PX PF

bl=[ 50 1.50   1 0.0  50 0.70 0.20];
bu=[200 2.50 100 1.0 300 0.90 0.80];
x0=[193.4334    1.9916   86.1168    0.0002  192.6332    0.8844    0.7997];

maxn=2000;
kstop=5;
pcento=0.01;
peps=0.01;
iseed=-1;
iniflg=1;
ngs=4;

[bestx,bestf] = sceua(x0,bl,bu,maxn,kstop,pcento,peps,ngs,iseed,iniflg);

save sceua_results.mat
