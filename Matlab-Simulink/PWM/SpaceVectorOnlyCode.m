% determine sampling time and stop time
clc;
clear;
sampleTime= 1e-4;
timeStop=0.1;
time= 0:sampleTime:timeStop;

f_s=1000;
t_s=1/f_s;
V_dc=500;

switching_interval= ...
    int64(t_s/sampleTime);
    
v= zeros(3,switching_interval);
iterationNumber= length(time);

clarke=[2/3, -1/3,-1/3 ;
        0, 1/sqrt(3), -1/sqrt(3);
        1/3, 1/3, 1/3];
dummy=[];
dummy2=[];
dummy3=[];
dummy4=[];
repeatingSequence=-1;
counterSwitch=0;
switchBegin=1;
VoltageA=[];
VoltageB=[];
VoltageC=[];
for i=1:iterationNumber

f_reference=50; % reference current
A_reference=100;  % reference voltage
% three phase sinusoidal creater
phaseA= A_reference*...
    cos(time(i)*2*pi*f_reference);

phaseB= A_reference*...
    cos(time(i)*2*pi*f_reference-2*pi/3);

phaseC= A_reference*...
    cos(time(i)*2*pi*f_reference+2*pi/3);

abc= [phaseA;phaseB;phaseC];
x=mtimes(clarke,abc);

dummy=[dummy x];

alfa=x(1);
beta=x(2);
[angle,mag]=cart2pol(alfa,beta);
dummy3=[dummy3 mag];
dummy4=[dummy4 angle];


if counterSwitch ==switching_interval
    v=SectorFinder...
        (t_s,sampleTime,...
        switching_interval,...
        angle,alfa,beta,V_dc);
         switchBegin=1;
         counterSwitch=0;
         
va=(2/3)*v(1,switchBegin)-...
    (1/3)*(v(2,switchBegin)...
    +v(3,switchBegin));
VoltageA=[VoltageA; va];

vb=(2/3)*v(2,switchBegin)-...
    (1/3)*(v(1,switchBegin)...
    +v(3,switchBegin));
VoltageB=[VoltageB; vb];

vc=(2/3)*v(3,switchBegin)-...
    (1/3)*(v(2,switchBegin)...
    +v(1,switchBegin));
VoltageC=[VoltageC; vc];
    
else 
    va=(2/3)*v(1,switchBegin)-...
    (1/3)*(v(2,switchBegin)...
    +v(3,switchBegin));
    VoltageA=[VoltageA; V_dc*va];

    vb=(2/3)*v(2,switchBegin)-...
    (1/3)*(v(1,switchBegin)...
    +v(3,switchBegin));
    VoltageB=[VoltageB; V_dc*vb];

    vc=(2/3)*v(3,switchBegin)-...
    (1/3)*(v(2,switchBegin)...
    +v(1,switchBegin));
    VoltageC=[VoltageC; V_dc*vc];

    switchBegin=switchBegin+1;
    counterSwitch=counterSwitch+1;
    
end

if mod(i,10)==0
   disp(i);
end

end


lowpass(VoltageA-VoltageB,50,(1/sampleTime));
% % figure(4);
% % plot(time,dummy2(1,:));
% % title('Triangle');
% % ylim([-1.5 1.5])
% figure(5)
% title('Voltage of Phase');
% plot(time,VoltageA,time,VoltageB,...
%     time,VoltageC);
% 
% figure(1);
% plot(dummy(1,:));
% hold on;
% plot(dummy(2,:));
% hold on;
% plot(dummy(3,:));
% hold off;
% title('Alfa Beta Conversion (Clarke)')
% 
% figure(2);
% plot(dummy3(1,:));
% title('Magnitude')
% figure(3);
% plot(dummy4(1,:));
% title('Phase')
