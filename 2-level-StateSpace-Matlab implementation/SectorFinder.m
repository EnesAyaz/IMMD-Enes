function v=SectorFinder(t_s,...
    sampleTime,switching_interval,...
    angle,alfa,beta,V_dc);
Ta=0;
Tb=0;

Vo1=[0;0;0];
Va=[0;0;0];
Vb=[0;0;0];
Vo2=[0;0;0];
%Sector 1
if(angle>0 && angle<pi/3)
   Ta= (3*alfa/4 -sqrt(3)*beta/4)...
       *t_s/V_dc;
   Tb=(sqrt(3)*beta/2)*t_s/V_dc;
   
   Vo1=[0;0;0];
   Va=[1;0;0];
   Vb=[1;1;0];
   Vo2=[1;1;1];
    
end


%Sector 2

if(angle>pi/3 && angle<2*pi/3)
    Ta= (3*alfa/4 +sqrt(3)*beta/4)...
        *t_s/V_dc;
    Tb= (-3*alfa/4 +sqrt(3)*beta/4)...
        *t_s/V_dc;
    
   Vo2=[0;0;0];
   Va=[1;1;0];
   Vb=[0;1;0];
   Vo1=[1;1;1];
    
    
end

%Sector 3

if(angle>2*pi/3 && angle<pi)
    Ta=(sqrt(3)*beta/2)*t_s/V_dc;
    Tb= (-3*alfa/4 -sqrt(3)*beta/4)...
        *t_s/V_dc; 
    
   Vo1=[0;0;0];
   Va=[0;1;0];
   Vb=[0;1;1];
   Vo2=[1;1;1];
    
end

%Sector 4
if(angle<-pi && angle<-2*pi/3)
    Ta= (-3*alfa/4 +sqrt(3)*beta/4)...
        *t_s/V_dc;
     Tb=(-sqrt(3)*beta/2)*t_s/V_dc;
      
    Vo2=[0;0;0];
    Va=[0;1;1];
    Vb=[0;0;1];
    Vo1=[1;1;1];
    
     
end
%Sector 5

if(angle>-2*pi/3 && angle<-pi/3)
      Ta= (-3*alfa/4 -sqrt(3)*beta/4)...
        *t_s/V_dc;
      Tb= (3*alfa/4 -sqrt(3)*beta/4)...
        *t_s/V_dc;
    
   Vo1=[0;0;0];
   Va=[0;0;1];
   Vb=[1;0;1];
   Vo2=[1;1;1];
    
    
    
end

%Sector 6

if(angle>-pi/3 && angle<0)
    Ta=(-sqrt(3)*beta/2)*t_s/V_dc;
    Tb= (+3*alfa/4 +sqrt(3)*beta/4)...
        *t_s/V_dc;
    
    Vo2=[0;0;0];
    Va=[1;0;1];
    Vb=[1;0;0];
    Vo1=[1;1;1];
         
end

Ta_sample= int64(Ta/sampleTime);
Tb_sample= int64(Tb/sampleTime);

T_o=switching_interval...
    -Ta_sample-Tb_sample;

T_o=T_o/4;
Ta_sample= int64(Ta_sample/2);
Tb_sample= int64(Tb_sample/2);


v=[];
for k=1:switching_interval
    if k<T_o
        v= [v,Vo1];
    else if T_o+Ta_sample>k
        v=[v, Va];
        else if T_o+Ta_sample...
                    +Tb_sample>k
        v=[v, Vb];
            else if 3*T_o+...
             Ta_sample+Tb_sample>k
        v=[v, Vo2];
        
                else if 3*T_o+...
             Ta_sample...
             +2*Tb_sample>k
         v=[v, Vb];
                    else if 3*T_o...
             +2*Ta_sample...
             +2*Tb_sample>k
                v=[v, Va];
                        else 
                        v=[v, Vo1];     
                                
                        end
    
                    end

                end
            end
        end
    end
end
    
end
