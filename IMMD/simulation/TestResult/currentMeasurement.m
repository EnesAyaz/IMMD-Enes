%%
clear;
clc;
%%
case1name= ' M4 - PH C';
case2name=strcat(case1name,'00000');
directory='C:\Users\enes_\Desktop\Research League- Fall\Deneyler\Enes Furkan - Akým Ölcümleri';
name='\C10A - GD Analog Output-';
name=strcat(directory,name,case2name,'.dat');
data=load(name);
time=data(:,1);
current=data(:,2);
%% 
fig=figure;
subplot(2,1,1)
plot(time,current)
grid on;
set(gca,'FontSize',14);
xlabel('Time(s)','FontSize',14,'FontWeight','Bold')
ylabel('Current(A)','FontSize',14,'FontWeight','Bold')
title(strcat(case1name,'(Zoom In)'));
subplot(2,1,2)
plot(time,current);
grid on;
set(gca,'FontSize',14);
xlabel('Time(s)','FontSize',14,'FontWeight','Bold')
ylabel('Current(A)','FontSize',14,'FontWeight','Bold')
title(strcat(case1name,'(Zoom Out)'));
ylim([0 3]);

%%
namefig='C:\Users\enes_\Desktop\Research League- Fall\Summer2019\IMMD\simulation\TestResult\Images\';
case1name=case1name(~isspace(case1name));
namefig=strcat(namefig,case1name,'.png');
saveas(fig,namefig);