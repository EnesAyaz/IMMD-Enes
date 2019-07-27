%save('ecce_parallel.mat');

%%
%load('ecce_parallel.mat');

%% AC Waveforms plot
figure;
hold all;
plot(time_data_yesint_200v*1e3,Vllabm1_yesint_200v,'b-','Linewidth',1);
plot(time_data_yesint_200v*1e3,Iam1_yesint_200v*10,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Voltage (Volts), Current (Amps)','FontSize',14,'FontWeight','Bold')
%xlim([-4.08 -3.97]);
legend({'M1-Vab','M1-Ia x10'},'Location','best');
title('Parallel - 200V - Yes interleaving');

%%
figure;
hold all;
plot(time_data_yesint_200v*1e3,Vllabm2_yesint_200v,'b-','Linewidth',1);
plot(time_data_yesint_200v*1e3,Iam2_yesint_200v*10,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Voltage (Volts), Current (Amps)','FontSize',14,'FontWeight','Bold')
%xlim([-4.08 -3.97]);
legend({'M2-Vab','M2-Ia x10'},'Location','best');
title('Parallel - 200V - Yes interleaving');

%%
figure;
hold all;
plot(time_data_yesint_200v*1e3,Vllabm2_yesint_200v,'g-','Linewidth',1);
plot(time_data_yesint_200v*1e3,Vllabm1_yesint_200v,'b-','Linewidth',1);
plot(time_data_yesint_200v*1e3,Iam1_yesint_200v*10,'r-','Linewidth',1);
plot(time_data_yesint_200v*1e3,Iam2_yesint_200v*10,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Voltage (Volts), Current (Amps)','FontSize',14,'FontWeight','Bold')
xlim([-10 20]);
legend({'M2-Vab','M1-Vab','M1-Ia x10','M2-Ia x10'},'Location','best');
title('Parallel - 200V - Yes interleaving');

%%
figure;
hold all;
plot(time_data_yesint_200v*1e3,Vllabm2_yesint_200v,'g-','Linewidth',1);
plot(time_data_yesint_200v*1e3,Vllabm1_yesint_200v,'b-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Voltage (Volts), Current (Amps)','FontSize',14,'FontWeight','Bold')
xlim([-10 20]);
legend({'M2-Vab','M1-Vab'},'Location','best');
title('Parallel - 200V - Yes interleaving');

%%
figure;
hold all;
plot(time_data_yesint_200v*1e3,Iam1_yesint_200v,'r-','Linewidth',1);
plot(time_data_yesint_200v*1e3,Iam2_yesint_200v,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Voltage (Volts), Current (Amps)','FontSize',14,'FontWeight','Bold')
xlim([-10 20]);
legend({'M1-Ia','M2-Ia'},'Location','best');
title('Parallel - 200V - Yes interleaving');




%% DC voltage
figure;
hold all;
plot(time_noint_200v_725khz*1e3,Vdc_noint_200v_725khz-mean(Vdc_noint_200v_725khz),'b-','Linewidth',1);
plot(time_noint_200v_200khz*1e3,Vdc_noint_200v_200khz-mean(Vdc_noint_200v_200khz),'r-','Linewidth',1);
%plot(time_yesint_200v_725khz*1e3,Vdc_yesint_200v_725khz,'g-','Linewidth',1);
%plot(time_yesint_200v_200khz*1e3,Vdc_yesint_200v_200khz,'b-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Voltage (Volts)','FontSize',14,'FontWeight','Bold')
xlim([0 0.1]);
legend({'Vdc-No int-725kHz filter','Vdc-No int-200kHz filter'},'Location','best');
title('Parallel - 200V - No interleaving');

%%
figure;
hold all;
plot(time_yesint_200v_725khz*1e3,Vdc_yesint_200v_725khz-mean(Vdc_yesint_200v_725khz),'b-','Linewidth',1);
plot(time_yesint_200v_200khz*1e3,Vdc_yesint_200v_200khz-mean(Vdc_yesint_200v_200khz),'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Voltage (Volts)','FontSize',14,'FontWeight','Bold')
xlim([0 0.1]);
legend({'Vdc-Yes int-725kHz filter','Vdc-Yes int-200kHz filter'},'Location','best');
title('Parallel - 200V - Yes interleaving');

%%
figure;
hold all;
plot(time_noint_200v_200khz*1e3,Vdc_noint_200v_200khz-mean(Vdc_noint_200v_200khz),'b-','Linewidth',1);
plot(time_yesint_200v_200khz*1e3,Vdc_yesint_200v_200khz-mean(Vdc_yesint_200v_200khz),'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Voltage (Volts)','FontSize',14,'FontWeight','Bold')
%xlim([0 0.1]);
legend({'Vdc-No int-200kHz filter','Vdc-Yes int-200kHz filter'},'Location','best');
title('Parallel - 200V - 200 kHz filtered');

%%
figure;
hold all;
plot(time_noint_200v_725khz*1e3,Vdc_noint_200v_725khz-mean(Vdc_noint_200v_725khz),'b-','Linewidth',1);
plot(time_yesint_200v_725khz*1e3,Vdc_yesint_200v_725khz-mean(Vdc_yesint_200v_725khz),'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Voltage (Volts)','FontSize',14,'FontWeight','Bold')
xlim([1 1.1]);
legend({'Vdc-No int-200kHz filter','Vdc-Yes int-200kHz filter'},'Location','best');
title('Parallel - 200V - 725 kHz filtered');


%% DC current - CP
figure;
hold all;
plot(time_noint_200v_200khz*1e3,Idcm1cp1_noint_200v_200khz,'r-','Linewidth',1);
plot(time_noint_200v_200khz*1e3,Idcm2cp2_noint_200v_200khz,'b-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
xlim([0 0.1]);
legend({'Idc-1','Idc-2'},'Location','best');
title('Parallel - 200V - No interleaving - 200 kHz');

%%
figure;
hold all;
plot(time_yesint_200v_200khz*1e3,Idcm1cp1_yesint_200v_200khz,'r-','Linewidth',1);
plot(time_yesint_200v_200khz*1e3,Idcm2cp2_yesint_200v_200khz,'b-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
xlim([0 0.1]);
legend({'Idc-1','Idc-2'},'Location','best');
title('Parallel - 200V - Yes interleaving - 200 kHz');

%%
figure;
hold all;
plot(time_noint_200v_200khz*1e3,Idcm1cp1_noint_200v_200khz-Idcm2cp2_noint_200v_200khz,'b-','Linewidth',1);
plot(time_noint_200v_200khz*1e3,Idcm1cp1_noint_200v_200khz+Idcm2cp2_noint_200v_200khz,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
xlim([0 0.1]);
legend({'Difference of currents','Sum of currents'},'Location','best');
title('Parallel - 200V - No interleaving - 200 kHz');

%%
figure;
hold all;
plot(time_yesint_200v_200khz*1e3,Idcm1cp1_yesint_200v_200khz-Idcm2cp2_yesint_200v_200khz,'b-','Linewidth',1);
plot(time_yesint_200v_200khz*1e3,Idcm1cp1_yesint_200v_200khz+Idcm2cp2_yesint_200v_200khz,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
xlim([0 0.1]);
legend({'Difference of currents','Sum of currents'},'Location','best');
title('Parallel - 200V - Yes interleaving - 200 kHz');

%%
figure;
hold all;
plot(time_yesint_200v_200khz*1e3,Idcm1cp1_yesint_200v_200khz-Idcm2cp2_yesint_200v_200khz,'b-','Linewidth',1);
plot(time_noint_200v_200khz*1e3,Idcm1cp1_noint_200v_200khz-Idcm2cp2_noint_200v_200khz,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
xlim([0 0.1]);
legend({'Difference of currents - Yes int','Difference of currents - No int'},'Location','best');
title('Parallel - 200V - 200 kHz');

%%
figure;
hold all;
plot(time_yesint_200v_200khz*1e3,Idcm1cp1_yesint_200v_200khz+Idcm2cp2_yesint_200v_200khz,'b-','Linewidth',1);
plot(time_noint_200v_200khz*1e3,Idcm1cp1_noint_200v_200khz+Idcm2cp2_noint_200v_200khz,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
xlim([0 0.1]);
legend({'Sum of currents - Yes int','Sum of currents - No int'},'Location','best');
title('Parallel - 200V - 200 kHz');



%% DC current - SR
figure;
hold all;
plot(time_noint_200v_200khz*1e3,Idcm1sh1_noint_200v_200khz,'r-','Linewidth',1);
plot(time_noint_200v_200khz*1e3,Idcm2sh3_noint_200v_200khz,'b-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
xlim([0 0.1]);
ylim([0 5]);
legend({'Idc-1','Idc-2'},'Location','best');
title('Parallel - 200V - No interleaving - 200 kHz');

%%
figure;
hold all;
plot(time_yesint_200v_200khz*1e3,Idcm1sh1_yesint_200v_200khz,'r-','Linewidth',1);
plot(time_yesint_200v_200khz*1e3,Idcm2sh3_yesint_200v_200khz,'b-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
xlim([0 0.1]);
legend({'Idc-1','Idc-2'},'Location','best');
title('Parallel - 200V - Yes interleaving - 200 kHz');

%%
figure;
hold all;
plot(time_noint_200v_200khz*1e3,Idcm1sh1_noint_200v_200khz-Idcm2sh3_noint_200v_200khz,'b-','Linewidth',1);
plot(time_noint_200v_200khz*1e3,Idcm1sh1_noint_200v_200khz+Idcm2sh3_noint_200v_200khz,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
%xlim([0 0.1]);
legend({'Difference of currents','Sum of currents'},'Location','best');
title('Parallel - 200V - No interleaving - 200 kHz');

%%
figure;
hold all;
plot(time_yesint_200v_200khz*1e3,Idcm1sh1_yesint_200v_200khz-Idcm2sh3_yesint_200v_200khz,'b-','Linewidth',1);
plot(time_yesint_200v_200khz*1e3,Idcm1sh1_yesint_200v_200khz+Idcm2sh3_yesint_200v_200khz,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
%xlim([0 0.1]);
legend({'Difference of currents','Sum of currents'},'Location','best');
title('Parallel - 200V - Yes interleaving - 200 kHz');

%%
figure;
hold all;
plot(time_yesint_200v_200khz*1e3,Idcm1sh1_yesint_200v_200khz-Idcm2sh3_yesint_200v_200khz,'b-','Linewidth',1);
plot(time_noint_200v_200khz*1e3,Idcm1sh1_noint_200v_200khz-Idcm2sh3_noint_200v_200khz,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
%xlim([0 0.1]);
legend({'Difference of currents - Yes int','Difference of currents - No int'},'Location','best');
title('Parallel - 200V - 200 kHz');

%%
figure;
hold all;
plot(time_noint_200v_200khz*1e3,Idcm1sh1_noint_200v_200khz+Idcm2sh3_noint_200v_200khz,'r-','Linewidth',1);
plot(time_yesint_200v_200khz*1e3,Idcm1sh1_yesint_200v_200khz+Idcm2sh3_yesint_200v_200khz,'b-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
%xlim([0 0.1]);
legend({'Sum of currents - No int','Sum of currents - Yes int'},'Location','best');
title('Parallel - 200V - 200 kHz');

%% etkisi olmadý
figure;
hold all;
plot(time_yesint_200v_725khz*1e3,Idcm1sh1_yesint_200v_725khz-Idcm2sh3_yesint_200v_725khz,'r-','Linewidth',1);
plot(time_yesint_200v_200khz*1e3,Idcm1sh1_yesint_200v_200khz-Idcm2sh3_yesint_200v_200khz,'b-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold');
ylabel('Current (Amps)','FontSize',14,'FontWeight','Bold')
xlim([0 0.1]);
legend({'725 kHz filtered','200 kHz filtered'},'Location','best');
title('Parallel - 200V - Difference of currents - Yes int');

