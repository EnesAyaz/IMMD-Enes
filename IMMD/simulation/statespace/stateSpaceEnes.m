%% clear all variables
% clc;
% clear;
% close all
% tic;

%% Time definition
sampleTime= 1e-6;
sampleFreq=1/sampleTime;
finalTime=0.1;
time= 0: sampleTime: finalTime;
numberOfStep= length(time);
%% Input and parameters
gridFreq=50;
VoltageDC=300;

RectifierVoltage= VoltageDC* cos(mod(2*pi*gridFreq.*time,pi/3)-pi/6);

% RectifierVoltage= VoltageDC*ones(1,numberOfStep);

%%
figure();
plot(time,RectifierVoltage)
set(gca,'FontSize',14);
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('RectifierVoltage without DC link capacitor','FontSize',14,'FontWeight','Bold')

%% Capacitors, inductors and resistors
Cdc = 15e-6; % F
RA = 10; % Ohms
RB = 10; % Ohms
RC = 10; % Ohms
LA = 15e-3; % H
LB = 15e-3; % H
LC = 15e-3; % H
Rin = 2; % Ohms
Lin = 3.4e-5; % H
Rrec=1e-2; % Ohms
Cdcrec = 10e-3; % F %% former value is 5e-3

%% Switch Signals
ma = 0.9;  % modulation index %% former value is 0.9
fout = 50; % Hz
fsw = 10e3; % Hz
delta = pi/2; % Radians (it is phase of carrrier)
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
% figure;
% hold all;
% lowSA=lowpass(double(SA),fout,sampleFreq);
% lowSB= lowpass(double(SB),fout,sampleFreq);
% lowSC= lowpass(double(SC),fout,sampleFreq);
figure;
hold all;
subplot(2,2,1);
plot(time,SA,'b-','Linewidth',1);
xlim([sampleTime 100*sampleTime])
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
title('Switch Signals A','FontSize',14,'FontWeight','Bold')
ylabel('Boolean','FontSize',14,'FontWeight','Bold')

subplot(2,2,2);
plot(time,SB,'r-','Linewidth',1);
xlim([sampleTime 100*sampleTime])
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
title('Switch Signals B','FontSize',14,'FontWeight','Bold')
ylabel('Boolean','FontSize',14,'FontWeight','Bold')

subplot(2,2,3);
plot(time,SC,'m-','Linewidth',1);
xlim([sampleTime 100*sampleTime])
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
title('Switch Signals C','FontSize',14,'FontWeight','Bold')
ylabel('Boolean','FontSize',14,'FontWeight','Bold')

set(gca,'FontSize',14);
% legend({'Carrier A','Carrier-B','Carrier-C'},'Location','best');

%% state and input matrices (DX=AX+BU) ==> A 4*4 matrices B 4*1 matrices
A11 =ones(1,numberOfStep)* -((RA*LB)+(RA*LC)+(RB*LC)) / ((LA*LC)+(LB*LC)+(LA*LB));
A12 = ones(1,numberOfStep)*((RC*LB)-(RB*LC)) / ((LA*LC)+(LB*LC)+(LA*LB));
A13 = ((SA*LB)+(SA*LC)-(SB*LC)-(SC*LB)) / ((LA*LC)+(LB*LC)+(LA*LB));
A14=0* ones(1,numberOfStep);
A21 = ones(1,numberOfStep)*((RA*LB)-(RB*LA)) / ((LA*LC)+(LB*LC)+(LA*LB));
A22 = ones(1,numberOfStep)*-((RC*LA)+(RC*LB)+(RB*LA)) / ((LA*LC)+(LB*LC)+(LA*LB));
A23 = ((SC*LA)+(SC*LB)-(SA*LB)-(SB*LA)) / ((LA*LC)+(LB*LC)+(LA*LB));
A24=0* ones(1,numberOfStep);
A31 = (SB-SA) / (Cdc);
A32 = (SB-SC) / (Cdc);
A33=0* ones(1,numberOfStep);
A34 = ones(1,numberOfStep)*1 / (Cdc);
A41=0* ones(1,numberOfStep);
A42=0* ones(1,numberOfStep);
A43 = ones(1,numberOfStep)*-1 / (Lin);
A44 = ones(1,numberOfStep)*-(Rin) / (Lin);
B1=ones(1,numberOfStep)*0;
B2=ones(1,numberOfStep)*0;
B3=ones(1,numberOfStep)*0;
B4 = ones(1,numberOfStep)*1 / (Lin);

A=zeros(4,4,numberOfStep);
B=zeros(4,1,numberOfStep);
for k=1:numberOfStep
A(:,:,k)= [A11(k), A12(k), A13(k), A14(k);...
    A21(k), A22(k) ,A23(k), A24(k);...
    A31(k), A32(k), A33(k), A34(k);...
    A41(k), A42(k), A43(k), A44(k)];

B(:,:,k)=[B1(k); B2(k) ; B3(k) ; B4(k)];
    
end

%% states
states = zeros(4,1, numberOfStep); %% state 1 is phase current A ...
% state 2 is phase current C
% state 3 is DC voltage of capacitor (rectifier)
% state 4 is input current 
InputVoltage= zeros(1,k);

%% initialize previous and difference parameter of state current A,C, input and voltage DC
previusState=zeros(4,1);
differenceState=zeros(4,1);

%% Main Loop for State Calculations
for k = 2:numberOfStep
    if RectifierVoltage(k)>InputVoltage(k-1)
        InputVoltage(k)= (RectifierVoltage(k)/Rrec-states(4,1,k-1)...
       +InputVoltage(k-1)*Cdcrec/sampleTime)/(Cdcrec/sampleTime+1/Rrec);
   
    else 
          InputVoltage(k) = InputVoltage(k-1)- (states(4,1,k-1)*sampleTime)/Cdcrec;
    end
   
   differenceState= A(:,:,k)*previusState+ B(:,:,k)* InputVoltage(k);
   
   states(:,:,k)= previusState+differenceState*sampleTime;
   
   previusState=states(:,:,k);
   
   
end


%% line-to-line voltages, phase currents, dc current and capacitor current

Vab=  states(3,:).* (SA-SB);
Vbc=states(3,:).* (SB-SC);
Vca =states(3,:).* (SC-SA);
currentPhaseA= states(1,:);
currentPhaseC=states(2,:);
currentPhaseB=-currentPhaseC-currentPhaseA;
currentDC= currentPhaseA.*SA+currentPhaseB.*SB+ currentPhaseC.*SC;
currentCap=states(4,:)-currentDC;
%%
%%
%%
% %% Phase Currents
figure;
hold all;
plot(time,currentPhaseA,'b-','Linewidth',1);
plot(time,currentPhaseB,'r-','Linewidth',1);
plot(time,currentPhaseC,'k-','Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Phase Currents (Amps)','FontSize',14,'FontWeight','Bold')
%xlim([0 40e-3]);
%ylim([-1.2 1.2]);
legend({'Phase-A','Phase-B','Phase-C'},'Location','best');
%% DC Bus Voltages
figure;
hold all;
plot(time,RectifierVoltage,'k-','Linewidth',2)
plot(time,states(3,:),'b-','Linewidth',2);
plot(time,InputVoltage,'r-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Voltages (Volts)','FontSize',14,'FontWeight','Bold')
%xlim([0 40e-3]);
%ylim([-1.2 1.2]);
legend({'Rectifier Voltage','DC Bus','Input'},'Location','best');
%% DC Bus Currents
figure;
hold all;
subplot(2,2,1);
plot(time,currentDC,'k','Linewidth',3);
title('DC current( input-capacitor current) ','FontSize',14,'FontWeight','Bold');
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Currents (Amps)','FontSize',14,'FontWeight','Bold');

subplot(2,2,2);
plot(time,currentCap,'r-','Linewidth',2);
title('Capacitor Current ','FontSize',14,'FontWeight','Bold');
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Currents (Amps)','FontSize',14,'FontWeight','Bold')

subplot(2,2,3);
plot(time,states(4,:),'b-','Linewidth',2);
title('input Current','FontSize',14,'FontWeight','Bold')
xlabel('Time (Seconds)','FontSize',14,'FontWeight','Bold')
ylabel('Currents (Amps)','FontSize',14,'FontWeight','Bold')

set(gca,'FontSize',14);


ylim([-10 10]);
% legend({'DC current','capacitor Current'},'Location','best');
% % Verification figures


%%

