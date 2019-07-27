%% Induced Voltage
% Unbalance in dc link voltage
% Ef's are different

%%
% Trivial ma and delta calculation
Vdc = 540; % Volts
fout = 50; % Hz
wout = 2*pi*fout; % rad/sec
m = 3;
np = 1;
ns = 2;
n = ns*np;
Ls = 10e-3; % Henries
Rs = 1e-3; % Ohms
Xs = wout*Ls; % Ohms

Ef1A = 80;
Ef1B = Ef1A;
Ef1C = Ef1A;
Ef2A = 40:120;
Ef2B = Ef2A;
Ef2C = Ef2A;

Ef1A_ph = 0;
Ef1B_ph = Ef1A_ph - 120;
Ef1C_ph = Ef1A_ph + 120;
Ef2A_ph = 0;
Ef2B_ph = Ef2A_ph - 120;
Ef2C_ph = Ef2A_ph + 120;

Ef1_avg = Ef1A;
Ef2_avg = Ef2A;

Poutm1 = 2e3;
Is1 = Poutm1/(Ef1_avg*m);
Vdrop1 = Is1*Xs; % Volts
Vt1 = sqrt(Ef1_avg^2+Vdrop1^2); % Volts
Vdcm1 = Vdc/ns; % volts
ma1 = Vt1*sqrt(3)/(Vdcm1*0.612);
delta1 = acos(Ef1_avg/Vt1); % radians
deltad1 = delta1*180/pi; % degrees
pf1 = cos(delta1);
Soutm1 = Poutm1/pf1;
Qoutm1 = sqrt(Soutm1^2-Poutm1^2);

Poutm2 = 2e3;
Is2 = Poutm2./(Ef2_avg*m);
Vdrop2 = Is2*Xs; % Volts
Vt2 = sqrt(Ef2_avg.^2+Vdrop2.^2); % Volts
Vdcm2 = Vdc/ns; % volts
ma2 = Vt2*sqrt(3)/(Vdcm2*0.612);
delta2 = acos(Ef2_avg./Vt2); % radians
deltad2 = delta2*180/pi; % degrees
pf2 = cos(delta2);
Soutm2 = Poutm2./pf2;
Qoutm2 = sqrt(Soutm2.^2-Poutm2.^2);

num = numel(ma2);


%%
figure;
hold all;
plot(Ef2_avg/Ef1_avg,ma2,'b--','Linewidth',2);
plot(Ef2_avg/Ef1_avg,delta2/delta1,'r--','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Ef2/Ef1','FontSize',14,'FontWeight','Bold')
ylabel('ratio','FontSize',14,'FontWeight','Bold')
xlim([0.4 1.6]);
%ylim([0.6 1.4]);
legend('ma2/ma1','delta2/delta1');
legend({'ma2/ma1','delta2/delta1'},'Location','best');

%%
figure;
hold all;
plot(Ef2_avg/Ef1_avg,ma1*ones(1,num),'b-','Linewidth',2);
plot(Ef2_avg/Ef1_avg,ma2,'r-','Linewidth',2);
plot(Ef2_avg/Ef1_avg,ones(1,num),'k--','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Ef2/Ef1','FontSize',14,'FontWeight','Bold')
ylabel('ratio','FontSize',14,'FontWeight','Bold')
xlim([0.4 1.6]);
%ylim([0.6 1.4]);
legend({'ma1','ma2','Limit'},'Location','best');

%%
figure;
hold all;
plot(Ef2_avg/Ef1_avg,deltad1*ones(1,num),'b-','Linewidth',2);
plot(Ef2_avg/Ef1_avg,deltad2,'r-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Ef2/Ef1','FontSize',14,'FontWeight','Bold')
ylabel('delta','FontSize',14,'FontWeight','Bold')
xlim([0.4 1.6]);
%ylim([0.6 1.4]);
legend({'delta1','delta2'},'Location','best');

%%
figure;
%hold all;
plot(Ef2_avg/Ef1_avg,pf1*ones(1,num),'r-','Linewidth',2);
hold on;
plot(Ef2_avg/Ef1_avg,pf2,'b-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Ef2/Ef1','FontSize',14,'FontWeight','Bold')
ylabel('pf','FontSize',14,'FontWeight','Bold')
xlim([0.4 1.6]);
ylim([0.5 1.1]);
legend({'pf1','pf2'},'Location','best');

%%
figure;
%hold all;
plot(Ef2_avg/Ef1_avg,Is1*ones(1,num),'r-','Linewidth',2);
hold on;
plot(Ef2_avg/Ef1_avg,Is2,'b-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Ef2/Ef1','FontSize',14,'FontWeight','Bold')
ylabel('Is','FontSize',14,'FontWeight','Bold')
xlim([0.4 1.6]);
%ylim([2 18]);
legend({'Is1','Is2'},'Location','best');

%%
figure;
%hold all;
plot(Ef2_avg/Ef1_avg,Qoutm1*ones(1,num),'r-','Linewidth',2);
hold on;
plot(Ef2_avg/Ef1_avg,Qoutm2,'b-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Ef2/Ef1','FontSize',14,'FontWeight','Bold')
ylabel('Q','FontSize',14,'FontWeight','Bold')
xlim([0.4 1.6]);
%ylim([2 18]);
legend({'Q1','Q2'},'Location','best');

%%
% For a given Ef unbalance, calculate the effect of 
% varying ma and delta
Vdc = 540; % Volts
fout = 50; % Hz
wout = 2*pi*fout; % rad/sec
m = 3;
np = 1;
ns = 2;
n = ns*np;
Ls = 10e-3; % Henries
Rs = 1e-3; % Ohms
Xs = wout*Ls; % Ohms

Ef1A = 80;
Ef1B = Ef1A;
Ef1C = Ef1A;
Ef2A = 80;
Ef2B = Ef2A;
Ef2C = Ef2A;

Ef1A_ph = 0;
Ef1B_ph = Ef1A_ph - 120;
Ef1C_ph = Ef1A_ph + 120;
Ef2A_ph = 0;
Ef2B_ph = Ef2A_ph - 120;
Ef2C_ph = Ef2A_ph + 120;

Ef1_avg = Ef1A;
Ef2_avg = Ef2A;

Poutm1 = 2e3;
Is1 = Poutm1/(Ef1_avg*m);
Vdrop1 = Is1*Xs; % Volts
Vt1 = sqrt(Ef1_avg^2+Vdrop1^2); % Volts
Vdcm1 = Vdc/ns; % volts
ma1 = Vt1*sqrt(3)/(Vdcm1*0.612);
delta1 = acos(Ef1_avg/Vt1); % radians
deltad1 = delta1*180/pi; % degrees
pf1 = cos(delta1);
Soutm1 = Poutm1/pf1;
Qoutm1 = sqrt(Soutm1^2-Poutm1^2);

Poutm2 = 2e3;
Vdcm2 = Vdc/ns; % volts
ma2 = 0.5:0.01:1;
ma2 = ma2';
Vt2 = Vdcm2*0.612*ma2/sqrt(3);
sin_delta2 = Xs*Poutm2./(3*Vt2*Ef2_avg);
delta2 = asin(sin_delta2);
deltad2 = delta2*180/pi; % degrees
Qoutm2 = 3*Vt2.*(Vt2-Ef2_avg).*cos(delta2)/Xs;
Soutm2 = sqrt(Poutm2^2+Qoutm2.^2);
Is2 = Soutm2./(3*Vt2);
pf2 = Poutm2./Soutm2;

num = numel(ma2);

%%
figure;
hold all;
plot(ma2,deltad2,'b-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('ma2','FontSize',14,'FontWeight','Bold')
ylabel('delta2','FontSize',14,'FontWeight','Bold')
xlim([0.49 1.01]);
ylim([0 40]);

%%
figure;
hold all;
plot(ma2,Poutm2*ones(1,num),'b-','Linewidth',2);
plot(ma2,Qoutm2,'r-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('ma2','FontSize',14,'FontWeight','Bold')
ylabel('Powers','FontSize',14,'FontWeight','Bold')
xlim([0.49 1.01]);
ylim([-2500 2500]);
legend({'Pout','Qout'},'Location','best');

%%
figure;
plot(ma2,pf2,'b-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('ma2','FontSize',14,'FontWeight','Bold')
ylabel('pf','FontSize',14,'FontWeight','Bold')
xlim([0.49 1.01]);
ylim([0.7 1.1]);

%%
figure;
plot(ma2,Is2,'b-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('ma2','FontSize',14,'FontWeight','Bold')
ylabel('Is','FontSize',14,'FontWeight','Bold')
xlim([0.49 1.01]);
ylim([0 18]);


%%
% Variations from ratio
Vdc = 540; % Volts
fout = 50; % Hz
wout = 2*pi*fout; % rad/sec
m = 3;
np = 1;
ns = 2;
n = ns*np;
Ls = 10e-3; % Henries
Rs = 1e-3; % Ohms
Xs = wout*Ls; % Ohms

Ef1A = 80;
Ef2A = 50:110;
Ef1_avg = Ef1A;
Ef2_avg = Ef2A;

num1 = numel(Ef2_avg);

Poutm1 = 2e3;
Is1 = Poutm1/(Ef1_avg*m);
Vdrop1 = Is1*Xs; % Volts
Vt1 = sqrt(Ef1_avg^2+Vdrop1^2); % Volts
Vdcm1 = Vdc/ns; % volts
ma1 = Vt1*sqrt(3)/(Vdcm1*0.612);
delta1 = acos(Ef1_avg/Vt1); % radians
deltad1 = delta1*180/pi; % degrees
pf1 = cos(delta1);
Soutm1 = Poutm1/pf1;
Qoutm1 = sqrt(Soutm1^2-Poutm1^2);

Vdcm2 = Vdc/ns; % volts
ma2_sin_delta2 = ma1*sin(delta1)*Ef1_avg./Ef2_avg';
ma2_var = 0.5:0.01:1;
num2 = numel(ma2_var);
delta2_var = zeros(num1,num2);
Qoutm2_var = zeros(num1,num2);
Is2_var = zeros(num1,num2);
pf2_var = zeros(num1,num2);
for k = 1:num1
    for l = 1:num2
        delta2_var(k,l) = asin( (Ef1_avg./Ef2_avg(k)).*(ma1./ma2_var(l))*sin(delta1) ) * 180/pi;
        Vt2 = Vdcm2*0.612*ma2_var(l)/sqrt(3);
        Poutm2 = 3*Vt2*Ef2_avg(k)*sin(delta2_var(k,l)*pi/180)/Xs;
        Qoutm2_var(k,l) = 3*(Vt2^2-Vt2*Ef2_avg(k)*cos(delta2_var(k,l)*pi/180))/Xs;
        Soutm2 = sqrt(Poutm2^2+Qoutm2_var(k,l)^2);
        Is2_var(k,l) = Soutm2/(3*Vt2);
        pf2_var(k,l) = Poutm2/Soutm2;
    end
end

ma2_plot = zeros(num1,num2);
Ef2_plot = zeros(num1,num2);
for k = 1:num1
    for l = 1:num2
        ma2_plot(k,l) = ma2_var(l);
        Ef2_plot(k,l) = Ef2_avg(k);
    end
end

%%
figure;
surf(Ef2_plot,ma2_plot,delta2_var)
%mesh(Ef2_plot,ma2_plot,delta2_var)
xlabel('Ef2','FontSize',14,'FontWeight','Bold')
zlabel('delta2','FontSize',14,'FontWeight','Bold')
ylabel('ma2','FontSize',14,'FontWeight','Bold')
set(gca,'XDir','reverse','YDir','reverse','FontSize',13);

%%
figure;
%surf(Ef2_plot,ma2_plot,Qoutm2_var)
mesh(Ef2_plot,ma2_plot,Qoutm2_var)
xlabel('Ef2','FontSize',14,'FontWeight','Bold')
zlabel('Q2','FontSize',14,'FontWeight','Bold')
ylabel('ma2','FontSize',14,'FontWeight','Bold')
set(gca,'XDir','reverse','YDir','reverse','FontSize',13);
%set(gca,'FontSize',13);

%%
figure;
%surf(Ef2_plot,ma2_plot,Is2_var)
mesh(Ef2_plot,ma2_plot,Is2_var)
xlabel('Ef2','FontSize',14,'FontWeight','Bold')
zlabel('Is2','FontSize',14,'FontWeight','Bold')
ylabel('ma2','FontSize',14,'FontWeight','Bold')
set(gca,'XDir','reverse','YDir','reverse','FontSize',13);
%set(gca,'FontSize',13);

%%
figure;
%surf(Ef2_plot,ma2_plot,pf2_var)
mesh(Ef2_plot,ma2_plot,pf2_var)
xlabel('Ef2','FontSize',14,'FontWeight','Bold')
zlabel('pf2','FontSize',14,'FontWeight','Bold')
ylabel('ma2','FontSize',14,'FontWeight','Bold')
set(gca,'XDir','reverse','YDir','reverse','FontSize',13);
%set(gca,'FontSize',13);

%%
pf2_max = zeros(1,num1);
ma2_pf2_max = zeros(1,num1);
delta2_pf2_max = zeros(1,num1);

for k = 1:num1
    for l = 1:num2      
        if (pf2_var(k,l) > pf2_max(k)) 
            pf2_max(k) = pf2_var(k,l);
            ma2_pf2_max(k) = ma2_var(l);
            delta2_pf2_max(k) = delta2_var(k,l);
        end
    end
end

%%
figure;
plot(Ef2_avg/Ef1_avg,pf2_max,'b-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Ef2/Ef1','FontSize',14,'FontWeight','Bold')
ylabel('pf max','FontSize',14,'FontWeight','Bold')
%xlim([0.49 1.01]);
ylim([0.8 1.02]);

%%
figure;
plot(Ef2_avg/Ef1_avg,ma2_pf2_max,'b-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Ef2/Ef1','FontSize',14,'FontWeight','Bold')
ylabel('ma2 for pf max','FontSize',14,'FontWeight','Bold')
%xlim([0.49 1.01]);
ylim([0.4 1.1]);

%%
figure;
plot(Ef2_avg/Ef1_avg,delta2_pf2_max,'b-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Ef2/Ef1','FontSize',14,'FontWeight','Bold')
ylabel('delta2 for pf max','FontSize',14,'FontWeight','Bold')
%xlim([0.49 1.01]);
ylim([0 70]);

%%
figure;
hold all;
plot(Ef2_avg/Ef1_avg,delta2_pf2_max*pi/180,'b-','Linewidth',2);
plot(Ef2_avg/Ef1_avg,ma2_pf2_max,'r-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('Ef2/Ef1','FontSize',14,'FontWeight','Bold')
ylabel('delta2 and ma2 for pf max','FontSize',14,'FontWeight','Bold')
legend({'delta2 (rad)','ma2'},'Location','best');
ylim([0 1.2]);
