f_o= 50; %hz
f_s=1e4; %hz
The_o= [0 -2*pi/3 2*pi/3];
The_c=[0 pi/2 pi 3*pi/2];
k=0.9;



%% Phase A;
[frequencyA,SA]= SwitchingFunction(f_o,f_s,The_o(1),The_c(1),k);


%% phase B
[frequencyB,SB]= SwitchingFunction(f_o,f_s,The_o(2),The_c(1),k);

%% phase C

[frequencyC,SC]= SwitchingFunction(f_o,f_s,The_o(3),The_c(1),k);


%%  Convolution;
phaseAcurrent= [50 ,-pi/6, 8];  % fout phase magnitude
phaseBcurrent= [50 ,(-2*pi/3)-pi/6, 8];
phaseCcurrent= [50 ,(2*pi/3)-pi/6, 8];

%% phase A
frequency_A_new= [];
SAIA=[];
for i=1:length(frequencyA)
    
   frequency_A_new =[ frequency_A_new, abs(frequencyA(i)- phaseAcurrent(1)), abs(frequencyA(i)+ phaseAcurrent(1))];
   
   SAIA= [SAIA, SA(i)*exp(1i*phaseAcurrent(2))*phaseAcurrent(3)/2,SA(i)*exp(1i*phaseAcurrent(2))*phaseAcurrent(3)/2];
        
end

%% phase B
frequency_B_new= [];
SBIB=[];
for i=1:length(frequencyB)
    
   frequency_B_new =[ frequency_B_new, abs(frequencyB(i)- phaseBcurrent(1)), abs(frequencyB(i)+ phaseBcurrent(1))];
   
   SBIB= [SBIB, SB(i)*exp(1i*phaseBcurrent(2))*phaseBcurrent(3)/2,SB(i)*exp(1i*phaseBcurrent(2))*phaseBcurrent(3)/2];
        
end

%%

%% phase C
frequency_C_new= [];
SCIC=[];
for i=1:length(frequencyC)
    
   frequency_C_new =[ frequency_C_new, abs(frequencyC(i)- phaseCcurrent(1)), abs(frequencyC(i)+ phaseCcurrent(1))];
   
   SCIC= [SCIC, SC(i)*exp(1i*phaseCcurrent(2))*phaseCcurrent(3)/2,SC(i)*exp(1i*phaseCcurrent(2))*phaseCcurrent(3)/2];
        
end


%% capacitor responses
w= 2*pi*frequency_C_new;

[capA_phA, capA_phB,capA_phC,...
          capB_phA, capB_phB,capB_phC,...
          capC_phA, capC_phB,capC_phC]= capacitor_response(w);
      
      
      
%% capacitor response A 

capA= capA_phA.*SAIA+ capA_phB.*SBIB+ capA_phC.*SCIC;

capC= capC_phA.*SAIA+ capC_phB.*SBIB+ capC_phC.*SCIC;
capB= capB_phA.*SAIA+ capB_phB.*SBIB+ capB_phC.*SCIC;


%%

figure;
hold all;
subplot(2,2,1);
stem(w/(2*pi),abs(capA),'b-','Linewidth',1);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of'  ' Capaacitor A'} ...
    ,'FontSize',14,'FontWeight','Bold');
grid on;
set(gca,'FontSize',10);



subplot(2,2,2);
stem(w/(2*pi),abs(capB),'r-','Linewidth',1);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of' 'Capaacitor B'} ...
    ,'FontSize',14,'FontWeight','Bold');

grid on;
set(gca,'FontSize',10);


subplot(2,2,3);
stem(w/(2*pi),abs(capC),'k-','Linewidth',1);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel({'Frequency Response (Mag) of'  'Capacitor C'} ...
    ,'FontSize',14,'FontWeight','Bold');


grid on;
set(gca,'FontSize',10);

      

