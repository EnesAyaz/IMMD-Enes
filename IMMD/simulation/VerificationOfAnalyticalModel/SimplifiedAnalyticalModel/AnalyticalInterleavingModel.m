ThC=[0 pi];
ThF=[0 -2*pi/3 2*pi/3];
M= 0.9;
f_fund= 50;
f_c= 40000;

[f, mag, ang]= HarmonicOfPWM(ThC(2),ThF(1),M,f_fund,f_c);
%%

w= 2*pi*f;
complexS= mag.* exp(1i.*w+1i.*mod(ang,2*pi));

%%

figure();
stem(w/(2*pi),angle(complexS))
grid on;
grid minor;
set(gca,'FontSize',14);
xlabel('Frequency (Hz)','FontSize',14,'FontWeight','Bold')
ylabel('Mag of harmonic components','FontSize',14,'FontWeight','Bold')
title('Switching Functions of Cosinüs');


%%

