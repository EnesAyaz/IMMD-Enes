tic
%% Time array
Tstep = 1e-6; % s
Ts = Tstep; % s
Ripth = 0.18; % sec
Tfinal = 100e-3; % s
time_array = 0:Tstep:Tfinal-Tstep;
NumberofSteps = numel(time_array);
%% Defined Parameters
DCSourceMagn = 300; % V
SixthHarmonicMagn = 0; % V
SixthHarmonicFreq = 300; % Hz
SixthHarmonicPhase = 0; % Radians
%% Constant Parameters
Cdc = 15e-6; % F
RA = 10; % Ohms
RB = 10; % Ohms
RC = 10; % Ohms
LA = 15e-3; % H
LB = 15e-3; % H
LC = 15e-3; % H
Rin = 2; % Ohms
Lin = 1e-3; % H
%% Generate switching signals
ma = 0.9;
fout = 50; % Hz
fsw = 10e3; % Hz
delta = 0; % Radians
VrefA = ma*sin(2*pi*fout*time_array-delta);
VrefB = ma*sin(2*pi*fout*time_array-delta-2*pi/3);
VrefC = ma*sin(2*pi*fout*time_array-delta-4*pi/3);
Vcarrier = sawtooth(2*pi*fsw*time_array);
SA = (VrefA > Vcarrier);
SB = (VrefB > Vcarrier);
SC = (VrefC > Vcarrier);
%% States
PhaseACurrent = zeros(1, NumberofSteps);
PhaseBCurrent = zeros(1, NumberofSteps);
PhaseCCurrent = zeros(1, NumberofSteps);
DCBusVoltage = zeros(1, NumberofSteps);
InputCurrent = zeros(1, NumberofSteps);
%% Inputs
InputVoltage = DCSourceMagn + SixthHarmonicMagn*sin(2*pi*300*time_array-SixthHarmonicPhase);
%% Main Loop for State Calculations
PhaseACurrentPrev = 0;
PhaseBCurrentPrev = 0;
PhaseCCurrentPrev = 0;
DCBusVoltagePrev  = 0;
InputCurrentPrev  = 0;
PhaseACurrentDiff = 0;
PhaseBCurrentDiff = 0;
PhaseCCurrentDiff = 0;
DCBusVoltageDiff  = 0;
InputCurrentDiff  = 0;
for k = 2:NumberofSteps
    PhaseACurrentDiff = ...
        (-RA/LA)    *PhaseACurrentPrev +...
        (0)         *PhaseBCurrentPrev +...
        (0)         *PhaseCCurrentPrev +...
        (SA(k)/LA)  *DCBusVoltagePrev  +...
        (0)         *InputCurrentPrev  +...
        (0)         *InputVoltage(k);
    
    PhaseBCurrentDiff = ...
        (0)         *PhaseACurrentPrev +...
        (-RB/LB)    *PhaseBCurrentPrev +...
        (0)         *PhaseCCurrentPrev +...
        (SB(k)/LB)  *DCBusVoltagePrev  +...
        (0)         *InputCurrentPrev  +...
        (0)         *InputVoltage(k);
    
    PhaseCCurrentDiff = ...
        (0)         *PhaseACurrentPrev +...
        (0)         *PhaseBCurrentPrev +...
        (-RC/LC)    *PhaseCCurrentPrev +...
        (SC(k)/LC)  *DCBusVoltagePrev  +...
        (0)         *InputCurrentPrev  +...
        (0)         *InputVoltage(k);
    
    DCBusVoltageDiff = ...
        (-SA(k)/Cdc)*PhaseACurrentPrev +...
        (-SB(k)/Cdc)*PhaseBCurrentPrev +...
        (-SC(k)/Cdc)*PhaseCCurrentPrev +...
        (0)         *DCBusVoltagePrev  +...
        (1/Cdc)     *InputCurrentPrev  +...
        (0)         *InputVoltage(k);
    
    InputCurrentDiff = ...
        (0)         *PhaseACurrentPrev +...
        (0)         *PhaseBCurrentPrev +...
        (0)         *PhaseCCurrentPrev +...
        (-1/Lin)    *DCBusVoltagePrev  +...
        (-Rin/Lin)  *InputCurrentPrev  +...
        (1/Lin)     *InputVoltage(k);
    
    PhaseACurrent(k) = PhaseACurrentPrev + PhaseACurrentDiff*Tstep;
    PhaseBCurrent(k) = PhaseBCurrentPrev + PhaseBCurrentDiff*Tstep;
    PhaseCCurrent(k) = PhaseCCurrentPrev + PhaseCCurrentDiff*Tstep;
    DCBusVoltage(k)  = DCBusVoltagePrev  + DCBusVoltageDiff *Tstep;
    InputCurrent(k)  = InputCurrentPrev  + InputCurrentDiff *Tstep;
    
    PhaseACurrentPrev = PhaseACurrent(k);
    PhaseBCurrentPrev = PhaseBCurrent(k);
    PhaseCCurrentPrev = PhaseCCurrent(k);
    DCBusVoltagePrev  = DCBusVoltage(k);
    InputCurrentPrev  = InputCurrent(k);
end
%% Other Parameters
ConverterVoltagePhaseANeutral = DCBusVoltage.*SA;
ConverterVoltagePhaseBNeutral = DCBusVoltage.*SB;
ConverterVoltagePhaseCNeutral = DCBusVoltage.*SC;
ConverterVoltagePhaseAPhaseB = DCBusVoltage.*(SA-SB);
ConverterVoltagePhaseBPhaseC = DCBusVoltage.*(SB-SC);
ConverterVoltagePhaseCPhaseA = DCBusVoltage.*(SC-SA);
ConverterDCBusCurrent = PhaseACurrent.*SA + PhaseBCurrent.*SB + PhaseCCurrent.*SC;
DCBusCapacitorCurrent = InputCurrent - ConverterDCBusCurrent;

toc

%% Phase Currents
figure;
hold all;
plot(time_array,PhaseACurrent,'b-','Linewidth',1);
plot(time_array,PhaseBCurrent,'r-','Linewidth',1);
plot(time_array,PhaseCCurrent,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Phase Currents (Amps)','FontSize',14,'FontWeight','Bold')
%xlim([0 40e-3]);
%ylim([-1.2 1.2]);
legend({'Phase-A','Phase-B','Phase-C'},'Location','best');
%% DC Bus Voltages
figure;
hold all;
plot(time_array,DCBusVoltage,'b-','Linewidth',2);
plot(time_array,InputVoltage,'r-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('DC Bus Voltages (Volts)','FontSize',14,'FontWeight','Bold')
%xlim([0 40e-3]);
%ylim([-1.2 1.2]);
legend({'DC Bus','Input'},'Location','best');
%% DC Bus Currents
figure;
hold all;
plot(time_array,DCBusCapacitorCurrent,'b-','Linewidth',2);
plot(time_array,ConverterDCBusCurrent,'k-','Linewidth',2);
plot(time_array,InputCurrent,'r-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('DC Bus Currents (Amps)','FontSize',14,'FontWeight','Bold')
xlim([1e-3 40e-3]);
%ylim([-1.2 1.2]);
legend({'Capacitor','Converter','Input'},'Location','best');
%% Line to Line Voltages
% figure;
% hold all;
% plot(time_array,ConverterVoltagePhaseAPhaseB,'b-','Linewidth',1);
% plot(time_array,ConverterVoltagePhaseBPhaseC,'r-','Linewidth',1);
% plot(time_array,ConverterVoltagePhaseCPhaseA,'k-','Linewidth',1);
% set(gca,'FontSize',14);
% xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
% ylabel('Line-to-Line Voltages (Volts)','FontSize',14,'FontWeight','Bold')
% %xlim([0 40e-3]);
% %ylim([-1.2 1.2]);
% legend({'Phase-AB','Phase-BC','Phase-CA'},'Location','best');
%%
% %% Reference Signal and Carrier
% figure;
% hold all;
% plot(time_array,VrefA,'b-','Linewidth',2);
% plot(time_array,VrefB,'g-','Linewidth',2);
% plot(time_array,VrefC,'k-','Linewidth',2);
% plot(time_array,Vcarrier,'r-','Linewidth',2);
% set(gca,'FontSize',14);
% xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
% ylabel('Reference Signals (Volts)','FontSize',14,'FontWeight','Bold')
% xlim([0 40e-3]);
% ylim([-1.2 1.2]);
% legend({'Phase-A','Phase-B','Phase-C'},'Location','best');
% %% Switching Signals
% figure;
% hold all;
% %plot(time_array,SA,'b-','Linewidth',2);
% plot(time_array,SA-SB,'r-','Linewidth',2);
% plot(time_array,(VrefA-VrefB)/sqrt(3),'k-','Linewidth',2);
% %plot(time_array,SB,'g-','Linewidth',2);
% %plot(time_array,SC,'k-','Linewidth',2);
% %plot(time_array,Vcarrier,'r-','Linewidth',2);
% set(gca,'FontSize',14);
% xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
% ylabel('Reference Signals (Volts)','FontSize',14,'FontWeight','Bold')
% xlim([0 40e-3]);
% ylim([-1.2 1.2]);
% %% Input Voltage
% figure;
% hold all;
% plot(time_array,InputVoltage,'b-','Linewidth',2);
% set(gca,'FontSize',14);
% xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
% ylabel('Inp?t Voltage (Volts)','FontSize',14,'FontWeight','Bold')
% xlim([0 20e-3]);
% ylim([0 400]);
