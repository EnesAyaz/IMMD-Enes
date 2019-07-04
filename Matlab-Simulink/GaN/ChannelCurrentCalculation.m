function [Ich] = ChannelCurrentCalculation(Vgs,Vds) %Vgin,Vdin,Vsin
Vgd = Vgs - Vds;
cur = 4.5057; % To be updated
K = cur * 0.8 * (273/300)^(-2.7);
x0 = 0.31 ;
x1 = 0.255;
slp = 2;
if Vds>=0
            Ich = K*log(1+exp(26*(Vgs-1.7)/slp))*(Vds)/(1+max((x0+x1*(Vgs+4.1)),0.2)*Vds);
else
            Ich = -K*log(1+exp(26*(Vgd-1.7)/slp))*(-Vds)/(1+max((x0+x1*(Vgd+6.1)),0.2)*(-Vds));
end
