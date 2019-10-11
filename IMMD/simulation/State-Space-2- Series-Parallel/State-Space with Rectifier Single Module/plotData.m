time=currentPhaseA_sim.time;
currentPhaseA_sim=currentPhaseA_sim.data;
currentPhaseB_sim=currentPhaseB_sim.data;
currentPhaseC_sim=currentPhaseC_sim.data;
InputVoltage_sim=InputVoltage_sim.data;
CapacitorVoltage_sim=CapacitorVoltage_sim.data;
currentCap_sim=currentCap_sim.data;
currentDC_sim=currentInverter_sim.data;
%InputCurrent_sim=InputCurrent_sim;
%%
figure;
hold all;
plot(time,currentPhaseA,'b-','Linewidth',2);
plot(time,currentPhaseA_sim,'r-','Linewidth',2);
plot(time,currentPhaseB,'k-','Linewidth',2);
plot(time,currentPhaseB_sim,'m-','Linewidth',2);
plot(time,currentPhaseC,'b-','Linewidth',2);
plot(time,currentPhaseC_sim,'r-','Linewidth',2);
set(gca,'FontSize',14);
title('Phase Currents','FontSize',14, 'FontWeight','Bold')
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel(' Currents (Amps)','FontSize',14,'FontWeight','Bold')
xlim([0.07 0.1])
%xlim([0 40e-3]);
%ylim([-1.2 1.2]);
legend({'Phase-A','Phase-B','Phase-C'},'Location','best');

%% Phase Currents
figure;
hold all;
plot(time,currentPhaseA,'b-','Linewidth',1);
plot(time,currentPhaseB,'r-','Linewidth',1);
plot(time,currentPhaseC,'k-','Linewidth',1);
set(gca,'FontSize',14);
title('Phase Currents','FontSize',14, 'FontWeight','Bold')
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel(' Currents (Amps)','FontSize',14,'FontWeight','Bold')
xlim([0.07 0.1])
%xlim([0 40e-3]);
%ylim([-1.2 1.2]);
legend({'Phase-A','Phase-B','Phase-C'},'Location','best');

%%
figure;
hold all;
plot(time,RectifierVoltage,'k-','Linewidth',2);
set(gca,'FontSize',14);
title('Rectifier Capacitor Voltage','FontSize',14,'FontWeight','Bold')
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Voltages (Volts)','FontSize',14,'FontWeight','Bold')
%xlim([0.07 0.1])


%%

figure;
hold all;
plot(time,InputVoltage,'k-','Linewidth',2);
plot(time,InputVoltage_sim,'r-','Linewidth',2);
set(gca,'FontSize',14);
title('Rectifier Capacitor Voltage','FontSize',14,'FontWeight','Bold')
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Voltages (Volts)','FontSize',14,'FontWeight','Bold')
xlim([0.07 0.1])

%%
figure;
hold all;
plot(time,CapacitorVoltage,'b-','Linewidth',2);
plot(time,CapacitorVoltage_sim,'r-','Linewidth',2);
set(gca,'FontSize',14);
title('Inverter Capacitor Voltage','FontSize',14,'FontWeight','Bold')
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Voltages (Volts)','FontSize',14,'FontWeight','Bold')
%xlim([0 40e-3]);
%ylim([-1.2 1.2]);
xlim([0.07 0.1])
%%
%% DC Bus Currents
figure;
hold all;
plot(time,currentDC,'k','Linewidth',3);
title('Inverter Current','FontSize',14,'FontWeight','Bold');
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Currents (Amps)','FontSize',14,'FontWeight','Bold');
set(gca,'FontSize',14);
xlim([0.07 0.1])


figure;
hold all;
plot(time,currentCap,'r-','Linewidth',2);
title('Capacitor Current ','FontSize',14,'FontWeight','Bold');
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Currents (Amps)','FontSize',14,'FontWeight','Bold')
set(gca,'FontSize',14);
xlim([0.07 0.1])

%%
figure;
hold all;
plot(time,InputCurrent,'b-','Linewidth',2);
plot(time,InputCurrent_sim,'r-','Linewidth',2);
title('Input Current from Rectifier','FontSize',14,'FontWeight','Bold')
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Currents (Amps)','FontSize',14,'FontWeight','Bold')

set(gca,'FontSize',14);

xlim([0.07 0.1])
%%
figure;
hold all;
plot(time,currentCap,'b-','Linewidth',2);
plot(time,currentCap_sim,'r-','Linewidth',2);
title('Capacitor Current ','FontSize',14,'FontWeight','Bold');
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Currents (Amps)','FontSize',14,'FontWeight','Bold')
set(gca,'FontSize',14);
xlim([0.07 0.1])

%%
figure;
hold all;
plot(time,currentDC,'b','Linewidth',1);
plot(time,currentInverter_sim,'r','Linewidth',1);
title('Inverter Current','FontSize',14,'FontWeight','Bold');
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Currents (Amps)','FontSize',14,'FontWeight','Bold');
set(gca,'FontSize',14);
xlim([0.07 0.1]);

%%
figure;
hold all;
plot(time,Vcarrier,'r-','Linewidth',2);
title('Capacitor Current ','FontSize',14,'FontWeight','Bold');
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Currents (Amps)','FontSize',14,'FontWeight','Bold')
set(gca,'FontSize',14);
xlim([0.08 0.1])
ylim([-1.5 1.5]);