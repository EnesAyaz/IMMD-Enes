%%
clear
clc
%%
f_c= 1e4; %% in Hz
N=20000; %% determines time interval
sampleTime = 1/(10*f_c);
time= 0:sampleTime:sampleTime*N;

sampleNumber= length(time); %% or it is equal to N+1

%%
% sequence creater
%each sample time 1 or -1 sequence is created

sequenceCounter=0;
sequence= zeros(1,sampleNumber);
for i=1:length(time)
    if sequenceCounter<5
       sequence(i)=-1+sequenceCounter*0;
       sequenceCounter=sequenceCounter+1;
    else if sequenceCounter<10
        sequence(i)=1;
        sequenceCounter=sequenceCounter+1;
        else 
            sequenceCounter=0;
                 
        end 
    end 
end

 

%%
f_m= 50; % carrier frequency
m= 0.9; % modulation index
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


%%



%%
figure(1);
tout=ic.time;
y=ic.data;
plot(tout,y);
%%


f_s= 1/(tout(2)-tout(1));

y = fft(y);

L=length(y);

P2= abs(y/L);
P1=P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);

f= f_s*(0:(L/2))/L;

figure(2);
stem(f,P1)