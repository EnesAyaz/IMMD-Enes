%%
clc
clear
%%

ModulationIndex = 0.9;
fsw = 40e3;
ffund = 50;
Vdc=270;
La= 3.4e-9+1.3e-9+2.02e-8; %% LaTop+Lamid+LaBot
% La=1e-20;
Ra=2.02e-8+3.4e-9+1.3e-9;
% Ra=1e-20;
Lload=6.9e-3;
Rload=10;
