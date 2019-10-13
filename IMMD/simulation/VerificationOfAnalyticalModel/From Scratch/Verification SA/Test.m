%% Definition 

ThC=pi/2; % carrier phase
ThF=0; % fundamental phase , changing for A B C phase 0 -2*pi/3 +2*pi/3

M= 0.9; % modulation index;

V=1/2; % it represents DC Link Voltage;

f_fund= 50; %  fundamental freq

f_c= 40000; % carrier freq

%%
[f, mag ,ang] = HarmonicOfPWM(ThC,ThF,M,V,f_fund,f_c);

%%
% figure()
% stem(f,mag,'b-','Linewidth',1);
% % hold on;
% % stem(f,mod(ang,2*pi), 'r-','Linewidth',1)
% xlabel('Frequency','FontSize',14,'FontWeight','Bold')
% ylabel('Frequency Response','FontSize',14,'FontWeight','Bold')
% title('Frequency Domain Double Sided','FontSize',10,'FontWeight','Bold')
% legend('Magnitude','Angle')
% grid on;
% set(gca,'FontSize',14);
% xlim([-2e5 2e5])

%%
% %% Time definition
% sampleTime= 1e-6;
% sampleFreq=1/sampleTime;
% finalTime=1e-2;
% time= 0: sampleTime: finalTime;
% numberOfStep= length(time);
% %% Switch Signals
% VrefA = M*sin(2*pi*f_fund*time-ThF);
% VrefB = M*sin(2*pi*f_fund*time-ThF-2*pi/3);
% VrefC = M*sin(2*pi*f_fund*time-ThF-4*pi/3);
% Vcarrier = zeros(1, numberOfStep);
% for k = 1:finalTime*f_c
%    Triang_temp = triang(1/(sampleTime*f_c));
%    Vcarrier(((1/(sampleTime*f_c))*(k-1)+1:k/(sampleTime*f_c))) = (Triang_temp*2)-1;
% end
% SA = (VrefA > Vcarrier);
% SB = (VrefB > Vcarrier);
% SC = (VrefC > Vcarrier);
% %%
% figure()
% plot(time,SA,'b-','Linewidth',1);
% hold on;
% xlabel('Time','FontSize',14,'FontWeight','Bold')
% title('Swirching A','FontSize',10,'FontWeight','Bold')
% grid on;
% grid minor;
% set(gca,'FontSize',14);
% ylim([-0.2 1.2])
% xlim([0 25e-4])
%%
% SA_analytic=[];clc
% for k=1:numberOfStep
% SA_analytic =[SA_analytic, sum(mag.* exp(1i*2*pi.*f*time(k)).*exp(1i.*ang))];
% 
% end
% 
%%


%%
% f_s= 1/(time(2)-time(1));
% 
% SA = fft(SA);
% 
% L=length(SA);
% 
% P2= abs(SA/L);
% P1=P2(1:L/2+1);
% P1(2:end-1)=2*P1(2:end-1);
% 
% f= f_s*(0:(L/2))/L;
% 
% figure();
% stem(f,P1)

%% 

ang= mod(ang,2*pi);
ang=180.*(ang./pi);
A= [f',f'./f_fund, mag',ang'];

T = array2table(A,...
    'VariableNames',{'frequency','Harmonic','Magnitude','Angle'});
filename = 'Analytical_model_data.xlsx';
writetable(T,filename,'Sheet',1,'Range','D1')

