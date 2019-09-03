
% Vdc in terms of Iin
Crec = 5e-3;
RL = 1;
w = 2*pi*50*6;
denom = 1 + 1i*w*Crec*RL;
nom = RL;
ratio = nom/denom;
Iin_mag = 103.7;
Iin_ph = 97*pi/180;
Iin_phasor = Iin_mag*cos(Iin_ph) + 1i*Iin_mag*sin(Iin_ph);
Vdc_phasor = Iin_phasor*ratio;
Vdc_mag = abs(Vdc_phasor)
Vdc_ph = phase(Vdc_phasor)*180/pi

fc = 1/(1*pi*RL*Crec)