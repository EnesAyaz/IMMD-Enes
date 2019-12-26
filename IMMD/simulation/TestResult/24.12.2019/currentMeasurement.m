%%
clear;
clc;
%%
case1name= 'C1Series - ';
% case2name=strcat(case1name,'No Interleaving - ');
directory='D:\Github\IMMD-Enes\IMMD\simulation\TestResult\24.12.2019\Agilent';
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