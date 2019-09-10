%%
clear y;
clear tout;
tout=ScopeData1{1}.Values.Time;
y=ScopeData1{1}.Values.Data;
%%
tout=tout(1000:2000);
y=y(1000:2000);
figure;
plot(tout,y);
%%


f_s= 1/(tout(2)-tout(1));

y = fft(y);

L=length(y);

P2= abs(y/L);
P1=P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);

f= f_s*(0:(L/2))/L;

figure;
stem(f,P1)
grid on;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('FFT Analysis','FontSize',14,'FontWeight','Bold')
xlim([2e5 7e5]);

%%
for i=1:length(P1)
   if P1>0.2
       
   end
    
    
    
    
end

