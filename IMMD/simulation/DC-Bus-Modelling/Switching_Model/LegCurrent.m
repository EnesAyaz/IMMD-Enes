%% 
clc;
clear all;
close all;

%% initializing the input parameters
fout = 50; % output frequency Hz 
fsw = 1e3; % carrier frequency Hz

ma=0.9; % modulation index
w_o=2*pi*fout; % output frequency radian
w_c= 2*pi*fsw; % carrier frequency radian
The_o=0; % output phase
The_c=pi/4; % carrier phase 
The_L=-pi/3; % phase of load
mag_I=5;


%% Time axis-creation 
Tstep = 1e-6; % s
Ts = Tstep; % s
Tfinal= 1/fout;
time_array = 0:Tstep:Tfinal-Tstep;
NumberofSteps = numel(time_array);

%%
%% Generate switching signals
Vref = ma*sin(2*pi*fout*time_array-The_o);
Vcarrier = zeros(1, NumberofSteps);
for k = 1:Tfinal*fsw
   Triang_temp = triang(1/(Ts*fsw));
   Vcarrier((length(Triang_temp)*(k-1)+1:k/(Tstep*fsw))) = (Triang_temp*2)-1;
end
if The_c ~= 0
    pc=1+((1/fsw)/Tstep)*The_c/2*pi; % number of step which equals to carrier of phase
    Vcarrier= [Vcarrier(pc:end), Vcarrier(1:pc)];
end

S = double(Vref > Vcarrier);


%% for analytical switch




%% for SA

% here, output references is sliding -pi/2.
% and -pi at carrier for pi/3
AnalyticalSwitch=zeros(size(time_array));

for m=1:100
    for n= -100:100  
        AnalyticalSwitch=AnalyticalSwitch+ (2/(m*pi))*sin((m+n)*pi/2)*...
                besselj(n,m*ma*pi/2)*...
                cos(m*(w_c*time_array+2*The_c) ...
                +n*(w_o*time_array-The_o-pi/2));
       
        
        
    end
end


AnalyticalSwitch= AnalyticalSwitch+(1/2)+ (ma/2)*cos(w_o*time_array-The_o-pi/2);


%%


figure();
plot(time_array,AnalyticalSwitch,'Linewidth',2);
hold on;
plot(time_array,S,'Linewidth',2);
hold on; 
plot (time_array,Vcarrier,'Linewidth',2);
hold on;
plot(time_array,Vref, 'Linewidth',2);


legend('Analytical Solution', 'Carrier-Based PWM','Carrier','Reference');

%%
figure();
plot(time_array,AnalyticalSwitch,'Linewidth',2);
hold on;
plot(time_array,S,'Linewidth',2);
legend('Analytical Solution', 'Carrier-Based PWM')

%% output current
I = mag_I*sin(w_o*time_array-The_o+The_L);
%% for leg current S*I
currentLeg= S.*I;

figure();
plot(time_array,currentLeg,'Linewidth',2);

%%
figure();
plot(time_array,AnalyticalSwitch,'Linewidth',2);
hold on;
plot(time_array,S,'Linewidth',2);
hold on; 
plot(time_array,currentLeg,'Linewidth',2);
hold on;
plot(time_array,Vref, 'Linewidth',2);


legend('Analytical Solution', 'Carrier-Based PWM','Leg Current','Reference');

%%

%% for SI

AnalyticalLegCurrent=zeros(size(time_array));

for m=1:100
    for n= -100:100  
        AnalyticalLegCurrent=AnalyticalLegCurrent+ (mag_I/(m*pi))*sin((m+n)*pi/2)*...
                besselj(n,m*ma*pi/2)*...
                (cos(m*(w_c*time_array+2*The_c) ...
                +n*(w_o*time_array-The_o-pi/2)+w_o*time_array+The_L)+ ...
                cos(m*(w_c*time_array+2*The_c) ...
                +n*(w_o*time_array-The_o-pi/2)-w_o*time_array-The_L));
       
        
        
    end
end


AnalyticalLegCurrent= AnalyticalLegCurrent+(I/2)+( (ma/2)*cos(w_o*time_array-The_o-pi/2)).*I/2;

%%

figure();
plot(time_array,AnalyticalLegCurrent,'Linewidth',2);
hold on;
plot(time_array,currentLeg,'Linewidth',2);
hold on;



