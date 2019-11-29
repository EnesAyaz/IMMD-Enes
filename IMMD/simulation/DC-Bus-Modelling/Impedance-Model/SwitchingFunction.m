
% output frequency, switching frequemcy, output phase, carrier phase,
% modulation index

% for cosine function is zero 
function [frequency,magnitude]= SwitchingFunction(f_o,f_s,The_o,The_c,k)
The_o=The_o+pi/2; 
m_l=10;
n_l=10;
frequency=[];
magnitude=[];
w_c=2*pi*f_s;
w_o=2*pi*f_o;
frequency= [frequency 0];
magnitude =[magnitude 1/2];

frequency= [frequency f_o];
magnitude =[magnitude k];

for m=1:m_l
    for n= -n_l:n_l
        
         freq= m*f_s+n*f_o;
        
         mag=  (2/(m*pi))*sin((m+n)*pi/2)*...
                besselj(n,m*k*pi/2)*...
                exp(-1i*(m*The_c*+n*The_o));
          
          
        frequency= [frequency freq];
        
        magnitude =[magnitude mag ];
           
                
       
        
        
    end
end



 
end