%% clearness
clc;
clear;
%% determine sampling time and stop time
sampleTime=1e-6;
timeStop=0.04;
time=0;
simulationTime=[];

%% Switching Frequency and DC Link determination
f_s=1000;
t_s=1/f_s;
V_dc=500;

%% Clarke Transformation Matrix (abcToAlfaBetaZero)
clarke=[2/3, -1/3,-1/3 ;
        0, 1/sqrt(3), -1/sqrt(3);
        1/3, 1/3, 1/3];

%% Reference Signal
f_reference= 50; %in Hz
A_reference=100; %in Voltage

%%
ma= (A_reference/V_dc)*sqrt(3);
Sabc=[];
Sa=0; Sb=0; Sc=0;
%%
dummy1=[];
dummy2=[];
dummy3=[];
%%
while time< timeStop


% three phase sinusoidal creater
phaseA= A_reference*cos(time*2*pi*f_reference);

phaseB= A_reference*cos(time*2*pi*f_reference-2*pi/3);

phaseC= A_reference*cos(time*2*pi*f_reference+2*pi/3);

abc= [phaseA;phaseB;phaseC];

x=mtimes(clarke,abc);
% alfa=x(1); beta=x(2);
[angle,mag]=cart2pol(x(1),x(2));

% dummy1=[dummy1 ,angle];
% dummy2=[dummy2, mag];

%%Sector Finder
angle=mod(angle,2*pi);
timeMod=mod(time,t_s);
%% Sector 1 
if angle<=pi/3 && angle>0
    n=1;
    thetaprime= angle-(n-1)*pi/3;
    
    Ta= t_s*ma*sin(pi/3-thetaprime);
    Tb= t_s*ma*sin(thetaprime);
    T0= t_s-Ta-Tb;
    
    times=[T0/4 Ta/2 Tb/2 T0/2 Tb/2 Ta/2 T0/4];
    times=cumsum(times); 
    
    va= [0 1 1 1 1 1 0];
    vb= [0 0 1 1 1 0 0];
    vc= [0 0 0 1 0 0 0];
    
    for j = 1:7            
            if(timeMod<times(j))
                break
            end
    end
   
    Sa= va(j);
    Sb= vb(j);
    Sc= vc(j);
    
end

%% Sector 2
if angle<=2*pi/3 && angle>pi/3
    n=2;
    thetaprime= angle-(n-1)*pi/3;
    
    Tb= t_s*ma*sin(pi/3-thetaprime);
    Ta= t_s*ma*sin(thetaprime);
    T0= t_s-Ta-Tb;
    
    times=[T0/4 Ta/2 Tb/2 T0/2 Tb/2 Ta/2 T0/4];
    times=cumsum(times); 
    
    va= [0 0 1 1 1 0 0];
    vb= [0 1 1 1 1 1 0];
    vc= [0 0 0 1 0 0 0];
    
    
    for j = 1:7            
            if(timeMod<times(j))
                break
            end
    end
   
    Sa= va(j);
    Sb= vb(j);
    Sc= vc(j);
    
end
%% Sector 3 
if angle<=pi && angle>2*pi/3
    n=3;
    thetaprime= angle-(n-1)*pi/3;
    
    Ta= t_s*ma*sin(pi/3-thetaprime);
    Tb= t_s*ma*sin(thetaprime);
    T0= t_s-Ta-Tb;
    
    times=[T0/4 Ta/2 Tb/2 T0/2 Tb/2 Ta/2 T0/4];
    times=cumsum(times); 
    
    va= [0 0 0 1 0 0 0];
    vb= [0 1 1 1 1 1 0];
    vc= [0 0 1 1 1 0 0];
    
    for j = 1:7            
            if(timeMod<times(j))
                break
            end
    end
   
    Sa= va(j);
    Sb= vb(j);
    Sc= vc(j);
    
end
%% Sector 4
if angle<=4*pi/3 && angle>pi
    n=4;
    thetaprime= angle-(n-1)*pi/3;
    
    Tb= t_s*ma*sin(pi/3-thetaprime);
    Ta= t_s*ma*sin(thetaprime);
    T0= t_s-Ta-Tb;
    
    times=[T0/4 Ta/2 Tb/2 T0/2 Tb/2 Ta/2 T0/4];
    times=cumsum(times); 
    
    va = [0 0 0 1 0 0 0];
    vb = [0 0 1 1 1 0 0];
    vc = [0 1 1 1 1 1 0];
    
    for j = 1:7            
            if(timeMod<times(j))
                break
            end
    end
   
    Sa= va(j);
    Sb= vb(j);
    Sc= vc(j);
    
end
%% Sector 5
if angle<=5*pi/3 && angle>4*pi/3
    n=5;
    thetaprime= angle-(n-1)*pi/3;
    
    Ta= t_s*ma*sin(pi/3-thetaprime);
    Tb= t_s*ma*sin(thetaprime);
    T0= t_s-Ta-Tb;
    
    times=[T0/4 Ta/2 Tb/2 T0/2 Tb/2 Ta/2 T0/4];
    times=cumsum(times); 
    
    
    va= [0 0 1 1 1 0 0];
    vb= [0 0 0 1 0 0 0];
    vc= [0 1 1 1 1 1 0];
    
    for j = 1:7            
            if(timeMod<times(j))
                break
            end
    end
   
    Sa= va(j);
    Sb= vb(j);
    Sc= vc(j);
    
end

%% Sector 6
if angle<=2*pi && angle>5*pi/3
    n=6;
    thetaprime= angle-(n-1)*pi/3;
    
    Tb= t_s*ma*sin(pi/3-thetaprime);
    Ta= t_s*ma*sin(thetaprime);
    T0= t_s-Ta-Tb;
    
    times=[T0/4 Ta/2 Tb/2 T0/2 Tb/2 Ta/2 T0/4];
    times=cumsum(times); 
    
    va= [0 1 1 1 1 1 0];
    vb= [0 0 0 1 0 0 0];
    vc= [0 0 1 1 1 0 0];
    
    for j = 1:7            
            if(timeMod<times(j))
                break
            end
    end
   
    Sa= va(j);
    Sb= vb(j);
    Sc= vc(j);
    
end
%%
Sabc=[Sabc, [Sa;Sb;Sc]];

%%
simulationTime=[simulationTime time];
time=time+sampleTime;
disp(time);
end
%%
plot(simulationTime,Sabc(1,:)-Sabc(2,:));
% hold on;
% plot(Sabc(2,:)-Sabc(3,:));
% hold on;
% plot(Sabc(3,:)-Sabc(1,:));
