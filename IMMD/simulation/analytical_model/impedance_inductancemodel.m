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

ESLA = 19e-15;
ESLB = 19e-15;
ESLC = 19e-15;

C1A = 5e-6;
C1B = 5e-6;
C1C = 5e-6;

%% New merged inducances - phA
L1_phA = LATop + LABot + ESLA;
L2_phA = LABTop;
L3_phA = LABBot;
L4_phA = ESLB;
L5_phA = LBTop + LBBot + LBCTop + LBCBot + ESLC;

%% New merged inducances - phB
L1_phB = LATop + LABot + LABTop + LABBot + ESLA;
L2_phB = ESLB;
L3_phB = LBTop + LBBot;
L4_phB = LBCTop + LBCBot + ESLC;

%% New merged inducances - phC
L1_phC = LATop + LABot + LABTop + LABBot + ESLA;
L2_phC = ESLB;
L3_phC = LBTop + LBBot + LBCTop + LBCBot;
L4_phC = ESLC;
L5_phC = LCTop + LCBot;

%% Calculated impedances - phA
Z1_phA = 1i*w*L5_phA + 1./(1i*w*C1C);
Z2_phA = 1i*w*L4_phA + 1./(1i*w*C1B);
Z3_phA = Z1_phA.*Z2_phA./(Z1_phA+Z2_phA);
Z4_phA = Z3_phA + 1i*w*(L2_phA+L3_phA);
Z5_phA = 1i*w*L1_phA + 1./(1i*w*C1A);
Zeqv_phA = Z4_phA.*Z5_phA./(Z4_phA+Z5_phA);

%% Calculated impedances - phB
Z1_phB = 1i*w*L1_phB + 1./(1i*w*C1A);
Z2_phB = 1i*w*L2_phB + 1./(1i*w*C1B);
Z3_phB = Z1_phB.*Z2_phB./(Z1_phB+Z2_phB);
Z4_phB = Z3_phB + 1i*w*(L3_phB);
Z5_phB = 1i*w*L4_phB + 1./(1i*w*C1C);
Zeqv_phB = Z4_phB.*Z5_phB./(Z4_phB+Z5_phB);

%% Calculated impedances - phC
Z1_phC = 1i*w*L1_phC + 1./(1i*w*C1A);
Z2_phC = 1i*w*L2_phC + 1./(1i*w*C1B);
Z3_phC = Z1_phC.*Z2_phC./(Z1_phC+Z2_phC);
Z4_phC = Z3_phC + 1i*w*(L3_phC);
Z5_phC = 1i*w*L4_phC + 1./(1i*w*C1C);
Z6_phC = Z4_phC.*Z5_phC./(Z4_phC+Z5_phC);
Zeqv_phC = Z6_phC + 1i*w*L5_phC;

%%
figure;
hold all;
plot(w/(2*pi*1000),abs(Zeqv_phA),'b-','Linewidth',1);
plot(w/(2*pi*1000),abs(Zeqv_phB),'k--','Linewidth',1);
plot(w/(2*pi*1000),abs(Zeqv_phC),'r-','Linewidth',1);
set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',14);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel('Magnitude of equivalent impedance','FontSize',14,'FontWeight','Bold')
xlim([1 10000]);
%ylim([-1.2 1.2]);
legend({'phA','phB','phC'},'Location','best');

%% Obsolete
% loglog(w/(2*pi*1000),abs(Zeqv_phA),'-s')
% loglog(w/(2*pi*1000),abs(Zeqv_phC),'-s')