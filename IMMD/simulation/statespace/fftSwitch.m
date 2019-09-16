
%%
y= double(SA);

f_s= 1/(time(2)-time(1));

y = fft(y);

L=length(y);

P2= abs(y/L);
P2=y/L;
P1=P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);

f= f_s*(0:(L/2))/L;

figure;
stem(f,P1)
grid on;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('FFT Analysis','FontSize',14,'FontWeight','Bold')
title('FFT of Switcth A');
xlim([0 1e6]);

sqrt(sum(P1.*P1))
%%
newF=[];
newP=[];
for i=1:length(P1)
   if P1(i)>0.013
       newF=[newF f(i)];
       newP= [newP P1(i)];

   end

    
end

newF1=0:50:newF(end);
newP1=zeros(1,round(newF(end)/50));

for i=1:newF(end)/50
    
   for j=1:length(newF)
       if newF1(i)==round(newF(j))
        newP1(i)= newP(j);
       end
   end
    
end

figure;
stem(newF1,newP1)
grid on;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('FFT Analysis','FontSize',14,'FontWeight','Bold')
title('FFT of Switcth A forfrequencies by fundamental frequency gap ');
sqrt(sum(newP.*newP))


%%
Vdc=400;
Rload=10;
Lload=1.1e-3;
currentA= Vdc*newP1./sqrt((newF1.*Lload).^2+Rload^2);
figure;
stem(newF1,currentA);
hold on;
stem(newF1,newP1);
grid on;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('FFT Analysis','FontSize',14,'FontWeight','Bold')
title('Current and Switch');
legend('Phase Current','Switch');

SAIA= conv(newP1,currentA);

figure;
wc=(newF1(1)+newF1(1)):50:(newF1(end)+newF1(end));
stem(wc,SAIA)
grid on;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('FFT Analysis','FontSize',14,'FontWeight','Bold')
title('Current and Switch Modulation');
sqrt(sum(newP.*newP))


%%
capacitor_ripple= capA_phA.*SAIA;

figure();
plot(wc,capacitor_ripple);
sqrt(sum(abs(capacitor_ripple).*abs(capacitor_ripple)));




