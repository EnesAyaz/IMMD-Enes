%% 
clear;
clc;
close all;

%%
scale=20; % determines switching frequency( as multiplied by 10kHz)
%% Time definition
sampleTime= (1e-6)/scale;
sampleFreq=1/sampleTime;
finalTime=0.1-sampleTime; % number of steps should be even
time= 0: sampleTime: finalTime;
numberOfStep= length(time);

%% Switch Signals
ma = 0.9;  % modulation index %% former value is 0.9
fout = 50; % Hz1
fsw = 10e3*scale; % Hz
delta = 0; % Radians (it is phase of carrrier)
VrefA = ma*sin(2*pi*fout*time-delta);
VrefB = ma*sin(2*pi*fout*time-delta-2*pi/3);
VrefC = ma*sin(2*pi*fout*time-delta-4*pi/3);
Vcarrier = zeros(1, numberOfStep);
for k = 1:finalTime*fsw
   Triang_temp = triang(1/(sampleTime*fsw));
   Vcarrier((100*(k-1)+1:k/(sampleTime*fsw))) = (Triang_temp*2)-1;
end
SA = (VrefA > Vcarrier);
SB = (VrefB > Vcarrier);
SC = (VrefC > Vcarrier);


%%
SA=double(SA);
SB=double(SB);
SC=double(SC);

%%
%%
yA = fft(SA);
L=length(yA);
yA=[yA(L/2+2:end), yA(1:L/2+1)];
P1AM=abs(yA/L);
P1AA=angle(yA/L);
f= sampleFreq*((-L/2)+1:(L/2))/L;

%%
yB = fft(SB);
yB=[yB(L/2+2:end), yB(1:L/2+1)];
P1BM=abs(yB/L);
P1BA=angle(yB/L);

%%
yC = fft(SC);
yC=[yC(L/2+2:end), yC(1:L/2+1)];
P1CM=abs(yC/L);
P1CA=angle(yC/L);

%%
newF=[];
PAM=[];
PBM=[];
PCM=[];
PAA=[];
PBA=[];
PCA=[];

%%
for i=1:length(P1AM)
   if abs(P1AM(i))>0.001
       newF=[newF f(i)];
       PAM= [PAM P1AM(i)];
       PBM= [PBM P1BM(i)];
       PCM= [PCM P1CM(i)];
       PAA= [PAA P1AA(i)];
       PBA= [PBA P1BA(i)];
       PCA= [PCA P1CA(i)];
   end
end

newFF=newF(1):fout:newF(end);

newPAM=zeros(1,length(newFF));
newPBM=zeros(1,length(newFF));
newPCM=zeros(1,length(newFF));
newPAA=zeros(1,length(newFF));
newPBA=zeros(1,length(newFF));
newPCA=zeros(1,length(newFF));


for i=1:length(newFF)
    
   for j=1:length(newF)
       if round(newFF(i))==round(newF(j))
            newPAM(i)= PAM(j);
            newPBM(i)= PBM(j);
            newPCM(i)= PCM(j);
            newPAA(i)= PAA(j);
            newPBA(i)= PBA(j);
            newPCA(i)= PCA(j);
            disp(i);
            
       else 
           continue;
       end
   end
    
end

%%
figure;
stem(newFF,newPAM);
hold on;
stem(newFF,newPBM);
hold on;
stem(newFF,newPCM);
grid on;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('Magnitude of harmonic components','FontSize',14,'FontWeight','Bold')
title('Switches FFT analysis');

%%
figure;
stem(newFF,newPAA);
hold on;
stem(newFF,newPBA);
hold on;
stem(newFF,newPCA);
grid on;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('Angle of harmonic components','FontSize',14,'FontWeight','Bold')
title('Switches FFT analysis');


%%
Vdc=400; % Volt  
RA = 10; % Ohms
RB = 10; % Ohms
RC = 10; % Ohms
LA = 15e-3; % H
LB = 15e-3; % H
LC = 15e-3; % H
currentA=complex(zeros(1,length(newFF)));
currentB=complex(zeros(1,length(newFF)));
currentC=complex(zeros(1,length(newFF)));
K2=complex(Vdc./(3*(sqrt(newFF.^2.*LA^2+RA^2))));
for i = 1:length(newFF)
   currentA(i)=complex(K2(i)*...
       (newPAM(i)*exp(1i*newPAA(i))*2- newPBM(i)*exp(1i*newPBA(i))- newPCM(i)*exp(1i*newPCA(i))));
   currentB(i)=complex(K2(i)*...
       (-newPAM(i)*exp(1i*newPAA(i))+ 2*newPBM(i)*exp(1i*newPBA(i))- newPCM(i)*exp(1i*newPCA(i))));
   currentC(i)=complex(K2(i)*...
       (-newPAM(i)*exp(1i*newPAA(i))- newPBM(i)*exp(1i*newPBA(i))+ 2*newPCM(i)*exp(1i*newPCA(i))));
   
   
end

%%

SAIA= conv(newPAM.*exp(1i*newPAA),currentA);
SBIB=conv(newPBM.*exp(1i*newPBA),currentB);
SCIC=conv(newPCM.*exp(1i*newPCA),currentC);

figure;
wc=(newFF(1)+newFF(1)):50:(newFF(end)+newFF(end));

stem(currentA);
hold on;
stem(SAIA);
grid on;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('FFT Analysis','FontSize',14,'FontWeight','Bold')
title('Current and Switch Modulation');


%%
%% w axis
w=wc;
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

%% for capacitor A response over all

responseCapA= SAIA.*capA_phA+ SBIB.*capA_phB+ SCIC.*capA_phC;
responseCapB= SAIA.*capB_phA+ SBIB.*capB_phB+ SCIC.*capB_phC;
responseCapC= SAIA.*capC_phA+ SBIB.*capC_phB+ SCIC.*capC_phC;

%%
figure;
rcA=responseCapA;
rcB=responseCapB;
rcC=responseCapC;

rcA(rcA==0)=NaN;
rcB(rcB==0)=NaN;
rcC(rcC==0)=NaN;
subplot(2,2,1);
stem(wc,rcA);
% xlim([-5e4 5e4]);
grid on;
grid minor;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('Mag of harmonic components','FontSize',14,'FontWeight','Bold')
title('Capacitor A Response');

subplot(2,2,2);
stem(wc,rcB);
% xlim([-5e4 5e4]);
grid on;
grid minor;

set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('Mag of harmonic components','FontSize',14,'FontWeight','Bold')
title('Capacitor B Response');
grid minor;


subplot(2,2,3);
stem(wc,rcC);
% xlim([-5e4 5e4]);
grid on;

set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('Mag of harmonic components','FontSize',14,'FontWeight','Bold')
title('Capacitor C Response');

