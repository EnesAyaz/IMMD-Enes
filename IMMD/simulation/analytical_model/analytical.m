%% parameter
w= [50, 40000];
CA=5e-6;
LATop=3e-9;
LABot=3e-9;
ESLA= 3e-15;
CB=5e-6;
LABTop=3e-9;
LABBot=3e-9;
ESLB= 3e-15;
LBTop=3e-9;
LBBot=3e-9;
CC=5e-6;
LBCTop=3e-9;
LBCBot=3e-9;
ESLC= 3e-15;
LCTop=3e-9;
LCBot=3e-9;

%%  Phase A 
currA= [10+10i, 2+2i];
Za= j*w*(LATop+LABot+ESLA) - (j./(w*CA));
Zc= j*w*(LBTop+LBCTop+LABot+LBCBot+ESLC) - (j./(w*CC));
Zbc= j*w*(LABTop+LABBot)+ (Zc+(j*w*ESLB- j./(w*CB)));
Z= 1./(1./Za+ 1./Zbc);

Va= Z.*currA;
ia=Va/Za;
