% determine sampling time and stop time
sampleTime= 1e-4;
timeStop=5;
time= 0:sampleTime:timeStop;
    
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
switchBegin=0;
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

f_s=1000;
t_s=1/f_s;
V_dc=500;

switching_interval= ...
    int64(t_s/sampleTime);

if counterSwitch ==switching_interval
    v=SectorFinder...
        (t_s,sampleTime,...
        switching_interval,...
        angle,alfa,beta,V_dc);
         switchBegin=1;
         counterSwitch=0;
    
else 
    switchBegin=switchBegin+1;
    counterSwitch=counterSwitch+1;
end


% 
% if counter==switching_interval
%     if mod(i,4)==1
%         repeatingSequence=-1;
%     else if mod(i,4)==2 ...
%             ||  mod(i,4)==0
%          repeatingSequence=0;
%         else
%             repeatingSequence=1;
%         end
%     end
%     dummy2=[dummy2 repeatingSequence];
%     counter=0;
% else
%     counter=counter+1;
%     dummy2=[dummy2 repeatingSequence];
% end
% 






end
% figure(4);
% plot(time,dummy2(1,:));
% title('Triangle');
% ylim([-1.5 1.5])

figure(1);
plot(dummy(1,:));
hold on;
plot(dummy(2,:));
hold on;
plot(dummy(3,:));
hold off;
title('Alfa Beta Conversion (Clarke)')

figure(2);
plot(dummy3(1,:));
title('Magnitude')
figure(3);
plot(dummy4(1,:));
title('Phase')
