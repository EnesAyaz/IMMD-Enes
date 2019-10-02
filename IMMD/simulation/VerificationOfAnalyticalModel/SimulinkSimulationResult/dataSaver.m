close all;
load('CapacitorCurr.mat');
threshold=0.01;
%%
figure(1);
hold all;
subplot(2,2,1);
plot(time,capA,'b-','Linewidth',1);
xlabel('time(sec)','FontSize',14,'FontWeight','Bold')
ylabel('Current(A)','FontSize',14,'FontWeight','Bold')
title('phase A capacitor ripple current','FontSize',10,'FontWeight','Bold')
subplot(2,2,2);
plot(time,capB,'k-','Linewidth',1);
xlabel('time(sec)','FontSize',14,'FontWeight','Bold')
ylabel('Current(A)','FontSize',14,'FontWeight','Bold')
title('phase B capacitor ripple current','FontSize',10,'FontWeight','Bold')
subplot(2,2,3);
plot(time,capC,'r-','Linewidth',1);
% set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',14);
xlabel('time(sec)','FontSize',14,'FontWeight','Bold')
ylabel('Current(A)','FontSize',14,'FontWeight','Bold')
title('phase C capacitor ripple current','FontSize',10,'FontWeight','Bold')
% xlim([1 10000]);
%ylim([-1.2 1.2]);
% legend({'phA Cap','phB Cap','phC Cap'},'Location','best');

%% fft analysis
f_s= 1/(time(2)-time(1));

y = fft(capA+dummy2);

L=length(y);

P2= abs(y/L);
P1=P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);


P1(P1<=threshold) = NaN;

f= f_s*(0:(L/2))/L;

figure(2);
stem(f,P1)
xlim([0 10^6])
ylim([0 1])
title('Capacitor A FFT ANALYSIS');
ylabel('Magnitude of FFT(Real Value)')
xlabel('Frequency(Hz)')
grid on;
grid minor;


%%
%%  phase B
% fft analysis
f_s= 1/(time(2)-time(1));

y = fft(capB);

L=length(y);

P2= abs(y/L);
P1=P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);

f= f_s*(0:(L/2))/L;

P1(P1<=threshold) = NaN;


figure(3);
stem(f,P1)
xlim([0 10^6])
ylim([0 1])
title('Capacitor B FFT ANALYSIS');
ylabel('Magnitude of FFT(Real Value)')
xlabel('Frequency(Hz)');
grid on;
grid minor;



%% phase C

% fft analysis
f_s= 1/(time(2)-time(1));

y = fft(capC);

L=length(y);

P2= abs(y/L);
P1=P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);


P1(P1<=threshold) = NaN;

% P1(P1==0) = NaN;

f= f_s*(0:(L/2))/L;

figure(4);
stem(f,P1)
xlim([0 10^6])
ylim([0 1])
title('Capacitor C FFT ANALYSIS');
ylabel('Magnitude of FFT(Real Value)')
xlabel('Frequency(Hz)')
grid on;
grid minor;

%%
for i=1:4
   saveas(figure(i),string(i)+'.png' )
    
    
end


