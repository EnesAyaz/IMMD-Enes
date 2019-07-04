function [PWM]= SinosoidalPWM(fc,fm,Am)
Ac=1
Tc=1/fc;
m=Ac/(Tc/4);
Vdc=1;
Tm=1/fm;
w=2*pi*fm;

Mi=Am/Ac% Modulation index
Mr=Tm/Tc% Modulation ratio
% *****************************************
% Single Triangular waveform
t1=0:Tc/100:(Tc/4)-(Tc/100);
    V1=m*t1;
t2=(Tc/4):Tc/100:(Tc*3/4)-(Tc/100);
    V2=-m*t2+2;
t3=(Tc*3/4):Tc/100:Tc;
    V3=m*t3-4;
 t=[t1 t2 t3];
 Vc=[V1 V2 V3];
% Plotting of carrier waveform
tt=0:Tc/100:Mr*Tc;
Vic=Vc;
for i=1:Mr-1
    Vic=[Vic Vc(1:end-1)];
end
subplot 411
plot(tt,Vic)
title('Carrier wave')
xlabel('Time(sec)')
ylabel('Amplitude')
% Modulating waveform
tm=0:Tm/(Mr*100):Tm;
Vm=Am*sin(w*tm);
subplot 412
plot(tm,Vm)
title('Modulating wave')
xlabel('Time(sec)')
ylabel('Amplitude')
% PWM waveform
 tf=0:Tm/(Mr*100):Tm;
p=find(Vic>=Vm);
    Vg(p)=-Vdc;
q=find(Vic<Vm);
     Vg(q)=Vdc;
subplot 414
plot(tf,Vg)
title('PWM waveform')
xlabel('Time(sec)')
ylabel('Amplitude')
% Plotting Carrier wave & Modulating wave
subplot 413
plot(tf,Vic,tm,Vm)
title('Carrier wave & Modulating wave')
xlabel('Time(sec)')
ylabel('Amplitude')

end