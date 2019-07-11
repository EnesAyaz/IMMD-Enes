%%
clear
clc
%%
f_c= 5e4; %% in Hz
N=100000; %% determines time interval
sampleTime = 1/(10*f_c);
time= 0:sampleTime:sampleTime*N;

sampleNumber= length(time); %% or it is equal to N+1

%%
% sequence creater
%each sample time 1 or -1 sequence is created

sequenceCounter=0;
sequence= zeros(1,sampleNumber);
for i=1:length(time)
    if sequenceCounter==0 
       sequence(i)=-1;
       sequenceCounter=sequenceCounter+1;
    else 
        sequence(i)=1;
        sequenceCounter=0;
                 
    end 
   
    
end

%%
f_m= 50; % carrier frequency
m= 0.5; % modulation index
%%
carrier=[];
for i=1:length(time)
    carrier= [carrier m*sin(2*pi*f_m*time(i))];
    
end
%%
figure();
plot(time,sequence);
hold on;
plot(time,carrier)

%%
PWMon=6;
PWMoff=-3;
pwm = [];
for i=1:length(time)
    if carrier(i)> sequence(i)
       pwm=[pwm PWMon];
    else
        pwm=[pwm PWMoff];
    end
    
end

%%
figure();
plot(time, pwm);
ylim([-4 7])