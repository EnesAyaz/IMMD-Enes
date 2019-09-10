%% 
close all;
clc;
clear;

%% w axis
w = 2*pi*logspace(0,7,1000)';
time= 0:1e-4:1;
%% Parameter values
LATop  = 03.40e-9;
LABot  = 20.25e-9;
LAMid  = 01.30e-9;
LBTop  = 03.38e-9;
LBBot  = 20.38e-9;
LBMid  = 01.30e-9;
LCTop  = 03.41e-9;
LCBot  = 20.94e-9;
LCMid  = 01.30e-9;
LABTop = 18.30e-9;
LABBot = 10.20e-9;
LBCTop = 21.84e-9;
LBCBot = 11.14e-9;

ESLA = 19e-15;
ESLB = 19e-15;
ESLC = 19e-15;

C1A = 5e-6;
C1B = 5e-6;
C1C = 5e-6;

%% New merged inducances - phA
L1_phA = LATop + LABot + ESLA;
L2_phA = LABTop;
L3_phA = LABBot;
L4_phA = ESLB;
L5_phA = LBTop + LBBot + LBCTop + LBCBot + ESLC;

% Calculated impedances - phA
Z1_phA = 1i*w*L5_phA + 1./(1i*w*C1C);
Z2_phA = 1i*w*L4_phA + 1./(1i*w*C1B);
Z3_phA = Z1_phA.*Z2_phA./(Z1_phA+Z2_phA);
Z4_phA = Z3_phA + 1i*w*(L2_phA+L3_phA);
Z5_phA = 1i*w*L1_phA + 1./(1i*w*C1A);
Zeqv_phA = Z4_phA.*Z5_phA./(Z4_phA+Z5_phA);

% Capacitor A 
capA_phA= Z4_phA./(Z4_phA+Z5_phA);

% capacitor B
capB_phA=(Z5_phA./(Z4_phA+Z5_phA)).*(Z2_phA./(Z1_phA+Z2_phA));

% capacitor C 
capC_phA= (Z5_phA./(Z4_phA+Z5_phA)).* (Z1_phA./(Z1_phA+Z2_phA));

% time domain
% 
%     currentcapA_phA = [];
%     currentcapB_phA = [];
%     currentcapC_phA = [];
%     
% for i=1:length(time)
%     
%     currentcapA_phA= [currentcapA_phA, sum(capA_phA.*sin(w*time(i)))];
%     currentcapB_phA= [currentcapB_phA,sum(capB_phA.*sin(w*time(i)))];
%     currentcapC_phA= [currentcapC_phA,sum(capC_phA.*sin(w*time(i)))]; 
%     
% end



%% New merged inducances - phB
L1_phB = LATop + LABot + LABTop + LABBot + ESLA;
L2_phB = ESLB;
L3_phB = LBTop + LBBot;
L4_phB = LBCTop + LBCBot + ESLC;

% Calculated impedances - phB
Z1_phB = 1i*w*L1_phB + 1./(1i*w*C1A);
Z2_phB = 1i*w*L2_phB + 1./(1i*w*C1B);
Z3_phB = Z1_phB.*Z2_phB./(Z1_phB+Z2_phB);
Z4_phB = Z3_phB + 1i*w*(L3_phB);
Z5_phB = 1i*w*L4_phB + 1./(1i*w*C1C);
Zeqv_phB = Z4_phB.*Z5_phB./(Z4_phB+Z5_phB);


% Capacitor C
capC_phB= Z4_phB./(Z4_phB+Z5_phB);

% capacitor A
capA_phB=(Z5_phB./(Z4_phB+Z5_phB)).*(Z2_phB./(Z1_phB+Z2_phB));

% capacitor B
capB_phB= (Z5_phB./(Z4_phB+Z5_phB)).* (Z1_phB./(Z1_phB+Z2_phB));

% % time domain
% 
%     currentcapA_phB = [];
%     currentcapB_phB = [];
%     currentcapC_phB = [];
%     
% for i=1:length(time)
%     
%     currentcapA_phB= [currentcapA_phB, sum(capA_phB.*sin(w*time(i)))];
%     currentcapB_phB= [currentcapB_phB,sum(capB_phB.*sin(w*time(i)))];
%     currentcapC_phB= [currentcapC_phB,sum(capC_phB.*sin(w*time(i)))]; 
%     
% end
% 
% 

%% New merged inducances - phC
L1_phC = LATop + LABot + LABTop + LABBot + ESLA;
L2_phC = ESLB;
L3_phC = LBTop + LBBot + LBCTop + LBCBot;
L4_phC = ESLC;
L5_phC = LCTop + LCBot;

% Calculated impedances - phC
Z1_phC = 1i*w*L1_phC + 1./(1i*w*C1A);
Z2_phC = 1i*w*L2_phC + 1./(1i*w*C1B);
Z3_phC = Z1_phC.*Z2_phC./(Z1_phC+Z2_phC);
Z4_phC = Z3_phC + 1i*w*(L3_phC);
Z5_phC = 1i*w*L4_phC + 1./(1i*w*C1C);
Z6_phC = Z4_phC.*Z5_phC./(Z4_phC+Z5_phC);
Zeqv_phC = Z6_phC + 1i*w*L5_phC;


% Capacitor C
capC_phC= Z4_phC./(Z4_phC+Z5_phC);

% capacitor A
capA_phC=(Z5_phC./(Z4_phC+Z5_phC)).*(Z2_phC./(Z1_phC+Z2_phC));

% capacitor B
capB_phC= (Z5_phC./(Z4_phC+Z5_phC)).* (Z1_phC./(Z1_phC+Z2_phC));

% % time domain
% 
%     currentcapA_phC = [];
%     currentcapB_phC = [];
%     currentcapC_phC = [];
%     
% for i=1:length(time)
%     
%     currentcapA_phC= [currentcapA_phC, sum(capA_phC.*sin(w*time(i)))];
%     currentcapB_phC= [currentcapB_phC,sum(capB_phC.*sin(w*time(i)))];
%     currentcapC_phC= [currentcapC_phC,sum(capC_phC.*sin(w*time(i)))]; 
%     
% end
% 
% 


%%
figure;
hold all;
plot(w/(2*pi*1000),abs(Zeqv_phA),'b-','Linewidth',1);
plot(w/(2*pi*1000),abs(Zeqv_phB),'k--','Linewidth',1);
plot(w/(2*pi*1000),abs(Zeqv_phC),'r-','Linewidth',1);
set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',14);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel('Magnitude of equivalent impedance','FontSize',14,'FontWeight','Bold')
xlim([1 10000]);
%ylim([-1.2 1.2]);
legend({'phA','phB','phC'},'Location','best');

%% phase A, capacitor effect at single figure 
% figure;
% hold all;
% plot(w/(2*pi*1000),abs(capA_phA),'b-','Linewidth',1);
% plot(w/(2*pi*1000),abs(capB_phA),'r-','Linewidth',1);
% plot(w/(2*pi*1000),abs(capC_phA),'k-','Linewidth',1);
% set(gca, 'YScale', 'log', 'XScale', 'log')
% grid on;
% set(gca,'FontSize',14);
% xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
% ylabel('Frequency Response (Mag) (Input Current at phase A and output is current of capacitors)' ...
%     ,'FontSize',14,'FontWeight','Bold')
% xlim([1 10000]);
% %ylim([-1.2 1.2]);
% legend({'Capacitor A at switching phase A','Capacitor B at switching phase A','Capacitor C at switching phase A'},'Location','best');

%% phase A, capacitor effect at single figure subplot

figure;
hold all;
subplot(2,2,1);
plot(w/(2*pi*1000),abs(capA_phA),'b-','Linewidth',1);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of'  'phase A switching (Capaacitor A)'} ...
    ,'FontSize',14,'FontWeight','Bold');

set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',10);
xlim([1 10000]);


subplot(2,2,2);
plot(w/(2*pi*1000),abs(capB_phA),'r-','Linewidth',1);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of' 'phase A switching (Capaacitor B)'} ...
    ,'FontSize',14,'FontWeight','Bold');

set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',10);
xlim([1 10000]);


subplot(2,2,3);
plot(w/(2*pi*1000),abs(capC_phA),'k-','Linewidth',1);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of'  'phase A switching (Capaacitor C)'} ...
    ,'FontSize',14,'FontWeight','Bold');


set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',10);
xlim([1 10000]);


% %%  time domain capacitor current for impulse 
% figure;
% hold all;
% subplot(2,2,1);
% plot(time,currentcapA_phA,'b-','Linewidth',1);
% xlabel('time(s)','FontSize',14,'FontWeight','Bold')
% ylabel({'Response (Mag) of'  'phase A switching (Capaacitor A)'} ...
%     ,'FontSize',14,'FontWeight','Bold');
% 
% grid on;
% set(gca,'FontSize',10);
% 
% subplot(2,2,2);
% plot(time,currentcapB_phA,'r-','Linewidth',1);
% xlabel('time(s)','FontSize',14,'FontWeight','Bold')
% ylabel({' Response (Mag) of' 'phase A switching (Capaacitor B)'} ...
%     ,'FontSize',14,'FontWeight','Bold');
% 
% grid on;
% set(gca,'FontSize',10);
% 
% 
% subplot(2,2,3);
% plot(time,currentcapC_phA,'k-','Linewidth',1);
% xlabel('time(s)','FontSize',14,'FontWeight','Bold')
% ylabel({' Response (Mag) of'  'phase A switching (Capaacitor C)'} ...
%     ,'FontSize',14,'FontWeight','Bold');
% 
% grid on;
% set(gca,'FontSize',10);

%%
%% phase B, capacitor effect at single figure subplot

figure;
hold all;
subplot(2,2,1);
plot(w/(2*pi*1000),abs(capA_phB),'b-','Linewidth',1);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of'  'phase B switching (Capaacitor A)'} ...
    ,'FontSize',14,'FontWeight','Bold');

set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',10);
xlim([1 10000]);


subplot(2,2,2);
plot(w/(2*pi*1000),abs(capB_phB),'r-','Linewidth',1);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of' 'phase B switching (Capaacitor B)'} ...
    ,'FontSize',14,'FontWeight','Bold');

set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',10);
xlim([1 10000]);


subplot(2,2,3);
plot(w/(2*pi*1000),abs(capC_phB),'k-','Linewidth',1);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of'  'phase B switching (Capaacitor C)'} ...
    ,'FontSize',14,'FontWeight','Bold');


set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',10);
xlim([1 10000]);


%% phase C, capacitor effect at single figure subplot

figure;
hold all;
subplot(2,2,1);
plot(w/(2*pi*1000),abs(capA_phC),'b-','Linewidth',1);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of'  'phase C switching (Capaacitor A)'} ...
    ,'FontSize',14,'FontWeight','Bold');

set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',10);
xlim([1 10000]);


subplot(2,2,2);
plot(w/(2*pi*1000),abs(capB_phC),'r-','Linewidth',1);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of' 'phase C switching (Capaacitor B)'} ...
    ,'FontSize',14,'FontWeight','Bold');

set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',10);
xlim([1 10000]);


subplot(2,2,3);
plot(w/(2*pi*1000),abs(capC_phC),'k-','Linewidth',1);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of'  'phase C switching (Capaacitor C)'} ...
    ,'FontSize',14,'FontWeight','Bold');


set(gca, 'YScale', 'log', 'XScale', 'log')
grid on;
set(gca,'FontSize',10);
xlim([1 10000]);


%%
% time= 0:1e-4:1;
% stepFunction=ones(1,length(time));
% stepFunction(1:100)=0;
% 
% plot(time,stepFunction);
% 
% %% curvefitting to workspace
% 
% f1=fittedmodel.a1*sin(fittedmodel.b1*time+ fittedmodel.c1);
% f2=fittedmodel.a2*sin(fittedmodel.b2*time+ fittedmodel.c2);
% f3=fittedmodel.a3*sin(fittedmodel.b3*time+ fittedmodel.c3);
% f4=fittedmodel.a4*sin(fittedmodel.b4*time+ fittedmodel.c4);
% f5=fittedmodel.a5*sin(fittedmodel.b5*time+ fittedmodel.c5);
% f6=fittedmodel.a6*sin(fittedmodel.b6*time+ fittedmodel.c6);
% f7=fittedmodel.a7*sin(fittedmodel.b7*time+ fittedmodel.c7);
% 
% 
% f=f1+f2+f3+f4+f5+f6+f7;
% 
% figure();
% plot(time,f);
% ylim([0 2]);

%%

