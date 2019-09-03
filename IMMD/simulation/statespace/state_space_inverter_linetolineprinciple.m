tic
%% Time array
Tstep = 1e-6; % s
Ts = Tstep; % s
Ripth = 0.18; % sec
Tfinal = 0.1; % s
time_array = 0:Tstep:Tfinal-Tstep;
NumberofSteps = numel(time_array);
%% Defined Parameters
DCSourceMagn = 300; % V
SixthHarmonicMagn = 0; % V
SixthHarmonicFreq = 300; % Hz
SixthHarmonicPhase = 0; % Radians
Vacrms = 220; % V
GridFreq = 50; % Hz
Cdcrec = 5e-3; % F
%% Constant Parameters
Cdc = 15e-6; % F
RA = 10; % Ohms
RB = 10; % Ohms
RC = 10; % Ohms
LA = 15e-3; % H
LB = 15e-3; % H
LC = 15e-3; % H
Rin = 2; % Ohms
Lin = 5e-5; % H
%% Generate switching signals
ma = 0.9;
fout = 50; % Hz
fsw = 10e3; % Hz
delta = 0; % Radians
VrefA = ma*sin(2*pi*fout*time_array-delta);
VrefB = ma*sin(2*pi*fout*time_array-delta-2*pi/3);
VrefC = ma*sin(2*pi*fout*time_array-delta-4*pi/3);
%Vcarrier = sawtooth(2*pi*fsw*time_array);
Vtriang = zeros(1, NumberofSteps);
for k = 1:Tfinal*fsw
   Triang_temp = triang(1/(Ts*fsw));
   Vtriang((100*(k-1)+1:k/(Tstep*fsw))) = (Triang_temp*2)-1;
end
Vcarrier = Vtriang;
SA = (VrefA > Vcarrier);
SB = (VrefB > Vcarrier);
SC = (VrefC > Vcarrier);
% SA(1:Tfinal/Tstep/10) = 0;
% SB(1:Tfinal/Tstep/10) = 0;
% SC(1:Tfinal/Tstep/10) = 0;

%% States
PhaseACurrent = zeros(1, NumberofSteps);
PhaseCCurrent = zeros(1, NumberofSteps);
DCBusVoltage = zeros(1, NumberofSteps);
InputCurrent = zeros(1, NumberofSteps);
%% Coefficients
Coef_isa_isa = -((RA*LB)+(RA*LC)+(RB*LC)) / ((LA*LC)+(LB*LC)+(LA*LB));
Coef_isa_isc = ((RC*LB)-(RB*LC)) / ((LA*LC)+(LB*LC)+(LA*LB));
Coef_isa_vdc = ((SA*LB)+(SA*LC)-(SB*LC)-(SC*LB)) / ((LA*LC)+(LB*LC)+(LA*LB));
Coef_isc_isa = ((RA*LB)-(RB*LA)) / ((LA*LC)+(LB*LC)+(LA*LB));
Coef_isc_isc = -((RC*LA)+(RC*LB)+(RB*LA)) / ((LA*LC)+(LB*LC)+(LA*LB));
Coef_isc_vdc = ((SC*LA)+(SC*LB)-(SA*LB)-(SB*LA)) / ((LA*LC)+(LB*LC)+(LA*LB));
Coef_vdc_isa = (SB-SA) / (Cdc);
Coef_vdc_isc = (SB-SC) / (Cdc);
Coef_vdc_iin = 1 / (Cdc);
Coef_iin_vdc = -1 / (Lin);
Coef_iin_iin = -(Rin) / (Lin);
Coef_iin_vin = 1 / (Lin);

%% Inputs
InputVoltage = DCSourceMagn + SixthHarmonicMagn*sin(2*pi*300*time_array-SixthHarmonicPhase);
%% Main Loop for State Calculations
PhaseACurrentPrev = 0;
PhaseCCurrentPrev = 0;
DCBusVoltagePrev  = 0;
InputCurrentPrev  = 0;
PhaseACurrentDiff = 0;
PhaseCCurrentDiff = 0;
DCBusVoltageDiff  = 0;
InputCurrentDiff  = 0;
for k = 2:NumberofSteps
    PhaseACurrentDiff = ...
        Coef_isa_isa     * PhaseACurrentPrev +...
        Coef_isa_isc     * PhaseCCurrentPrev +...
        Coef_isa_vdc(k)  * DCBusVoltagePrev  +...
        (0)              * InputCurrentPrev  +...
        (0)              * InputVoltage(k);
    
    PhaseCCurrentDiff = ...
        Coef_isc_isa     * PhaseACurrentPrev +...
        Coef_isc_isc     * PhaseCCurrentPrev +...
        Coef_isc_vdc(k)  * DCBusVoltagePrev  +...
        (0)              * InputCurrentPrev  +...
        (0)              * InputVoltage(k);
    
    DCBusVoltageDiff = ...
        Coef_vdc_isa(k)  * PhaseACurrentPrev +...
        Coef_vdc_isc(k)  * PhaseCCurrentPrev +...
        (0)              * DCBusVoltagePrev  +...
        Coef_vdc_iin     * InputCurrentPrev  +...
        (0)              * InputVoltage(k);
    
    InputCurrentDiff = ...
        (0)              * PhaseACurrentPrev +...
        (0)              * PhaseCCurrentPrev +...
        Coef_iin_vdc     * DCBusVoltagePrev  +...
        Coef_iin_iin     * InputCurrentPrev  +...
        Coef_iin_vin     * InputVoltage(k);
    
    PhaseACurrent(k) = PhaseACurrentPrev + PhaseACurrentDiff*Tstep;
    PhaseCCurrent(k) = PhaseCCurrentPrev + PhaseCCurrentDiff*Tstep;
    DCBusVoltage(k)  = DCBusVoltagePrev  + DCBusVoltageDiff *Tstep;
    InputCurrent(k)  = InputCurrentPrev  + InputCurrentDiff *Tstep;
    
    PhaseACurrentPrev = PhaseACurrent(k);
    PhaseCCurrentPrev = PhaseCCurrent(k);
    DCBusVoltagePrev  = DCBusVoltage(k);
    InputCurrentPrev  = InputCurrent(k);
end
%% Other Parameters
PhaseBCurrent = - PhaseACurrent - PhaseCCurrent;
ConverterVoltagePhaseAPhaseB = DCBusVoltage.*(SA-SB);
ConverterVoltagePhaseBPhaseC = DCBusVoltage.*(SB-SC);
ConverterVoltagePhaseCPhaseA = DCBusVoltage.*(SC-SA);
ConverterDCBusCurrent = PhaseACurrent.*SA + PhaseBCurrent.*SB + PhaseCCurrent.*SC;
DCBusCapacitorCurrent = InputCurrent - ConverterDCBusCurrent;
toc

% %% Phase Currents
% figure;
% hold all;
% plot(time_array,PhaseACurrent,'b-','Linewidth',1);
% plot(time_array,PhaseBCurrent,'r-','Linewidth',1);
% plot(time_array,PhaseCCurrent,'k-','Linewidth',1);
% set(gca,'FontSize',14);
% xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
% ylabel('Phase Currents (Amps)','FontSize',14,'FontWeight','Bold')
% %xlim([0 40e-3]);
% %ylim([-1.2 1.2]);
% legend({'Phase-A','Phase-B','Phase-C'},'Location','best');
% %% DC Bus Voltages
% figure;
% hold all;
% plot(time_array,DCBusVoltage,'b-','Linewidth',2);
% plot(time_array,InputVoltage,'r-','Linewidth',2);
% set(gca,'FontSize',14);
% xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
% ylabel('DC Bus Voltages (Volts)','FontSize',14,'FontWeight','Bold')
% %xlim([0 40e-3]);
% %ylim([-1.2 1.2]);
% legend({'DC Bus','Input'},'Location','best');
%% DC Bus Currents
figure;
hold all;
%plot(time_array,DCBusCapacitorCurrent,'b-','Linewidth',2);
%plot(time_array,ConverterDCBusCurrent,'k-','Linewidth',2);
plot(time_array,InputCurrent,'r-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('DC Bus Currents (Amps)','FontSize',14,'FontWeight','Bold')
xlim([0.08 0.1]);
ylim([0 10]);
legend({'Capacitor','Converter','Input'},'Location','best');
% % Verification figures
% figure;
% hold all;
% plot(time_array,PhaseACurrent,'b-','Linewidth',1);
% plot(time_array,Isa(1:NumberofSteps)','r--','Linewidth',1);
% plot(time_array,PhaseBCurrent,'r-','Linewidth',1);
% plot(time_array,Isb(1:NumberofSteps)','k--','Linewidth',1);
% plot(time_array,PhaseCCurrent,'k-','Linewidth',1);
% plot(time_array,Isc(1:NumberofSteps)','b--','Linewidth',1);
% set(gca,'FontSize',14);
% xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
% ylabel('Phase Currents (Amps)','FontSize',14,'FontWeight','Bold')
% xlim([0 40e-3]);
% ylim([-1.2 1.2]);
% legend({'Model-PhA','Simulation-PhA','Model-PhB','Simulation-PhB',...
%     'Model-PhC','Simulation-PhC'},'Location','best');
% %
% figure;
% hold all;
% plot(time_array,DCBusVoltage,'b-','Linewidth',1);
% plot(time_array,Vdc(1:NumberofSteps)','r-','Linewidth',1);
% plot(time_array,InputVoltage,'k-','Linewidth',1);
% plot(time_array,Vin(1:NumberofSteps)','g-','Linewidth',1);
% set(gca,'FontSize',14);
% xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
% ylabel('Phase Currents (Amps)','FontSize',14,'FontWeight','Bold')
% xlim([0.08 0.1]);
% ylim([250 300]);
% legend({'Model-Vdc','Simulation-Vdc','Model-Vin','Simulation-Vin'},'Location','best');
% %
% figure;
% hold all;
% plot(time_array,ConverterDCBusCurrent,'b-','Linewidth',1);
% plot(time_array,Idc(1:NumberofSteps)','r-','Linewidth',1);
% plot(time_array,InputCurrent,'k-','Linewidth',1);
% plot(time_array,Iin(1:NumberofSteps)','g-','Linewidth',1);
% set(gca,'FontSize',14);
% xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
% ylabel('Phase Currents (Amps)','FontSize',14,'FontWeight','Bold')
% xlim([0.08 0.1]);
% ylim([-0.5 15]);
% legend({'Model-Idc','Simulation-Idc','Model-Iin','Simulation-Iin'},'Location','best');
% %
% figure;
% hold all;
% plot(time_array,SA*0.9,'b-','Linewidth',1);
% plot(time_array,SAsim(1:NumberofSteps)','r-','Linewidth',1);
% set(gca,'FontSize',14);
% xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
% ylabel('Phase Currents (Amps)','FontSize',14,'FontWeight','Bold')
% xlim([0.09 0.1]);
% ylim([-0.2 1.2]);
% legend({'Model-SA','Simulation-SA'},'Location','best');
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
%% Reference Signal and Carrier
% figure;
% hold all;
% plot(time_array,VrefA,'b-','Linewidth',1);
% plot(time_array,VrefB,'g-','Linewidth',1);
% plot(time_array,VrefC,'k-','Linewidth',1);
% plot(time_array,Vcarrier,'r-','Linewidth',1);
% plot(time_array,Vtriang,'b--','Linewidth',1);
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
