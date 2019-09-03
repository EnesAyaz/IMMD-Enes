%%
% time= simout.ACapCurr.Time(100:end);
% capA= simout.ACapCurr.Data(100:end);
% capB=simout.BCapCurr.Data(100:end);
% capC=simout.CCapCurr.Data(100:end);
% save('CapacitorCurr.mat','time','capA','capB','capC');

dummy2= 0*sin(2*80000*pi.*time-345*pi/180);
close all;

%%
figure;
hold all;
subplot(2,2,1);
plot(time,capA,'b-','Linewidth',1);
xlabel('time(sec)','FontSize',14,'FontWeight','Bold')
ylabel('Current(A)','FontSize',14,'FontWeight','Bold')
title('phase A capacitor ripple current','FontSize',14,'FontWeight','Bold')
subplot(2,2,2);
plot(time,capB,'k-','Linewidth',1);
xlabel('time(sec)','FontSize',14,'FontWeight','Bold')
ylabel('Current(A)','FontSize',14,'FontWeight','Bold')
title('phase B capacitor ripple current','FontSize',14,'FontWeight','Bold')
subplot(2,2,3);
plot(time,capC,'r-','Linewidth',1);
% set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',14);
xlabel('time(sec)','FontSize',14,'FontWeight','Bold')
ylabel('Current(A)','FontSize',14,'FontWeight','Bold')
title('phase C capacitor ripple current','FontSize',14,'FontWeight','Bold')
% xlim([1 10000]);
%ylim([-1.2 1.2]);
% legend({'phA Cap','phB Cap','phC Cap'},'Location','best');

threshold=0.15;
%% fft analysis
f_s= 1/(time(2)-time(1));

y = fft(capA+dummy2);

L=length(y);

P2= abs(y/L);
P1=P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);

f= f_s*(0:(L/2))/L;

figure(9);
hold all
stem(f,P1)
xlim([0 10^6])
% ylim([0 1])
A=[];

for i= 1:length(P1)
   if P1(i)> threshold
   A=[A; [f(i),P1(i)]];
    
   end
    
end

%%
 c= [];
for i=1:length(A(:,1))
   dummy=string(A(i,1)/1000);
   c= [c,dummy];
end

figure(10);
hold all;
bar(A(:,2));
set(gca,'xticklabel',c.')
set(gca,'FontSize',14);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel('Magnitude of FFT','FontSize',14,'FontWeight','Bold')
title('Capacitor Phase A FFT analysis')

clear y
clear A
clear P1
clear P2
clear f_s
clear c


%%  phase B


% fft analysis
f_s= 1/(time(2)-time(1));

y = fft(capB);

L=length(y);

P2= abs(y/L);
P1=P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);

f= f_s*(0:(L/2))/L;

figure(9);
stem(f,P1)
xlim([0 10^6])
ylim([0 1])
A=[];

for i= 1:length(P1)
   if P1(i)> threshold
   A=[A; [f(i),P1(i)]];
    
   end
    
end

%
 c= [];
for i=1:length(A(:,1))
   dummy=string(A(i,1)/1000);
   c= [c,dummy];
end

figure(10);
bar(A(:,2));
set(gca,'xticklabel',c.')
set(gca,'FontSize',14);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel('Magnitude of FFT','FontSize',14,'FontWeight','Bold')
title('Capacitor Phase B FFT analysis')

clear y
clear A
clear P1
clear P2
clear f_s
clear c


%% phase C

% fft analysis
f_s= 1/(time(2)-time(1));

y = fft(capC);

L=length(y);

P2= abs(y/L);
P1=P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);

f= f_s*(0:(L/2))/L;

figure(9);
stem(f,P1)
xlim([0 10^6])
ylim([0 1])
A=[];
index= [];
for i= 1:length(P1)
   if P1(i)> threshold
   A=[A; [f(i),P1(i)]];
   index=[index i];
   end
    
end

%
 c= [];

for i=1:length(A(:,1))
   dummy=string(A(i,1)/1000);
   c= [c,dummy];
   
end

figure(10);
bar(A(:,2));
set(gca,'xticklabel',c.')
set(gca,'FontSize',14);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel('Magnitude of FFT','FontSize',14,'FontWeight','Bold')
title('Capacitor Phase C FFT analysis')

hold off

%%

f_s= 1/(time(2)-time(1));

y = fft(capA);

L=length(y);

P2= 180*angle(y/L)/(pi);
P1=P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);

f= f_s*(0:(L/2))/L;
f_new=[];
p_new=[];
for j=1:length(index)

    f_new=[f_new, f(index(j))];
    p_new=[p_new, P1(index(j))];
end

figure;
hold all;

subplot(2,2,1)
bar(p_new);
set(gca,'xticklabel',c.')
set(gca,'FontSize',14);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel('phase of FFT','FontSize',14,'FontWeight','Bold')
title('Capacitor Phase C FFT analysis')




f_s= 1/(time(2)-time(1));

y = fft(capB);

L=length(y);

P2= 180*angle(y/L)/(pi);
P1=P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);

f= f_s*(0:(L/2))/L;
f_new=[];
p_new=[];
for j=1:length(index)

    f_new=[f_new, f(index(j))];
    p_new=[p_new, P1(index(j))];
end


subplot(2,2,2)
bar(p_new);
set(gca,'xticklabel',c.')
set(gca,'FontSize',14);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel('phase of FFT','FontSize',14,'FontWeight','Bold')
title('Capacitor Phase C FFT analysis')

f_s= 1/(time(2)-time(1));

y = fft(capC);

L=length(y);

P2= 180*angle(y/L)/(pi);
P1=P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);

f= f_s*(0:(L/2))/L;
f_new=[];
p_new=[];
for j=1:length(index)

    f_new=[f_new, f(index(j))];
    p_new=[p_new, P1(index(j))];
end


subplot(2,2,3)
bar(p_new);
set(gca,'xticklabel',c.')
set(gca,'FontSize',14);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel('phase of FFT','FontSize',14,'FontWeight','Bold')
title('Capacitor Phase C FFT analysis')

hold off

