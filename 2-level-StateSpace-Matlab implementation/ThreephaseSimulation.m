%%
clc;
clear;

%%
sampleTime=1e-4;
stopTime=0.05;
time=0;
f_phase=50;
A_phase=100;
phases=[0; -86.6 ; 86.6];
simulationTime=[0];
clarkes=[0;0;0];
while time<stopTime
    %%
    figure(1);
    subplot(2,2,1);
    grid on;
    grid minor;
    plot(simulationTime,phases(1,:),'r','LineWidth',5);
    plot(simulationTime,phases(2,:),'b','LineWidth',5);
    plot(simulationTime,phases(3,:),'g','LineWidth',5);
    hold on;
    title("Phase Voltages with respect to time");
    ylabel('Voltage(V)');
    xlabel('time(second)');
    xlim([0, stopTime]);
    ylim([-1.5*A_phase,1.5*A_phase]);
    
%     legend('Phase A','Phase B','Phase C');
    
      
    phaseA=A_phase*sin(2*pi*f_phase*time);
    phaseB=A_phase*sin(2*pi*f_phase*time-(2*pi/3));
    phaseC=A_phase*sin(2*pi*f_phase*time+(2*pi/3));
    
    phases=[phases, [phaseA; phaseB;phaseC]];
    %%
    vectorA= [0,0; phaseA,0 ];
    vectorB= [0,0; -phaseB*cos(pi/6), -phaseB*sin(pi/6)];
    vectorC=[0,0; -phaseC*cos(pi/6),phaseC*sin(pi/6)];
    vectorTotal=[vectorA(1,1)+vectorB(1,1)+vectorC(1,1),vectorA(1,2)+vectorB(1,2)+vectorC(1,2)...
        ;vectorA(2,1)+vectorB(2,1)+vectorC(2,1),vectorA(2,2)+vectorB(2,2)+vectorC(2,2)];
%     sqrt(vectorTotal(2,1)^2+vectorTotal(2,2)^2);
    subplot(2,2,2);
    axis equal;
    hold off;
    plot(vectorA(:,1),vectorA(:,2),'r','LineWidth',5);
    hold on;
    plot(vectorB(:,1),vectorB(:,2),'b','LineWidth',5);
    hold on;
    plot(vectorC(:,1),vectorC(:,2),'g','LineWidth',5);
    hold on;
    plot(vectorTotal(:,1),vectorTotal(:,2),'k','LineWidth',5);
    hold on;
    
    ylabel('Real Axis');
    xlabel('Imaginary Axis');
    title('Vector Representation of Phases');
    ylim([-200 200]);
    xlim([-200 200]);
    grid on;
    grid minor;
%     legend('Phase A','Phase B','Phase C');

    %%
    subplot(2,2,3);
    grid on;
    grid minor;
    plot(simulationTime,clarkes(1,:),'m','LineWidth',5);
    plot(simulationTime,clarkes(2,:),'c','LineWidth',5);
    plot(simulationTime,clarkes(3,:),'k','LineWidth',5);
    hold on;
    title("Alfa-Beta Waveforms with respect to time");
    ylabel('Voltage(V)');
    xlabel('time(second)');
    xlim([0, stopTime]);
    ylim([-1.5*A_phase,1.5*A_phase]);

    clarkeMatrix= (2/3)*[1 -1/2 -1/2;...
        0 sqrt(3)/2 -sqrt(3)/2;...
        1/2 1/2 1/2];
    clarke=mtimes(clarkeMatrix,[phaseA;phaseB;phaseC]);
    clarkes=[clarkes,clarke];
    
    %%
    simulationTime=[simulationTime,time];
    time= time+sampleTime;
    disp(time);
end
