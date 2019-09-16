%% Time definition
sampleTime= 1e-6;
sampleFreq=1/sampleTime;
finalTime=0.1;
time= 0: sampleTime: finalTime;
numberOfStep= length(time);

%% Switch Signals
ma = 0.9;  % modulation index %% former value is 0.9
fout = 50; % Hz
fsw = 10e3; % Hz
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
yA= double(SA);
f_s= 1/(time(2)-time(1));
yA = fft(yA);
L=length(yA);

P2= abs(yA/L);
P2=yA/L;
P1A=P2(1:L/2+1);
P1A(2:end-1)=2*P1A(2:end-1);
f= f_s*(0:(L/2))/L;

%%
yB=double(SB);
yB = fft(yB);
L=length(yB);
P2= abs(yB/L);
P2=yB/L;
P1B=P2(1:L/2+1);
P1B(2:end-1)=2*P1B(2:end-1);

%%
yC=double(SC);
yC = fft(yC);
L=length(yC);
P2= abs(yC/L);
P2=yC/L;
P1C=P2(1:L/2+1);
P1C(2:end-1)=2*P1C(2:end-1);

%%
newF=[];
newPA=[];
newPB=[];
newPC=[];

for i=1:length(P1A)
   if abs(P1A(i))>0.001
       newF=[newF f(i)];
       newPA= [newPA P1A(i)];
       newPB= [newPB P1B(i)];
       newPC= [newPC P1C(i)];
       

   end

    
end

newFF=0:50:newF(end);
newPAF=zeros(1,round(newFF(end)/50)+1);
newPBF=zeros(1,round(newFF(end)/50)+1);
newPCF=zeros(1,round(newFF(end)/50)+1);

for i=1:newFF(end)/50+1
    
   for j=1:length(newF)
       if round(newFF(1,i))==round(newF(1,j))
            newPAF(1,i)= newPA(1,j);
            newPBF(1,i)= newPB(1,j);
            newPCF(1,i)= newPC(1,j);
            disp(i);
       else 
           continue;
       end
   end
    
end


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
   currentA(i)=complex(K2(i)*(newPAF(i)*2- newPBF(i)- newPCF(i)));
   currentB(i)=complex(K2(i)*(-newPAF(i)+ 2*newPBF(i)- newPCF(i)));
   currentC(i)=complex(K2(i)*(-newPAF(i)- newPBF(i)+ 2*newPCF(i)));
   
   
end

%%

SAIA= conv(newPAF,currentA);
SBIB=conv(newPBF,currentB);
SCIC=conv(newPCF,currentC);

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
capacitor_ripple= capA_phA.*SAIA;

figure();
plot(wc,capacitor_ripple);
sqrt(sum(abs(capacitor_ripple).*abs(capacitor_ripple)));

