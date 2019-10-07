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

%% Switching Function Drawing
figure();
stem(w,complexSA)
grid on;
grid minor;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('Mag of harmonic components','FontSize',14,'FontWeight','Bold')
title('Switching Functions of Cosinüs');

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
figure(2);
stem(w/2*pi,Ia)
grid on;
grid minor;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('Mag of harmonic components','FontSize',14,'FontWeight','Bold')
title('Phase Current');

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

%% Figure of cosinüs
% 
figure();
stem(w,complexIc)
grid on;
grid minor;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('Mag of harmonic components','FontSize',14,'FontWeight','Bold')
title('Switching Functions');



%%
%%
SAIA= conv(complexIa,complexSA1)/(2*pi);
SBIB=conv(complexIb,complexSB1)/(2*pi);
SCIC=conv(complexIc,complexSC1)/(2*pi);

%% w axis can be determined
w= 0:w_fund:2*w(end);



%% 
figure(3);
stem(w,SAIA)
hold on; 
% stem(w,SBIB);
% 
% stem(w,SCIC)
grid on;
grid minor;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('Mag of harmonic components','FontSize',14,'FontWeight','Bold')
title(' SAIA');


%%
figure();
Irip=abs(SAIA+SBIB+SCIC);
Irip(Irip==0)=NaN;
stem(w/(2*pi),Irip)
grid on;
grid minor;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('Mag of harmonic components','FontSize',14,'FontWeight','Bold')
title(' Input Current');



