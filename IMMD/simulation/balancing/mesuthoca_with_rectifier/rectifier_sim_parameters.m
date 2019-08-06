Ts = 1e-6; % sec
Tfinal = 0.2; % sec
Ripth = 0.18; % sec
fsw = 10e3; % Hz
Vdc = 270; % Volts
fout = 50; % Hz
wout = 2*pi*fout; % rad/sec
m = 3;
np = 1;
ns = 1;
n = ns*np;
phase = [0 90 0 90];
Cdc = 15e-6;
delta = 0; % deg

% calculate nominal values
Pmodt = 2e3;
pft = 0.9;
manom = 0.9;
Vdcnom = Vdc/ns;
Vllrmsnom = 0.612*manom*Vdcnom;
Vlnrms = Vllrmsnom/sqrt(3);
Smodt = Pmodt/pft;
Ilinemod = Smodt/(3*Vlnrms);
Znom = Vlnrms/Ilinemod;
Rnom = Znom*pft;
Xnom = sqrt(Znom^2-Rnom^2);
Lnom = Xnom/(2*pi*fout);

Lload_1A = Lnom*1.00; % Henries
Lload_1B = Lnom*1.00; % Henries
Lload_1C = Lnom*1.00; % Henries
Rload_1A = Rnom*1.00; % Ohms
Rload_1B = Rnom*1.00; % Ohms
Rload_1C = Rnom*1.00; % Ohms

Lload_2A = Lnom*1.00; % Henries
Lload_2B = Lnom*1.00; % Henries
Lload_2C = Lnom*1.00; % Henries
Rload_2A = Rnom*1.00; % Ohms
Rload_2B = Rnom*1.00; % Ohms
Rload_2C = Rnom*1.00; % Ohms

pf1A = Rload_1A/Z1A;
pf1B = Rload_1B/Z1B;
pf1C = Rload_1C/Z1C;
pf2A = Rload_2A/Z2A;
pf2B = Rload_2B/Z2B;
pf2C = Rload_2C/Z2C;

ma1 = 0.9;

Pout = Pmodt;
Rin = 10;
Rmid = 5;
Cdcrec = 2e-3;
Vin = Vdc + (Rin+Rmid)*(Pout/Vdc);

GridFreq = 50;
Vacrms = 115;
Voutdcrec = Vacrms*sqrt(2)*sqrt(3);
Poutrec = Pmodt;
Ioutrec = Poutrec/Voutdcrec;
Rloadrec = Voutdcrec/Ioutrec;

