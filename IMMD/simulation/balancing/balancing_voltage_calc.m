% Different Rload
R1 = 10; % Ohm
L1 = 20e-3; % H
R2 = 2:0.1:20; % Ohm
%R2 = 12; % Ohm
L2 = 20e-3; % H
Vdc = 540; % V
fout = 50; % Hz
X1 = 2*pi*fout*L1; % Ohm
X2 = 2*pi*fout*L2; % Ohm
Z1 = sqrt(R1^2+X1^2); % Ohm
Z2 = sqrt(R2.^2+X2^2); % Ohm
pf1 = R1/Z1;
pf2 = R2./Z2;

% If ma's are corrected
ratioma = sqrt(R1./R2).*(pf2/pf1);
ma1 = 0.9;
ma2 = ma1*ratioma;
Vdc1 = Vdc/2;
Vdc2 = Vdc1;
V1 = 0.612*ma1*Vdc1/sqrt(3);
I1 = V1/Z1;
S1 = 3*V1*I1;
P1 = S1*pf1;
V2 = 0.612*ma2*Vdc2/sqrt(3);
I2 = V2./Z2;
S2 = 3*V2.*I2;
P2 = S2.*pf2;

figure;
hold all;
plot(R2/R1,ma2,'r-','Linewidth',2);
plot(R2/R1,ma1*ones(numel(ma2)),'b-','Linewidth',2);
plot(R2/R1,ones(numel(ma2)),'k--','Linewidth',2);
set(gca,'FontSize',14);
xlabel('R2/R1','FontSize',14,'FontWeight','Bold')
ylabel('ma','FontSize',14,'FontWeight','Bold')
xlim([0 2.1]);
ylim([0.5 1.1]);
legend({'ma2','ma1','Limit'},'Location','best');

%%
figure;
hold all;
plot(R2/R1,ma2/ma1,'k--','Linewidth',2);
set(gca,'FontSize',14);
xlabel('R2/R1','FontSize',14,'FontWeight','Bold')
ylabel('ma2/ma1','FontSize',14,'FontWeight','Bold')
xlim([0 2.1]);
ylim([0.5 1.2]);

%%
figure;
hold all;
plot(R2/R1,pf1*ones(numel(ma2)),'r-','Linewidth',2);
plot(R2/R1,pf2,'b-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('R2/R1','FontSize',14,'FontWeight','Bold')
ylabel('pf','FontSize',14,'FontWeight','Bold')
xlim([0 2.1]);
ylim([0 1.1]);
legend({'pf1','pf2'},'Location','best');

%%
% Different Lload
R1 = 10; % Ohm
L1 = 20e-3; % H
R2 = 10; % Ohm
L2 = (2:0.1:40)*1e-3; % H
%L2 = 20e-3; % H
Vdc = 540; % V
fout = 50; % Hz
X1 = 2*pi*fout*L1; % Ohm
X2 = 2*pi*fout*L2; % Ohm
Z1 = sqrt(R1^2+X1^2); % Ohm
Z2 = sqrt(R2.^2+X2.^2); % Ohm
pf1 = R1/Z1;
pf2 = R2./Z2;

% If ma's are corrected
ratioma = sqrt(R1./R2).*(pf2/pf1);
ma1 = 0.8;
ma2 = ma1*ratioma;
Vdc1 = Vdc/2;
Vdc2 = Vdc1;
V1 = 0.612*ma1*Vdc1/sqrt(3);
I1 = V1/Z1;
S1 = 3*V1*I1;
P1 = S1*pf1;
V2 = 0.612*ma2*Vdc2/sqrt(3);
I2 = V2./Z2;
S2 = 3*V2.*I2;
P2 = S2.*pf2;

%%
figure;
hold all;
plot(L2/L1,ma2,'r-','Linewidth',2);
plot(L2/L1,ma1*ones(numel(ma2)),'b-','Linewidth',2);
plot(L2/L1,ones(numel(ma2)),'k--','Linewidth',2);
set(gca,'FontSize',14);
xlabel('L2/L1','FontSize',14,'FontWeight','Bold')
ylabel('ma','FontSize',14,'FontWeight','Bold')
xlim([0 2.1]);
ylim([0.5 1.1]);
legend({'ma2','ma1','Limit'},'Location','best');

%%
figure;
hold all;
plot(L2/L1,ma2/ma1,'k--','Linewidth',2);
set(gca,'FontSize',14);
xlabel('L2/L1','FontSize',14,'FontWeight','Bold')
ylabel('ma2/ma1','FontSize',14,'FontWeight','Bold')
xlim([0 2.1]);
ylim([0.5 1.2]);

%%
figure;
hold all;
plot(L2/L1,pf1*ones(numel(ma2)),'r-','Linewidth',2);
plot(L2/L1,pf2,'b-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('L2/L1','FontSize',14,'FontWeight','Bold')
ylabel('pf','FontSize',14,'FontWeight','Bold')
xlim([0 2.1]);
ylim([0 1.1]);
legend({'pf1','pf2'},'Location','best');


%%
% Different Zload
R1 = 10; % Ohm
L1 = 20e-3; % H
R2 = 7:0.1:13; % Ohm
%R2 = 10; % Ohm
L2 = (14:0.2:26)*1e-3; % H
%L2 = 20e-3; % H
Vdc = 540; % V
fout = 50; % Hz
X1 = 2*pi*fout*L1; % Ohm
X2 = 2*pi*fout*L2; % Ohm
Z1 = sqrt(R1^2+X1^2); % Ohm
Z2 = sqrt(R2.^2+X2.^2); % Ohm
pf1 = R1/Z1;
pf2 = R2./Z2;

% If ma's are corrected
ratioma = sqrt(R1./R2).*(pf2/pf1);
ma1 = 0.8;
ma2 = ma1*ratioma;
Vdc1 = Vdc/2;
Vdc2 = Vdc1;
V1 = 0.612*ma1*Vdc1/sqrt(3);
I1 = V1/Z1;
S1 = 3*V1*I1;
P1 = S1*pf1;
V2 = 0.612*ma2*Vdc2/sqrt(3);
I2 = V2./Z2;
S2 = 3*V2.*I2;
P2 = S2.*pf2;

%%
figure;
hold all;
plot(L2/L1,ma2,'r-','Linewidth',2);
plot(L2/L1,ma1*ones(numel(ma2)),'b-','Linewidth',2);
plot(L2/L1,ones(numel(ma2)),'k--','Linewidth',2);
set(gca,'FontSize',14);
xlabel('L2/L1,R2/R1','FontSize',14,'FontWeight','Bold')
ylabel('ma','FontSize',14,'FontWeight','Bold')
xlim([0.65 1.45]);
ylim([0.5 1.1]);
legend({'ma2','ma1','Limit'},'Location','best');

%%
figure;
hold all;
plot(L2/L1,ma2/ma1,'k--','Linewidth',2);
set(gca,'FontSize',14);
xlabel('L2/L1,R2/R1','FontSize',14,'FontWeight','Bold')
ylabel('ma2/ma1','FontSize',14,'FontWeight','Bold')
xlim([0 2.1]);
ylim([0.5 2]);

%%
figure;
hold all;
plot(L2/L1,pf1*ones(numel(ma2)),'r-','Linewidth',2);
plot(L2/L1,pf2*ones(numel(ma2)),'b-','Linewidth',2);
set(gca,'FontSize',14);
xlabel('L2/L1,R2/R1','FontSize',14,'FontWeight','Bold')
ylabel('pf','FontSize',14,'FontWeight','Bold')
xlim([0 2.1]);
ylim([0 1.1]);
legend({'pf1','pf2'},'Location','best');

%% Unbalance in the voltage (RL load)
R1 = 10; % Ohm
L1 = 20e-3; % H
R2 = 2:0.1:20; % Ohm
%R2 = 12; % Ohm
L2 = 20e-3; % H
Vdc = 540; % V
fout = 50; % Hz
X1 = 2*pi*fout*L1; % Ohm
X2 = 2*pi*fout*L2; % Ohm
Z1 = sqrt(R1^2+X1^2); % Ohm
Z2 = sqrt(R2.^2+X2^2); % Ohm
pf1 = R1/Z1;
pf2 = R2./Z2;

ma1 = 0.9;
ma2 = 0.9;

ratio_R = R2/R1;
ratio_pf = (pf1/pf2)^2;
ratio_ma = (ma1/ma2)^2;
ratio = ratio_ma*ratio_pf*ratio_R;
Vdc1 = Vdc/(ratio+1)
Vdc2 = Vdc-Vdc1
V1 = 0.612*ma1*Vdc1/sqrt(3);
I1 = V1/Z1;
S1 = 3*V1*I1;
P1 = S1*pf1
V2 = 0.612*ma2*Vdc2/sqrt(3);
I2 = V2/Z2;
S2 = 3*V2*I2;
P2 = S2*pf2

