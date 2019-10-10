time=currentPhaseA.time;
currentPhaseA=currentPhaseA.data;
currentPhaseB=currentPhaseB.data;
currentPhaseC=currentPhaseC.data;
InputVoltage=InputVoltage.data;
CapacitorVoltage=CapacitorVoltage.data;
currentCap=currentCap.data;
currentDC=currentInverter.data;
InputCurrent=InputCurrent.data;
%%

% %% Phase Currents
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
plot(time,InputVoltage,'k-','Linewidth',2)
set(gca,'FontSize',14);
title('Rectifier Capacitor Voltage','FontSize',14,'FontWeight','Bold')
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Voltages (Volts)','FontSize',14,'FontWeight','Bold')
xlim([0.07 0.1])

%%
figure;
hold all;
plot(time,CapacitorVoltage,'b-','Linewidth',2);
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


figure;
hold all;
plot(time,InputCurrent,'b-','Linewidth',2);
title('Input Current from Rectifier','FontSize',14,'FontWeight','Bold')
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Currents (Amps)','FontSize',14,'FontWeight','Bold')

set(gca,'FontSize',14);

xlim([0.07 0.1])
%%
