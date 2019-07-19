function [Sa, Sb, Sc] = fcn(Vd,ma,fundf, swf, time)
% this program works for magnitude of Vref is greater then Vd/3 meaning ma
% must be greater than 1/sqrt(3). for smaller ma's computation is a bit
% more tricky therefore it is omitted for simplicity for now. 
Vref = ma*Vd/sqrt(3); %magnitude of Vref
theta = 2*pi*fundf*time; %angle of Vref
angle = mod(theta, 2*pi);
Ts = 1/swf;
Ta = 0;
Tb = 0;
Tc = 0;
T0 = 0;
n=0;
output = 0;
%Sector1 = 0; Sector2 = 0; Sector3 = 0; Sector4= 0; Sector5 = 0; Sector6 = 0;
Sa=0; Sb=0; Sc=0;
timee = mod(time,Ts);



%% Sector 1
if (mod(theta, 2*pi)<=pi/3)&&(mod(theta, 2*pi)>0)  % sector 1
    n = 1;
    thetaprime = angle - (n-1)*pi/3;
    
    Ta = Ts*ma*sin(pi/3-thetaprime);
    Tb = Ts*ma*sin(thetaprime);
    T0 = Ts-Ta-Tb;
    
    times = [T0/4 Ta/2 Tb/2 T0/2 Tb/2 Ta/2 T0/4];
    times = cumsum(times);
    va= [0 1 1 1 1 1 0];
    vb= [0 0 1 1 1 0 0];
    vc= [0 0 0 1 0 0 0];
    
    for j = 1:7            
            if(timee<times(j))
                break
            end
    end
        Sa=va(j); 
        Sb=vb(j); 
        Sc=vc(j); 
end
%% Sector 2
if (mod(theta, 2*pi)<=2*pi/3)&&(mod(theta, 2*pi)>pi/3)  % sector 2
    n = 2;
    thetaprime = angle - (n-1)*pi/3;
    
    Ta = Ts*ma*sin(thetaprime);
    Tb = Ts*ma*sin(pi/3-thetaprime);
    T0 = Ts-Ta-Tb;   
    
    times = [T0/4 Ta/2 Tb/2 T0/2 Tb/2 Ta/2 T0/4];
    times = cumsum(times);
    va= [0 0 1 1 1 0 0];
    vb= [0 1 1 1 1 1 0];
    vc= [0 0 0 1 0 0 0];
    
    for j = 1:7            
            if(timee<times(j))
                break
            end
    end
        Sa=va(j); 
        Sb=vb(j); 
        Sc=vc(j); 
end


%% Sector 3
if (mod(theta, 2*pi)<=pi)&&(mod(theta, 2*pi)>2*pi/3)  % sector 3
    n = 3;
    thetaprime = angle - (n-1)*pi/3;
    
    Ta = Ts*ma*sin(pi/3-thetaprime);
    Tb = Ts*ma*sin(thetaprime);
    T0 = Ts-Ta-Tb;  
    
    times = [T0/4 Ta/2 Tb/2 T0/2 Tb/2 Ta/2 T0/4];
    times = cumsum(times);
    va= [0 0 0 1 0 0 0];
    vb= [0 1 1 1 1 1 0];
    vc= [0 0 1 1 1 0 0];
    
    for j = 1:7            
            if(timee<times(j))
                break
            end
    end
        Sa=va(j); 
        Sb=vb(j); 
        Sc=vc(j);     
end


%% Sector 4
if (mod(theta, 2*pi)<=4*pi/3)&&(mod(theta, 2*pi)>pi)  % sector 4
    n = 4;
    thetaprime = angle - (n-1)*pi/3;
    
    Ta = Ts*ma*sin(thetaprime);
    Tb = Ts*ma*sin(pi/3-thetaprime);
    T0 = Ts-Ta-Tb;
    
    times = [T0/4 Ta/2 Tb/2 T0/2 Tb/2 Ta/2 T0/4];
    times = cumsum(times);
    va = [0 0 0 1 0 0 0];
    vb = [0 0 1 1 1 0 0];
    vc = [0 1 1 1 1 1 0];
    
    for j = 1:7            
            if(timee<times(j))
                break
            end
    end
        Sa=va(j); 
        Sb=vb(j); 
        Sc=vc(j); 
    
end


%% Sector 5 
if (mod(theta, 2*pi)<=5*pi/3)&&(mod(theta, 2*pi)>4*pi/3)  % sector 5
    n = 5;
    thetaprime = angle - (n-1)*pi/3;
    
    Ta = Ts*ma*sin(pi/3-thetaprime);
    Tb = Ts*ma*sin(thetaprime);
    T0 = Ts-Ta-Tb;
    
    times = [T0/4 Ta/2 Tb/2 T0/2 Tb/2 Ta/2 T0/4];
    times = cumsum(times);
    va= [0 0 1 1 1 0 0];
    vb= [0 0 0 1 0 0 0];
    vc= [0 1 1 1 1 1 0];
    
    for j = 1:7            
            if(timee<times(j))
                break
            end
    end
        Sa=va(j); 
        Sb=vb(j); 
        Sc=vc(j); 
    
end


%% Sector 6 
if (mod(theta, 2*pi)<=2*pi)&&(mod(theta, 2*pi)>5*pi/3)  % sector 6
    n = 6;
    thetaprime = angle - (n-1)*pi/3;
    
    Ta = Ts*ma*sin(thetaprime);
    Tb = Ts*ma*sin(pi/3-thetaprime);
    T0 = Ts-Ta-Tb;
    
    times = [T0/4 Ta/2 Tb/2 T0/2 Tb/2 Ta/2 T0/4];
    times = cumsum(times);
    va= [0 1 1 1 1 1 0];
    vb= [0 0 0 1 0 0 0];
    vc= [0 0 1 1 1 0 0];
    
    
    for j = 1:7            
            if(timee<times(j))
                break
            end
    end
        Sa=va(j); 
        Sb=vb(j); 
        Sc=vc(j); 
end



