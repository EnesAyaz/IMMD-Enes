SampleTime = 1e-12; %Time Steps
StopTime = 500e-8; %Stop Time
fsw = 3e6;
t = (0 : SampleTime : StopTime);
t=t(1,1:end-1);
Dtop=30;
Dbot=68;

[Top,Bottom]=PulseGenerator(t,fsw,SampleTime,Dtop,Dbot);

figure(1)
subplot(2,1,1)
plot(t,Top,'LineWidth',2);
ylim([-4 7]);
subplot(2,1,2)
plot(t,Bottom,'LineWidth',2)
ylim([-4 7]);
grid on;
grid minor;