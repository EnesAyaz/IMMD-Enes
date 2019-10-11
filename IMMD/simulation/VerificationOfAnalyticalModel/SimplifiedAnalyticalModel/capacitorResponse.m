%% 
clear;
clc;
close all;  
%% loading switching phase,magnitude and frequency information of SA,SB,SC
load('SwitchingFunctionPhaseACos.mat');
load('SwitchingFunctionPhaseBCos.mat');
load('SwitchingFunctionPhaseCCos.mat');

%% create a f-axis and convert to switching functions as complex array
w= 2*pi*fA;
complexSA= magA.* exp(1i.*w+1i.*mod(angA,2*pi));
complexSB= magB.* exp(1i.*w+1i.*mod(angB,2*pi));
complexSC= magC.* exp(1i.*w+1i.*mod(angC,2*pi));

%% Phase current can be calculated by using switching function, impedance and 
%%
Vdc=400; % Volt  
RA = 10; % Ohms
RB = 10; % Ohms
RC = 10; % Ohms
LA = 15e-3; % H
LB = 15e-3; % H
LC = 15e-3; % H
Ia= zeros(1,length(w));
Ib= zeros(1,length(w));
Ic= zeros(1,length(w));
 
for i=1:length(fA)
  Z=1i*w(i)*LA+RA;
  Ia(i)= complex(Vdc*(2*complexSA(i)-complexSB(i)-complexSC(i))/(3*Z));
  Ib(i)= complex(Vdc*(-complexSA(i)+2*complexSB(i)-complexSC(i))/(3*Z));
  Ic(i)= complex(Vdc*(-complexSA(i)-complexSB(i)+2*complexSC(i))/(3*Z));
end

%% phase current

%%

%%
w_fund = w(end)-w(end-1);
w_ax= w(1):w_fund:w(end);
complexSA1=complex(zeros(1,length(w_ax)));
complexSB1=complex(zeros(1,length(w_ax)));
complexSC1=complex(zeros(1,length(w_ax)));
complexIa=complex(zeros(1,length(w_ax)));
complexIb=complex(zeros(1,length(w_ax)));
complexIc=complex(zeros(1,length(w_ax)));


%%
k=0;
for i=1: length(w_ax)
   
    for j=1:length(w)
    
        if (w_ax(i)-w(j))<1 && (w_ax(i)-w(j))>-1
          
            complexSA1(i)=complexSA(j);
            complexSB1(i)=complexSB(j);
            complexSC1(i)=complexSC(j);
            complexIa(i)=Ia(j);
            complexIb(i)=Ib(j);
            complexIc(i)=Ic(j);
            k=k+1;
                 
        end
    end
    
end
w=w_ax;

%%
%%
SAIA= conv(complexIa,complexSA1)/(2*pi);
SBIB=conv(complexIb,complexSB1)/(2*pi);
SCIC=conv(complexIc,complexSC1)/(2*pi);

%% w axis can be determined
w= 0:w_fund:2*w(end);

%%

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


%% Capacitor A total Response
capA= SAIA.*capA_phA+SBIB.*capA_phB+ SCIC.*capA_phC;

%% Capacitor B total Response
capB= SAIA.*capB_phA+SBIB.*capB_phB+ SCIC.*capB_phC;

%% Capacitor C total Response
capC= SAIA.*capC_phA+SBIB.*capC_phB+ SCIC.*capC_phC;

%% capacitor response
figure;
hold all;
subplot(2,2,1);
plot(w/(2*pi*1000),abs(capA),'b-','Linewidth',1);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of'  'Capacitor C'} ...
    ,'FontSize',14,'FontWeight','Bold');
grid on;
set(gca,'FontSize',10);

hold all;
subplot(2,2,2);
plot(w/(2*pi*1000),abs(capB),'b-','Linewidth',1);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of'  'Capacitor C'} ...
    ,'FontSize',14,'FontWeight','Bold');
grid on;
set(gca,'FontSize',10);



hold all;
subplot(2,2,3);
plot(w/(2*pi*1000),abs(capC),'b-','Linewidth',1);
xlabel('Frequency (kHz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of'  'Capacitor C'} ...
    ,'FontSize',14,'FontWeight','Bold');
grid on;
set(gca,'FontSize',10);










