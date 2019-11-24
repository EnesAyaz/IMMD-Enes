w= [0:50:1e7];
[capA_phA, capA_phB,capA_phC,...
          capB_phA, capB_phB,capB_phC,...
          capC_phA, capC_phB,capC_phC] = capacitor_response(w);
      
      
%%      
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
      
