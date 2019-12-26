tic;
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
The_c=0;
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
k=ma;
w_o=2*pi*fout;
w_c= 2*pi*fsw;
The_o=pi/2;
The_c=0;
%% for SA
SAA=zeros(size(time_array));

for m=1:100
    for n= -100:100  
        SAA=SAA+ (2/(m*pi))*sin((m+n)*pi/2)*...
                besselj(n,m*k*pi/2)*...
                cos(m*(w_c*time_array-The_c)...
                +n*(w_o*time_array-The_o));
       
        
        
    end
end


SAA= SAA+(1/2)+ (k/2)*cos(w_o*time_array-The_o);

toc;

%%
figure();
plot(time_array,SAA,'Linewidth',2);
hold on;
plot(time_array,SA,'Linewidth',2);

legend('Analytical Solution', 'Carrier-Based PWM')

