
figure(1);
title('Channel Current vs Drain-Source Voltage with varying Gate-Source ')
for Vgs=-3:1:7
    Ich=[];
    for Vds=-10:0.1:10
        Ich= [Ich,ChannelCurrentCalculation(Vgs,Vds)];
    end
    hold on;
    Vds=-10:0.1:10;
    plot(Vds,Ich,'LineWidth',5); 
    axis='equal';
    grid on;
    grid minor;
   

end 
legend("Vgs=-3","Vgs=-2","Vgs=-1","Vgs=0","Vgs=1","Vgs=2", ...
    "Vgs=3","Vgs=4","Vgs=5","Vgs=6","Vgs=7");