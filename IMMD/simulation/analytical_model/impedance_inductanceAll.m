%%
sampleTime=1e-7;
finalTime=0.5e-3;

%% w axis
w = 2*pi*logspace(0,7,1000)';
%% Parameter values
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
LAMid  = 01.30e-9;
LBMid  = 01.30e-9;
LCMid  = 01.30e-9;

LA=0.0150;
LB=0.0150;
LC=0.0150;

RA=10;
RB=10;
RC=10;

ESLA = 19e-15;
ESLB = 19e-15;
ESLC = 19e-15;

C1A = 5e-6;
C1B = 5e-6;
C1C = 5e-6;

%% New merged inducances - sA=1 sB=0 sC=0
L1_100 = LATop + LABot + ESLA;
L2_100 = LABTop;
L3_100 = LABBot;
L4_100 = ESLB;
L5_100 = LBTop + LBBot + LBCTop + LBCBot + ESLC;

%% New merged inducances - sA=0 sB=1 sC=0
L1_010 = LATop + LABot + LABTop + LABBot + ESLA;
L2_010 = ESLB;
L3_010 = LBTop + LBBot;
L4_010 = LBCTop + LBCBot + ESLC;

%% New merged inducances - sA=0 sB=0 sC=1
L1_001 = LATop + LABot + LABTop + LABBot + ESLA;
L2_001 = ESLB;
L3_001 = LBTop + LBBot + LBCTop + LBCBot;
L4_001 = ESLC;
L5_001 = LCTop + LCBot;

%% New merged inducances - sA=0 sB=1 sC=1

%% New merged inducances - sA=1 sB=0 sC=1

%% New merged inducances - sA=1 sB=1 sC=0

%% Calculated impedances - sA=1 sB=0 sC=0
Z1_100 = 1i*w*L5_100 + 1./(1i*w*C1C);
Z2_100 = 1i*w*L4_100 + 1./(1i*w*C1B);
Z3_100 = Z1_100.*Z2_100./(Z1_100+Z2_100);
Z4_100 = Z3_100 + 1i*w*(L2_100+L3_100);
Z5_100 = 1i*w*L1_100 + 1./(1i*w*C1A);
Zeqv_100 = Z4_100.*Z5_100./(Z4_100+Z5_100);

%% Calculated impedances - sA=0 sB=1 sC=0
Z1_001 = 1i*w*L1_010 + 1./(1i*w*C1A);
Z2_001 = 1i*w*L2_010 + 1./(1i*w*C1B);
Z3_010 = Z1_001.*Z2_001./(Z1_001+Z2_001);
Z4_010 = Z3_010 + 1i*w*(L3_010);
Z5_010 = 1i*w*L4_010 + 1./(1i*w*C1C);
Zeqv_010 = Z4_010.*Z5_010./(Z4_010+Z5_010);

%% Calculated impedances - sA=0 sB=0 sC=1
Z1_001 = 1i*w*L1_001 + 1./(1i*w*C1A);
Z2_001 = 1i*w*L2_001 + 1./(1i*w*C1B);
Z3_001 = Z1_001.*Z2_001./(Z1_001+Z2_001);
Z4_001 = Z3_001 + 1i*w*(L3_001);
Z5_001 = 1i*w*L4_001 + 1./(1i*w*C1C);
Z6_001 = Z4_001.*Z5_001./(Z4_001+Z5_001);
Zeqv_001 = Z6_001 + 1i*w*L5_001;

%% Calculated impedances - sA=0 sB=1 sC=1

%% Calculated impedances - sA=1 sB=0 sC=1

%% Calculated impedances - sA=1 sB=1 sC=0
%%
figure;
hold all;
plot(w/(2*pi*1000),abs(Zeqv_100),'b-','Linewidth',1);
plot(w/(2*pi*1000),abs(Zeqv_010),'k--','Linewidth',1);
plot(w/(2*pi*1000),abs(Zeqv_001),'r-','Linewidth',1);
set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',14);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel('Magnitude of equivalent impedance','FontSize',14,'FontWeight','Bold')
xlim([1 10000]);
%ylim([-1.2 1.2]);
legend({'s=100','s=010','s=001'},'Location','best');

%% Obsolete
% loglog(w/(2*pi*1000),abs(Zeqv_phA),'-s')
% loglog(w/(2*pi*1000),abs(Zeqv_phC),'-s')