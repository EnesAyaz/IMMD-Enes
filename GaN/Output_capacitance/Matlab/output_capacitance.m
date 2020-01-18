
%%
filename = 'Z:\github\IMMD-Enes\GaN\Output_capacitance\LTspice_model\output_capacitance_model.txt';
delimiter = '\t';
startRow = 2;
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
time = dataArray{:, 1};
Vds = dataArray{:, 2};
clearvars filename delimiter startRow formatSpec fileID dataArray ans;
%% 
figure();
plot(time,Vds,'LineWidth',3);
xlabel("Time(s)")
ylabel("Vds(V)")
title("Drain Source Voltage during switch-off");

%% 
threshold= 0.060;
index=find(Vds>threshold);
%% only Vds is bigger than some threahold
Vds=Vds(index);
time=time(index);
%%
figure();
plot(time,Vds,'LineWidth',3);
xlabel("Time(s)")
ylabel("Vds(V)")
title("Drain Source Voltage during switch-off");

%% finding t0 which means inductor current is zero
t0 = find(Vds==max(Vds));
%% integrating Vds from 0 to t0 
sum((Vds(2:t0) - Vds(1:t0-1)).*(time(2:t0)-time(1:t0-1)));

%% integrating which any t
t=20;
sum((Vds(2:t) - Vds(1:t-1)).*(time(2:t)-time(1:t-1)));
%%
t_final= t0;
L=1e-3;
C_vds=[];
for t=2:t_final
    
C_vds=[C_vds, sum((Vds(2:t0) - Vds(1:t0-1)).*(time(2:t0)-time(1:t0-1)))- sum((Vds(2:t)- Vds(1:t-1)).*(time(2:t)-time(1:t-1)))];
C_vds(end)= C_vds(end)/ (L* (Vds(t)-Vds(t-1))/(time(t)-time(t-1)));

end


%%

%%
figure();
plot(Vds(15:t_final),C_vds(14:end)*1e12','LineWidth',3);
xlabel("Vds")
ylabel("C_vds)")
title("Capacitance(pF)");











