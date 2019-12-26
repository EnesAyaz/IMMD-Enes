%% Time array
Tstep = 1e-6; % s
Ts = Tstep; % s
ma = 0.9;
fout = 50; % Hz
fsw = 1e3; % Hz
Tfinal =1/fout ; % s
time_array = 0:Tstep:Tfinal-Tstep;
NumberofSteps = numel(time_array);
%% Generate switching signals
VrefA = ma*sin(2*pi*fout*time_array);
VrefB = ma*sin(2*pi*fout*time_array-2*pi/3);
VrefC = ma*sin(2*pi*fout*time_array-4*pi/3);
Vtriang = zeros(1, NumberofSteps);
for k = 1:Tfinal*fsw
   Triang_temp = triang(1/(Ts*fsw));
   Vtriang((length(Triang_temp)*(k-1)+1:k/(Tstep*fsw))) = (Triang_temp*2)-1;
end
Vcarrier = Vtriang;
SA = double(VrefA > Vcarrier);
SB = double(VrefB > Vcarrier);
SC = double(VrefC > Vcarrier);

%%
DC_Voltage= 300; 
modulation_index=0.8;
phase_voltage=(DC_Voltage*modulation_index);
Z_Load= 30 ;
load_angle=pi/6;
phase_current= phase_voltage/Z_Load;
power3Phase= (3/2)*cos(load_angle)* phase_voltage^2/(Z_Load);
disp("Power of 3 Phase "+ string(power3Phase)+"Watt");
I_Load_A = phase_current*ma*sin(2*pi*fout*time_array-load_angle);
I_Load_B = phase_current*ma*sin(2*pi*fout*time_array-2*pi/3-load_angle);
I_Load_C = phase_current*ma*sin(2*pi*fout*time_array-4*pi/3-load_angle);

%%
figure()
subplot(3,1,1);
stem(time_array,Vcarrier, ...
     'MarkerFaceColor','white',...
     'MarkerEdgeColor','white');
hold on;
plot(time_array, VrefA,'Linewidth',3);
legend('Carrier ','Reference of Phase A')
title('Triangular Modulation of Phase A')


subplot(3,1,2);
stem(time_array,SA, ...
     'MarkerFaceColor','white',...
     'MarkerEdgeColor','white');
hold on;
plot(time_array, VrefA,'Linewidth',3);
title('Voltage of Modulated of Phase A')
legend('PWM of Top-Switch Phase A','One-Leg Voltage-PhaseA')


subplot(3,1,3);

plot(time_array, I_Load_A,'Linewidth',3);
hold on;
stem(time_array,SA.*I_Load_A, ...
     'MarkerFaceColor','white',...
     'MarkerEdgeColor','white');
title('Load Current and reflected DC Bus Current')
name="Load Current A"+ "Load Angle " + string(load_angle*180/pi);
legend(name,'DC Bus Current for Phase A');

%% Intergral of DC current 
average_current_PhaA= (sum(SA.*I_Load_A)*Ts)/ Tfinal;
disp(string(average_current_PhaA) +' DC current from Phase A ');

%%
figure()
subplot(3,1,1);
stem(time_array,Vcarrier, ...
     'MarkerFaceColor','white',...
     'MarkerEdgeColor','white');
hold on;
plot(time_array, VrefB,'Linewidth',3);
legend('Carrier ','Reference of Phase B')
title('Triangular Modulation of Phase B')


subplot(3,1,2);
stem(time_array,SB, ...
     'MarkerFaceColor','white',...
     'MarkerEdgeColor','white');
hold on;
plot(time_array, VrefB,'Linewidth',3);
title('Voltage of Modulated of Phase A')
legend('PWM of Top-Switch Phase B','One-Leg Voltage-PhaseB')


subplot(3,1,3);

plot(time_array, I_Load_B,'Linewidth',3);
hold on;
stem(time_array,SB.*I_Load_B, ...
     'MarkerFaceColor','white',...
     'MarkerEdgeColor','white');
title('Load Current and reflected DC Bus Current')
name="Load Current B"+ "Load Angle " + string(load_angle*180/pi);
legend(name,'DC Bus Current for Phase B');
%% Intergral of DC current 
average_current_PhaB= (sum(SB.*I_Load_B)*Ts)/ Tfinal;
disp(string(average_current_PhaB)+' DC current from Phase B ');

%%
%%
figure()
subplot(3,1,1);
stem(time_array,Vcarrier, ...
     'MarkerFaceColor','white',...
     'MarkerEdgeColor','white');
hold on;
plot(time_array, VrefC,'Linewidth',3);
legend('Carrier ','Reference of Phase C')
title('Triangular Modulation of Phase C')


subplot(3,1,2);
stem(time_array,SC, ...
     'MarkerFaceColor','white',...
     'MarkerEdgeColor','white');
hold on;
plot(time_array, VrefC,'Linewidth',3);
title('Voltage of Modulated of Phase C')
legend('PWM of Top-Switch Phase C','One-Leg Voltage-PhaseC')


subplot(3,1,3);

plot(time_array, I_Load_C,'Linewidth',3);
hold on;
stem(time_array,SC.*I_Load_C, ...
     'MarkerFaceColor','white',...
     'MarkerEdgeColor','white');
title('Load Current and reflected DC Bus Current')
name="Load Current C"+ "Load Angle " + string(load_angle*180/pi);
legend(name,'DC Bus Current for Phase B');
%% Intergral of DC current 
average_current_PhaC= (sum(SC.*I_Load_C)*Ts)/ Tfinal;
disp(string(average_current_PhaC)+' DC current from Phase C ');

%% 
disp(string(average_current_PhaA ...
    +average_current_PhaB+average_current_PhaC)...
    +' total DC current ');

disp("Power of DC Input "+ string((average_current_PhaA ...
    +average_current_PhaB+average_current_PhaC )*DC_Voltage)...
    +"Watt");

%%  Total DC Current 
figure();
total_DC= SA.*I_Load_A+SB.*I_Load_B+SC.*I_Load_C;

plot(time_array, total_DC,'Linewidth',3);
name="DC current "+ "Load Angle with  " + string(load_angle*180/pi);
title(name)

%%
%% Intergral of DC current 
average_current_all= (sum(total_DC)*Ts)/ Tfinal;
disp(string(average_current_all)+' DC current');

%%
rms_current_all= sqrt((sum(total_DC.^2)*Ts))/ Tfinal;
disp(string(rms_current_all)+' RMS current');


%%  capacitor Current
figure();
total_cap= (SA.*I_Load_A+SB.*I_Load_B+SC.*I_Load_C)-average_current_all;

plot(time_array, total_cap,'Linewidth',3);
name="Capacitor current "+ "Load Angle with  " + string(load_angle*180/pi);
title(name)