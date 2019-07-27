time_data_noint_200kfilt = VarName1;
Vdctotal_noint_200kfilt = VarName2;
Vdcbot_noint_200kfilt = VarName3;
Vdctop_noint_200kfilt = VarName4;
Vdctotal_noint_725kfilt = VarName5;
Vdcbot_noint_725kfilt = VarName6;
Vdctop_noint_725kfilt = VarName7;
time_data_noint_725kfilt = VarName8;

time_data_yesint_200kfilt = VarName9;
Vdctotal_yesint_200kfilt = VarName10;
Vdcbot_yesint_200kfilt = VarName11;
Vdctop_yesint_200kfilt = VarName12;
Vdctotal_yesint_725kfilt = VarName13;
Vdcbot_yesint_725kfilt = VarName14;
Vdctop_yesint_725kfilt = VarName15;
time_data_yesint_725kfilt = VarName16;

%%
figure;
hold all;
plot(time_data_noint_200kfilt*1e3,Vdctotal_noint_200kfilt,'r-','Linewidth',1);
plot(time_data_noint_200kfilt*1e3,Vdcbot_noint_200kfilt,'b-','Linewidth',1);
plot(time_data_noint_200kfilt*1e3,Vdctop_noint_200kfilt,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('DC Link voltage ripple (V)','FontSize',14,'FontWeight','Bold')
xlim([-4.08 -3.97]);
%ylim([0.5 1.1]);
legend({'Total','Top module','Bottom module'},'Location','best');
title('Series - 100V - No int - 200 kHz filtered');


%%
figure;
hold all;
plot(time_data_noint_725kfilt*1e3,Vdctotal_noint_725kfilt,'r-','Linewidth',1);
plot(time_data_noint_725kfilt*1e3,Vdcbot_noint_725kfilt,'b-','Linewidth',1);
plot(time_data_noint_725kfilt*1e3,Vdctop_noint_725kfilt,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('DC Link voltage ripple (V)','FontSize',14,'FontWeight','Bold')
xlim([-4.08 -3.97]);
%ylim([0.5 1.1]);
legend({'Total','Top module','Bottom module'},'Location','best');
title('Series - 100V - No int - 725 kHz filtered');

%%
figure;
hold all;
plot(time_data_yesint_200kfilt*1e3,Vdctotal_yesint_200kfilt,'r-','Linewidth',1);
plot(time_data_yesint_200kfilt*1e3,Vdcbot_yesint_200kfilt,'b-','Linewidth',1);
plot(time_data_yesint_200kfilt*1e3,Vdctop_yesint_200kfilt,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('DC Link voltage ripple (V)','FontSize',14,'FontWeight','Bold')
xlim([-4.08 -3.97]);
%ylim([0.5 1.1]);
legend({'Total','Top module','Bottom module'},'Location','best');
title('Series - 100V - Yes int - 200 kHz filtered');


%%
figure;
hold all;
plot(time_data_yesint_725kfilt*1e3,Vdctotal_yesint_725kfilt,'r-','Linewidth',1);
plot(time_data_yesint_725kfilt*1e3,Vdcbot_yesint_725kfilt,'b-','Linewidth',1);
plot(time_data_yesint_725kfilt*1e3,Vdctop_yesint_725kfilt,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('DC Link voltage ripple (V)','FontSize',14,'FontWeight','Bold')
%xlim([-4.08 -3.97]);
%ylim([0.5 1.1]);
legend({'Total','Top module','Bottom module'},'Location','best');
title('Series - 100V - Yes int - 725 kHz filtered');

%%
figure;
hold all;
plot(time_data_noint_200kfilt*1e3,Vdctotal_noint_200kfilt-mean(Vdctotal_noint_200kfilt),'b-','Linewidth',1);
plot(time_data_yesint_200kfilt*1e3,Vdctotal_yesint_200kfilt,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Total DC Link voltage ripple (V)','FontSize',14,'FontWeight','Bold')
xlim([0 100e-3]);
%ylim([0.5 1.1]);
legend({'No int','Yes int'},'Location','best');
title('Series - 100V - 200 kHz filtered');

%%
figure;
hold all;
plot(time_data_noint_725kfilt*1e3,Vdctotal_noint_725kfilt-mean(Vdctotal_noint_725kfilt),'b-','Linewidth',1);
plot(time_data_yesint_725kfilt*1e3,Vdctotal_yesint_725kfilt,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Total DC Link voltage ripple (V)','FontSize',14,'FontWeight','Bold')
%xlim([0 100e-3]);
%ylim([0.5 1.1]);
legend({'No int','Yes int'},'Location','best');
title('Series - 100V - 725 kHz filtered');


%% Modification of voltage ripples by cycle based averaging

num_200kfilt = numel(time_data_noint_200kfilt);
%num_725kfilt = numel(time_data_noint_725kfilt);
total_sample_200kfilt = num_200kfilt;
%total_sample_725kfilt = num_725kfilt;
sampling_time = 40e-9;
cycle_time = 1/40e3*4;
cycle_sample = cycle_time/sampling_time;
total_cycle_200kfilt = floor(total_sample_200kfilt/cycle_sample);
%total_cycle_725kfilt = floor(total_sample_725kfilt/cycle_sample);
clear Vdcbot_noint_200kfilt_modified;
Vdcbot_noint_200kfilt_modified = zeros(1,num_200kfilt);
clear Vdctop_noint_200kfilt_modified;
Vdctop_noint_200kfilt_modified = zeros(1,num_200kfilt);
clear Vdctotal_noint_200kfilt_modified;
Vdctotal_noint_200kfilt_modified = zeros(1,num_200kfilt);
clear Vdcbot_yesint_200kfilt_modified;
Vdcbot_yesint_200kfilt_modified = zeros(1,num_200kfilt);
clear Vdctop_yesint_200kfilt_modified;
Vdctop_yesint_200kfilt_modified = zeros(1,num_200kfilt);
clear Vdctotal_yesint_200kfilt_modified;
Vdctotal_yesint_200kfilt_modified = zeros(1,num_200kfilt);
for k = 1:total_cycle_200kfilt
   avg_in_cycle_bot_noint = mean(Vdcbot_noint_200kfilt((k-1)*cycle_sample+1:k*cycle_sample));
   avg_in_cycle_top_noint = mean(Vdctop_noint_200kfilt((k-1)*cycle_sample+1:k*cycle_sample));
   avg_in_cycle_total_noint = mean(Vdctotal_noint_200kfilt((k-1)*cycle_sample+1:k*cycle_sample));
   avg_in_cycle_bot_yesint = mean(Vdcbot_yesint_200kfilt((k-1)*cycle_sample+1:k*cycle_sample));
   avg_in_cycle_top_yesint = mean(Vdctop_yesint_200kfilt((k-1)*cycle_sample+1:k*cycle_sample));
   avg_in_cycle_total_yesint = mean(Vdctotal_yesint_200kfilt((k-1)*cycle_sample+1:k*cycle_sample));
      for l = 1:cycle_sample
       Vdcbot_noint_200kfilt_modified(1,(k-1)*cycle_sample+l) = Vdcbot_noint_200kfilt((k-1)*cycle_sample+l) - avg_in_cycle_bot_noint;
       Vdctop_noint_200kfilt_modified(1,(k-1)*cycle_sample+l) = Vdctop_noint_200kfilt((k-1)*cycle_sample+l) - avg_in_cycle_top_noint;
       Vdctotal_noint_200kfilt_modified(1,(k-1)*cycle_sample+l) = Vdctotal_noint_200kfilt((k-1)*cycle_sample+l) - avg_in_cycle_total_noint;
       Vdcbot_yesint_200kfilt_modified(1,(k-1)*cycle_sample+l) = Vdcbot_yesint_200kfilt((k-1)*cycle_sample+l) - avg_in_cycle_bot_yesint;
       Vdctop_yesint_200kfilt_modified(1,(k-1)*cycle_sample+l) = Vdctop_yesint_200kfilt((k-1)*cycle_sample+l) - avg_in_cycle_top_yesint;
       Vdctotal_yesint_200kfilt_modified(1,(k-1)*cycle_sample+l) = Vdctotal_yesint_200kfilt((k-1)*cycle_sample+l) - avg_in_cycle_total_yesint;
     end
end

%% Plots of original vs modified (averaging)
figure;
hold all;
plot(time_data_noint_200kfilt*1e3,Vdcbot_noint_200kfilt,'b-','Linewidth',1);
plot(time_data_noint_200kfilt*1e3,Vdcbot_noint_200kfilt_modified,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Bottom voltage ripple (V)','FontSize',14,'FontWeight','Bold')
%xlim([-4.5 -4.2]);
%ylim([0.5 1.1]);
legend({'No averaging','Averaging'},'Location','best');
title('Series - 100V - No int - 200 kHz filtered');

figure;
hold all;
plot(time_data_noint_200kfilt*1e3,Vdctop_noint_200kfilt,'b-','Linewidth',1);
plot(time_data_noint_200kfilt*1e3,Vdctop_noint_200kfilt_modified,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Top voltage ripple (V)','FontSize',14,'FontWeight','Bold')
%xlim([-4.5 -4.2]);
%ylim([0.5 1.1]);
legend({'No averaging','Averaging'},'Location','best');
title('Series - 100V - No int - 200 kHz filtered');

figure;
hold all;
plot(time_data_noint_200kfilt*1e3,Vdctotal_noint_200kfilt,'b-','Linewidth',1);
plot(time_data_noint_200kfilt*1e3,Vdctotal_noint_200kfilt_modified,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Total voltage ripple (V)','FontSize',14,'FontWeight','Bold')
%xlim([-4.5 -4.2]);
%ylim([0.5 1.1]);
legend({'No averaging','Averaging'},'Location','best');
title('Series - 100V - No int - 200 kHz filtered');

figure;
hold all;
plot(time_data_yesint_200kfilt*1e3,Vdcbot_yesint_200kfilt,'b-','Linewidth',1);
plot(time_data_yesint_200kfilt*1e3,Vdcbot_yesint_200kfilt_modified,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Bottom voltage ripple (V)','FontSize',14,'FontWeight','Bold')
%xlim([-4.5 -4.2]);
%ylim([0.5 1.1]);
legend({'No averaging','Averaging'},'Location','best');
title('Series - 100V - Yes int - 200 kHz filtered');

figure;
hold all;
plot(time_data_yesint_200kfilt*1e3,Vdctop_yesint_200kfilt,'b-','Linewidth',1);
plot(time_data_yesint_200kfilt*1e3,Vdctop_yesint_200kfilt_modified,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Top voltage ripple (V)','FontSize',14,'FontWeight','Bold')
%xlim([-4.5 -4.2]);
%ylim([0.5 1.1]);
legend({'No averaging','Averaging'},'Location','best');
title('Series - 100V - Yes int - 200 kHz filtered');

figure;
hold all;
plot(time_data_yesint_200kfilt*1e3,Vdctotal_yesint_200kfilt,'b-','Linewidth',1);
plot(time_data_yesint_200kfilt*1e3,Vdctotal_yesint_200kfilt_modified,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Total voltage ripple (V)','FontSize',14,'FontWeight','Bold')
%xlim([-4.5 -4.2]);
%ylim([0.5 1.1]);
legend({'No averaging','Averaging'},'Location','best');
title('Series - 100V - Yes int - 200 kHz filtered');


%% Plots of interleaving
figure;
hold all;
plot(time_data_noint_200kfilt*1e3,Vdcbot_noint_200kfilt_modified,'b-','Linewidth',1);
plot(time_data_noint_200kfilt*1e3,Vdctop_noint_200kfilt_modified,'k-','Linewidth',1);
plot(time_data_noint_200kfilt*1e3,Vdctotal_noint_200kfilt_modified,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Total voltage ripple (V)','FontSize',14,'FontWeight','Bold')
%xlim([0 100e-3]);
ylim([-0.5 0.5]);
legend({'Bottom','Top','Total'},'Location','best');
title('Series - 100V - No int - 200 kHz filtered');

figure;
hold all;
plot(time_data_yesint_200kfilt*1e3,Vdcbot_yesint_200kfilt_modified,'b-','Linewidth',1);
plot(time_data_yesint_200kfilt*1e3,Vdctop_yesint_200kfilt_modified,'k-','Linewidth',1);
plot(time_data_yesint_200kfilt*1e3,Vdctotal_yesint_200kfilt_modified,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Total voltage ripple (V)','FontSize',14,'FontWeight','Bold')
%xlim([0 100e-3]);
ylim([-0.5 0.5]);
legend({'Bottom','Top','Total'},'Location','best');
title('Series - 100V - Yes int - 200 kHz filtered');

figure;
hold all;
plot(time_data_noint_200kfilt*1e3,Vdcbot_noint_200kfilt_modified,'b-','Linewidth',1);
plot(time_data_yesint_200kfilt*1e3,Vdcbot_yesint_200kfilt_modified,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Total voltage ripple (V)','FontSize',14,'FontWeight','Bold')
xlim([0 100e-3]);
ylim([-0.5 0.5]);
legend({'Bottom','Top','Total'},'Location','best');
title('Series - 100V - Yes int - 200 kHz filtered');

figure;
hold all;
plot(time_data_noint_200kfilt*1e3,Vdctop_noint_200kfilt_modified,'b-','Linewidth',1);
plot(time_data_yesint_200kfilt*1e3,Vdctop_yesint_200kfilt_modified,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Total voltage ripple (V)','FontSize',14,'FontWeight','Bold')
xlim([0 100e-3]);
ylim([-0.5 0.5]);
legend({'Bottom','Top','Total'},'Location','best');
title('Series - 100V - Yes int - 200 kHz filtered');

figure;
hold all;
plot(time_data_noint_200kfilt*1e3,Vdctotal_noint_200kfilt_modified,'b-','Linewidth',1);
plot(time_data_yesint_200kfilt*1e3,Vdctotal_yesint_200kfilt_modified,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Total voltage ripple (V)','FontSize',14,'FontWeight','Bold')
xlim([0 100e-3]);
ylim([-0.5 0.5]);
legend({'Bottom','Top','Total'},'Location','best');
title('Series - 100V - Yes int - 200 kHz filtered');


%% For only data check - not used
figure;
hold all;
%plot(time_data_noint_200kfilt*1e3,Vdctotal_noint_200kfilt,'r-','Linewidth',1);
%plot(time_data_noint_725kfilt*1e3,Vdctotal_noint_725kfilt,'b-','Linewidth',1);
%plot(time_data_noint_200kfilt*1e3,Vdcbot_noint_200kfilt,'b-','Linewidth',1);
%plot(time_data_noint_725kfilt*1e3,Vdcbot_noint_725kfilt,'r-','Linewidth',1);
plot(time_data_noint_200kfilt*1e3,Vdctop_noint_200kfilt,'k-','Linewidth',1);
plot(time_data_noint_725kfilt*1e3,Vdctop_noint_725kfilt,'r-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('DC Link voltage ripple (V)','FontSize',14,'FontWeight','Bold')
xlim([-4.08 -4]);
%ylim([0.5 1.1]);
legend({'Total','Top module','Bottom module'},'Location','best');
title('Series - 100V - No int - 200 kHz filtered');
