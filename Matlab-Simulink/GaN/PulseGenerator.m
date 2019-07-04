function [Top, Bottom]= PulseGenerator(timeArray,fsw,SampleTime,Dtop,Dbot)
VpulseMax = 6;
VpulseMin = -3;
% Dtop = 49; % duty cycle of top
% Dbot = 49; % duty cycle of bot
DelayTop = 50;
DelayBot = 50;

[~,n] = size(timeArray);
Top = zeros(size(timeArray));
Bottom = zeros(size(timeArray));

for time = 1:n
    PseudoTime = mod(SampleTime*time,1/fsw); 
    if (PseudoTime >= 0 && PseudoTime < (Dbot/100)/fsw) %bottom on top off dead time öncesi
        Top(time) = VpulseMin;
        Bottom(time) = VpulseMax;
    elseif (PseudoTime >= ((Dbot/100)/fsw) && PseudoTime < ((1-DelayBot/100)/fsw))%bottom off oldu top off zaten dead time
        Top(time) = VpulseMin;
        Bottom(time) = VpulseMin;
    elseif PseudoTime >= ((DelayTop/100)/fsw) && PseudoTime < ((0.5 + Dtop/100)/fsw) %top on bottom off dead time öncesi
        Top(time) = VpulseMax;
        Bottom(time) = VpulseMin;
    else
        Top(time) = VpulseMin;
        Bottom(time) = VpulseMin; 
    end
end