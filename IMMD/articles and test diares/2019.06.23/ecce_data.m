% Inner power loop
L_inner_power_loop = 3; % nH
di_dt_rise = 4.77; % A/ns
di_dt_fall = 2.43; % A/ns
L_di_dt_rise = L_inner_power_loop * di_dt_rise % Volts
L_di_dt_fall = L_inner_power_loop * di_dt_fall % Volts



%% Single module - 300V - Capacitor voltages and currents
time_data_200kfilt = VarName1;
Vcap_phA_200kfilt = VarName2;
Vcap_phB_200kfilt = VarName3;
Vcap_phC_200kfilt = VarName4;
Vcap_phA_725kfilt = VarName5;
Vcap_phB_725kfilt = VarName6;
Vcap_phC_725kfilt = VarName7;
time_data_725kfilt = VarName8;

%%
figure;
hold all;
plot(time_data_200kfilt*1e3,Vcap_phA_200kfilt,'r-','Linewidth',1);
plot(time_data_200kfilt*1e3,Vcap_phB_200kfilt,'b-','Linewidth',1);
plot(time_data_200kfilt*1e3,Vcap_phC_200kfilt,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Ripple voltages of capacitors (V)','FontSize',14,'FontWeight','Bold')
xlim([0 100e-3]);
%ylim([0.5 1.1]);
legend({'phA','phB','phC'},'Location','best');
title('Single Module - 300V - 200 kHz filtered');

%%
figure;
hold all;
plot(time_data_725kfilt*1e3,Vcap_phA_725kfilt,'r-','Linewidth',1);
plot(time_data_725kfilt*1e3,Vcap_phB_725kfilt,'b-','Linewidth',1);
plot(time_data_725kfilt*1e3,Vcap_phC_725kfilt,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Ripple voltages of capacitors (V)','FontSize',14,'FontWeight','Bold')
%xlim([0 100e-3]);
%ylim([0.5 1.1]);
legend({'phA','phB','phC'},'Location','best');
title('Single Module - 300V - 725 kHz filtered');

%%
figure;
hold all;
plot(time_data_725kfilt*1e3,Vcap_phA_725kfilt,'b-','Linewidth',1);
plot(time_data_200kfilt*1e3,Vcap_phA_200kfilt,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Ripple voltages of capacitors (V)','FontSize',14,'FontWeight','Bold')
xlim([0 100e-3]);
%ylim([0.5 1.1]);
legend({'725kHz filtered','200kHz filtered'},'Location','best');
title('Single Module - 300V');

%%
Cdc_single = 5e-6; % F
Icap_phA_200kfilt = Cdc_single * (diff(Vcap_phA_200kfilt)./diff(time_data_200kfilt));
Icap_phB_200kfilt = Cdc_single * (diff(Vcap_phB_200kfilt)./diff(time_data_200kfilt));
Icap_phC_200kfilt = Cdc_single * (diff(Vcap_phC_200kfilt)./diff(time_data_200kfilt));
Icap_phA_725kfilt = Cdc_single * (diff(Vcap_phA_725kfilt)./diff(time_data_725kfilt));
Icap_phB_725kfilt = Cdc_single * (diff(Vcap_phB_725kfilt)./diff(time_data_725kfilt));
Icap_phC_725kfilt = Cdc_single * (diff(Vcap_phC_725kfilt)./diff(time_data_725kfilt));

num_200kfilt = numel(Icap_phA_200kfilt);
num_725kfilt = numel(Icap_phA_725kfilt);

%%
figure;
hold all;
plot(time_data_725kfilt(1:num_725kfilt)*1e3,Icap_phA_725kfilt,'b-','Linewidth',1);
plot(time_data_200kfilt(1:num_200kfilt)*1e3,Icap_phA_200kfilt,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Ripple currents of capacitors (A)','FontSize',14,'FontWeight','Bold')
%xlim([0 50e-3]);
%ylim([-10 10]);
legend({'725kHz filtered','200kHz filtered'},'Location','best');
title('Single Module - 300V');


%%
figure;
hold all;
plot(time_data_200kfilt(1:num_200kfilt),Icap_phA_200kfilt,'b-','Linewidth',1);
plot(time_data_200kfilt(1:num_200kfilt),Icap_phB_200kfilt,'r-','Linewidth',1);
plot(time_data_200kfilt(1:num_200kfilt),Icap_phC_200kfilt,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Ripple currents of capacitors (A)','FontSize',14,'FontWeight','Bold')
xlim([0 50e-6]);
%ylim([0.5 1.1]);
legend({'phA','phB','phC'},'Location','best');
title('Single Module - 300V - 200 kHz filtered');

%%
figure;
hold all;
plot(time_data_725kfilt(1:num_725kfilt),Icap_phA_725kfilt,'b-','Linewidth',1);
plot(time_data_725kfilt(1:num_725kfilt),Icap_phB_725kfilt,'r-','Linewidth',1);
plot(time_data_725kfilt(1:num_725kfilt),Icap_phC_725kfilt,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Current (A)','FontSize',14,'FontWeight','Bold')
xlim([0 50e-6]);
%ylim([0.5 1.1]);
legend({'phA','phB','phC'},'Location','best');
title('Single Module - 300V - 725 kHz filtered');

%% RMS
total_sample_200kfilt = num_200kfilt;
total_sample_725kfilt = num_725kfilt;
sampling_time = 40e-9;
cycle_time = 1/40e3*10;
cycle_sample = cycle_time/sampling_time;
total_cycle_200kfilt = floor(total_sample_200kfilt/cycle_sample);
total_cycle_725kfilt = floor(total_sample_725kfilt/cycle_sample);

Icap_rms_phA_200kfilt = zeros(1,total_sample_200kfilt-cycle_sample);
Icap_rms_phB_200kfilt = zeros(1,total_sample_200kfilt-cycle_sample);
Icap_rms_phC_200kfilt = zeros(1,total_sample_200kfilt-cycle_sample);
Icap_rms_phA_725kfilt = zeros(1,total_sample_725kfilt-cycle_sample);
Icap_rms_phB_725kfilt = zeros(1,total_sample_725kfilt-cycle_sample);
Icap_rms_phC_725kfilt = zeros(1,total_sample_725kfilt-cycle_sample);

Icap_rms_phA_200kfilt_2 = zeros(1,total_cycle_200kfilt);
Icap_rms_phB_200kfilt_2 = zeros(1,total_cycle_200kfilt);
Icap_rms_phC_200kfilt_2 = zeros(1,total_cycle_200kfilt);
Icap_rms_phA_725kfilt_2 = zeros(1,total_cycle_725kfilt);
Icap_rms_phB_725kfilt_2 = zeros(1,total_cycle_725kfilt);
Icap_rms_phC_725kfilt_2 = zeros(1,total_cycle_725kfilt);

%%
for k = 1:total_cycle_200kfilt
    rms_pha = 0;
    rms_phb = 0;
    rms_phc = 0;
    for l = 1:cycle_sample-1
        rms_pha = rms_pha + Icap_phA_200kfilt(k*cycle_sample-cycle_sample+l)^2;
        rms_phb = rms_phb + Icap_phB_200kfilt(k*cycle_sample-cycle_sample+l)^2;
        rms_phc = rms_phc + Icap_phC_200kfilt(k*cycle_sample-cycle_sample+l)^2;
    end
    Icap_rms_phA_200kfilt_2(k) = sqrt(rms_pha/cycle_sample);
    Icap_rms_phB_200kfilt_2(k) = sqrt(rms_phb/cycle_sample);
    Icap_rms_phC_200kfilt_2(k) = sqrt(rms_phc/cycle_sample);
end
num_rms_200kfilt_2 = numel(Icap_rms_phA_200kfilt);
time_axis_rms_200kfilt_2 = 0:cycle_time:cycle_time*(total_cycle_200kfilt-1);

for k = 1:total_cycle_725kfilt
    rms_pha = 0;
    rms_phb = 0;
    rms_phc = 0;
    for l = 1:cycle_sample-1
        rms_pha = rms_pha + Icap_phA_725kfilt(k*cycle_sample-cycle_sample+l)^2;
        rms_phb = rms_phb + Icap_phB_725kfilt(k*cycle_sample-cycle_sample+l)^2;
        rms_phc = rms_phc + Icap_phC_725kfilt(k*cycle_sample-cycle_sample+l)^2;
    end
    Icap_rms_phA_725kfilt_2(k) = sqrt(rms_pha/cycle_sample);
    Icap_rms_phB_725kfilt_2(k) = sqrt(rms_phb/cycle_sample);
    Icap_rms_phC_725kfilt_2(k) = sqrt(rms_phc/cycle_sample);
end
num_rms_725kfilt_2 = numel(Icap_rms_phA_725kfilt);
time_axis_rms_725kfilt_2 = 0:cycle_time:cycle_time*(total_cycle_725kfilt-1);

%%
for k = cycle_sample+1:total_sample_200kfilt
    rms_pha = 0;
    rms_phb = 0;
    rms_phc = 0;
    for l = 1:cycle_sample
        rms_pha = rms_pha + Icap_phA_200kfilt(k-cycle_sample+l)^2;
        rms_phb = rms_phb + Icap_phB_200kfilt(k-cycle_sample+l)^2;
        rms_phc = rms_phc + Icap_phC_200kfilt(k-cycle_sample+l)^2;
    end
    Icap_rms_phA_200kfilt(k) = sqrt(rms_pha/cycle_sample);
    Icap_rms_phB_200kfilt(k) = sqrt(rms_phb/cycle_sample);
    Icap_rms_phC_200kfilt(k) = sqrt(rms_phc/cycle_sample);
end
num_rms_200kfilt = numel(Icap_rms_phA_200kfilt);

for k = cycle_sample+1:total_sample_725kfilt
    rms_pha = 0;
    rms_phb = 0;
    rms_phc = 0;
    for l = 1:cycle_sample
        rms_pha = rms_pha + Icap_phA_725kfilt(k-cycle_sample+l)^2;
        rms_phb = rms_phb + Icap_phB_725kfilt(k-cycle_sample+l)^2;
        rms_phc = rms_phc + Icap_phC_725kfilt(k-cycle_sample+l)^2;
    end
    Icap_rms_phA_725kfilt(k) = sqrt(rms_pha/cycle_sample);
    Icap_rms_phB_725kfilt(k) = sqrt(rms_phb/cycle_sample);
    Icap_rms_phC_725kfilt(k) = sqrt(rms_phc/cycle_sample);
end
num_rms_725kfilt = numel(Icap_rms_phA_725kfilt);

%%
figure;
hold all;
plot(time_data_200kfilt(1:num_rms_200kfilt),Icap_rms_phA_200kfilt,'b-','Linewidth',1);
plot(time_data_200kfilt(1:num_rms_200kfilt),Icap_rms_phB_200kfilt,'r-','Linewidth',1);
plot(time_data_200kfilt(1:num_rms_200kfilt),Icap_rms_phC_200kfilt,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('RMS of capacitor currents - 1kHz cycle (A)','FontSize',14,'FontWeight','Bold')
%xlim([0 100e-6]);
%ylim([0.5 1.1]);
legend({'phA','phB','phC'},'Location','best');
title('Single Module - 300V - 200 kHz filtered');

%%
figure;
hold all;
plot(time_data_725kfilt(1:num_rms_725kfilt),Icap_rms_phA_725kfilt,'b-','Linewidth',1);
plot(time_data_725kfilt(1:num_rms_725kfilt),Icap_rms_phB_725kfilt,'r-','Linewidth',1);
plot(time_data_725kfilt(1:num_rms_725kfilt),Icap_rms_phC_725kfilt,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('RMS of capacitor currents - 1kHz cycle (A)','FontSize',14,'FontWeight','Bold')
%xlim([0 100e-6]);
%ylim([0.5 1.1]);
legend({'phA','phB','phC'},'Location','best');
title('Single Module - 300V - 725 kHz filtered');

%%
figure;
hold all;
plot(time_axis_rms_200kfilt_2,Icap_rms_phA_200kfilt_2,'b-','Linewidth',1);
plot(time_axis_rms_200kfilt_2,Icap_rms_phB_200kfilt_2,'r-','Linewidth',1);
plot(time_axis_rms_200kfilt_2,Icap_rms_phC_200kfilt_2,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('RMS of capacitor currents - 1kHz cycle (A)','FontSize',14,'FontWeight','Bold')
%xlim([0 100e-6]);
ylim([0 2]);
legend({'phA','phB','phC'},'Location','best');
title('Single Module - 300V - 200 kHz filtered');

%%
figure;
hold all;
plot(time_axis_rms_200kfilt_2,Icap_rms_phA_725kfilt_2,'b-','Linewidth',1);
plot(time_axis_rms_200kfilt_2,Icap_rms_phB_725kfilt_2,'r-','Linewidth',1);
plot(time_axis_rms_200kfilt_2,Icap_rms_phC_725kfilt_2,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('RMS of capacitor currents - 1kHz cycle (A)','FontSize',14,'FontWeight','Bold')
%xlim([0 100e-6]);
ylim([0 6]);
legend({'phA','phB','phC'},'Location','best');
title('Single Module - 300V - 725 kHz filtered');


%% ////////////////
% DC Link current

time_data_200kfilt = VarName1;
Idclink_phA_200kfilt = VarName2;
Idclink_phB_200kfilt = VarName3;
Idclink_phC_200kfilt = VarName4;
Idclink_phA_725kfilt = VarName5;
Idclink_phB_725kfilt = VarName6;
Idclink_phC_725kfilt = VarName7;
time_data_725kfilt = VarName8;

%%
figure;
hold all;
plot(time_data_725kfilt*1e3,Idclink_phA_725kfilt,'r-','Linewidth',1);
plot(time_data_200kfilt*1e3,Idclink_phA_200kfilt,'b-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('DC Link current (A)','FontSize',14,'FontWeight','Bold')
xlim([0 100e-3]);
ylim([6 8]);
legend({'725kHz filtered','200kHz filtered'},'Location','best');
title('Single Module - 300V');

