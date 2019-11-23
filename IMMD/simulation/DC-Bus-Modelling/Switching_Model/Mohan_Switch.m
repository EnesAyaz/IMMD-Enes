% Mohan 8.2 table 8-1  shows generalized harmonics
ma= [0.2 0.4 0.6 0.8 1.0];

DC=[1/2 1/2 1/2 1/2 1/2];

f1= [0.2 0.4 0.6 0.8 1.0];

mf=[1.242 1.15 1.006 0.818 0.601];

TwoMf1=[0.190 0.326 0.370 0.314 0.181];

ThreeMf=[0.335 0.123 0.083 0.171 0.113];

FourMf1=[0.163 0.157 0.008 0.105 0.068];

figure(1)
plot(ma,DC,ma,f1,ma,mf,ma,TwoMf1,ma,ThreeMf,ma,FourMf1,'Linewidth',2);
xlabel('modulation index');
ylabel('Harmonic distribution with respect to 1/2Vd')
legend('DC','fundamental','Switching','TwoFoldSwitching','ThreeFoldSwitching','FourFoldSwitching');
grid on;

%
