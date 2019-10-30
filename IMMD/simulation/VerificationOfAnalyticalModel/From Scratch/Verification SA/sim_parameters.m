%%
%clear;
%clc;

%% RL Load
Ts = 1e-7; % sec
Tfinal = 0.1; % sec
Ripth=0.08;

%%
fsw = 40e3; % Hz
fout = 50; % Hz
% Vdc=130; %V
wout = 2*pi*fout; % rad/sec

Cdc = 15e-6;
delta = 0; % rad % reference
phase=0; % carrier
%%
RA = 10; % Ohms
RB = 10; % Ohms
RC = 10; % Ohms
LA = 15e-3; % H
LB = 15e-3; % H
LC = 15e-3; % H

% Calculate ma's
ma1 = 0.9;

%%
Rin =2;
Lin=3.4e-5;
Vin=130; % phase-to-phase Peak
%%
GridFreq = 50;
Cdcrec = 1e-3;

