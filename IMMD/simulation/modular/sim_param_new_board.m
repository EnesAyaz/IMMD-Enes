
%% Initial Configurations
% clear all;clc;

%% Source parameters
PulseAmplitude = 9;
fsw = 40e3;
ffund = 50;
frms = 50;
ModulationIndex1 = 0.9;
ModulationIndex2 = 0.9;
Vmodule = 270;
series = 1;
parallel = 2;
VpulseMax = 6; 
VpulseMin = -3;

% Quantities in below are in percent
Dtop = 0.1; % duty cycle of top
Dbot = 0.1; % duty cycle of bot
DelayTop = 0;
DelayBot = 50;
Module1Phase = 0; %in degree
Module2Phase = 180; %in degree

Ls = 0.9e-9;
Ld = 0.9e-9;

% Yes ESL and ESR
% ESLA = 19e-9;
% ESLB = 19e-9;
% ESLC = 19e-9;
% ESRA = 21.1e-3;
% ESRB = 21.1e-3;
% ESRC = 21.1e-3;

% No ESL and ESR
ESLA = 19e-15;
ESLB = 19e-15;
ESLC = 19e-15;
ESRA = 21.1e-15;
ESRB = 21.1e-15;
ESRC = 21.1e-15;

%% Parasitics
% Tüm parazitikler var
LATop  = 03.40e-9;
LABot  = 20.25e-9;
LAMid  = 01.30e-9;
LBTop  = 03.38e-9;
LBBot  = 20.38e-9;
LBMid  = 01.30e-9;
LCTop  = 03.41e-9;
LCBot  = 20.94e-9;
LCMid  = 01.30e-9;
LABTop = 18.30e-9;
LABBot = 10.20e-9;
LBCTop = 21.84e-9;
LBCBot = 11.14e-9;

RATop  = 03.40e-9;
RABot  = 20.25e-9;
RAMid  = 01.30e-9;
RBTop  = 03.38e-9;
RBBot  = 20.38e-9;
RBMid  = 01.30e-9;
RCTop  = 03.41e-9;
RCBot  = 20.94e-9;
RCMid  = 01.30e-9;
RABTop = 18.30e-9;
RABBot = 10.20e-9;
RBCTop = 21.84e-9;
RBCBot = 11.14e-9;

% Tüm parazitikler yok
LATop2  = 03.40e-15;
LABot2  = 20.25e-15;
LAMid2  = 01.30e-15;
LBTop2  = 03.38e-15;
LBBot2  = 20.38e-15;
LBMid2  = 01.30e-15;
LCTop2  = 03.41e-15;
LCBot2  = 20.94e-15;
LCMid2  = 01.30e-15;
LABTop2 = 18.30e-15;
LABBot2 = 10.20e-15;
LBCTop2 = 21.84e-15;
LBCBot2 = 11.14e-15;

RATop2  = 03.40e-15;
RABot2  = 20.25e-15;
RAMid2  = 01.30e-15;
RBTop2  = 03.38e-15;
RBBot2  = 20.38e-15;
RBMid2  = 01.30e-15;
RCTop2  = 03.41e-15;
RCBot2  = 20.94e-15;
RCMid2  = 01.30e-15;
RABTop2 = 18.30e-15;
RABBot2 = 10.20e-15;
RBCTop2 = 21.84e-15;
RBCBot2 = 11.14e-15;


% Eski kart
% Tüm parazitikler var
ACapToDrain = 7.14e-9;
ACapToSource = 5.65e-9;
ASourceToLoad = 3.724e-9;
ADrainToLoad = 3.724e-9;
APosToCap = 29.8e-9;
ANegToCap = 48.6e-9;
% % 
BCapToDrain = 7.233e-9;
BCapToSource = 5.434e-9;
BSourceToLoad = 3.933e-9;
BDrainToLoad = 3.933e-9;
BPosToCap = 2.63e-9;
BNegToCap = 3.183e-9;
% % 
CCapToDrain = 7.145e-9;
CCapToSource = 5.4e-9;
CSourceToLoad = 3.242e-9;
CDrainToLoad = 3.242e-9;
CPosToCap = 43.665e-9;
CNegToCap = 31.2e-9;

% Eski kart
% Tüm parazitikler yok
% ACapToDrain = 1e-15;
% ACapToSource = 1e-15;
% ASourceToLoad = 1e-15;
% ADrainToLoad = 1e-15;
% APosToCap = 1e-15;
% ANegToCap = 1e-15;
% 
% BCapToDrain = 1e-15;
% BCapToSource = 1e-15;
% BSourceToLoad = 1e-15;
% BDrainToLoad = 1e-15;
% BPosToCap = 1e-15;
% BNegToCap = 1e-15;
% 
% CCapToDrain = 1e-15;
% CCapToSource = 1e-15;
% CSourceToLoad = 1e-15;
% CDrainToLoad = 1e-15;
% CPosToCap = 1e-15;
% CNegToCap = 1e-15;

% Connection inductance var
% POS1 = 100e-9;
% NEG1 = 100e-9;
% POS2 = 100e-9;
% NEG2 = 100e-9;

% Connection inductance yok
POS1 = 100e-15;
NEG1 = 100e-15;
POS2 = 100e-15;
NEG2 = 100e-15;

%% Load parameters
Vdc = Vmodule*series;

Vln1 = 0.612*Vmodule/sqrt(3)*ModulationIndex1;
PF = 0.98;
P_module1 = 2e3;
S1 = P_module1/PF;
Z1 = Vln1^2/(S1/3);
Rload1 = Z1*PF;
Xload1 = sqrt(Z1^2 - Rload1^2);
Lload1 = Xload1/(2*pi*ffund);
Iload1 = Vln1/Z1;

Vln2 = 0.612*Vmodule/sqrt(3)*ModulationIndex2;
PF = 0.98;
P_module2 = 2e3;
S = P_module2/PF;
Z2 = Vln2^2/(S/3);
Rload2 = Z2*PF;
Xload2 = sqrt(Z2^2 - Rload2^2);
Lload2 = Xload2/(2*pi*ffund);
Iload2 = Vln2/Z2;

P = P_module1+ P_module2;
Idc = P/Vdc/2;
Rin = 10;
Lin = Lload1;
Vin = Vdc + Idc*Rin;

%% Capacitances
% Module 1
C1A = 5e-6;
C1B = 5e-6;
C1C = 5e-6;
% Module 2
C2A = 5e-6;
C2B = 5e-6;
C2C = 5e-6;
%% Initial Conditions
% % Phase A Top
% CurrAT = 0;
% VoltDSAT = 0;
% VoltGSAT = 0;
% VoltGDAT = VoltDSAT - VoltGSAT;
% % Phase A Bot
% CurrAB = InitialCurrent;
% VoltDSAB = 0;
% VoltGSAB = 0;
% VoltGDAB = VoltDSAB - VoltGSAB;
% % Phase B Top
% CurrBT = InitialCurrent/2;
% VoltDSBT = 0;
% VoltGSBT = 0;
% VoltGDBT = VoltDSBT - VoltGSBT;
% % Phase B Bot
% CurrBB = 0;
% VoltDSBB = 0;
% VoltGSBB = 0;
% VoltGDBB = VoltDSBB - VoltGSBB;
% % Phase C Top
% CurrCT = InitialCurrent/2;
% VoltDSCT = 0;
% VoltGSCT = 0;
% VoltGDCT = VoltDSCT - VoltGSCT;
% % Phase C Bot
% CurrCB = 0;
% VoltDSCB = 0;
% VoltGSCB = 0;
% VoltGDCB = VoltDSCB - VoltGSCB;
% % Load
InitialCurrent = Iload1;
LoadA = -InitialCurrent;
LoadB = InitialCurrent/2;
LoadC = InitialCurrent/2;
% Source
SourceVolt = Vdc;
SourceCurrent = InitialCurrent;
%% Run Simulink 
Tfinal = 20e-3;
SampleTime = 1e-7;

%%
%tic
%sim('Modular_Model_New_Board')
%toc
