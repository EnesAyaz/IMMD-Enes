%%
%I try to explain harmonics of PWM signal. 
% This code is written in the manner of using sine-triangle modulation with carrier 
% and fundamental frequency ratio is integer. 
% I took the analytical solution from PWM for power converters by Lipo.
%%
% There is two index called as m and n. m is used for carrier harmonics and
% n is used for fundamental harmonics. DC offset is equal to Vdc 
function [f, mag ,ang] = HarmonicOfPWM(ThC,ThF,M,V,f_fund,f_c)
m_final= 20 ; % it determines the final harmonics of carrier
n_final= 10; % it determines the fianl harmonics of fundamental

% ThC=0; % carrier phase
% ThF=+2*pi/3; % fundamental phase , changing for A B C phase 0 -2*pi/3 +2*pi/3

% M= 0.9; % modulation index;
% 
% V=1/2; % 

% f_fund= 50; %  fundamental freq

% f_c= 40000; % carrier freq

%%
size= m_final*(n_final*2+1)+2;
f=zeros(1,size); % frequency of cosinüs
mag=zeros(1,size); % Magnitude of cosinüs
ang=zeros(1,size); % phase of cosinüs

%% DC and fundamental calculation
f(1)= 0;
mag(1)= V;
ang(1)=0;

f(2)=f_fund;
mag(2)=V*M;
ang(2)=ThF;

%% carrier harmonics and sidebands
i=3;
for m=1:m_final
   
    for n=-n_final:n_final
       
       mag(i)=(4*V)*besselj(n,m*pi*M/2)*sin((m+n)*pi/2)/(m*pi);
       
       f(i)=m*f_c+n*f_fund;
       
       ang(i)=mod(m*ThC+n*ThF,2*pi);
       
%        
%        if mag(i)<0
%             ang(i)=m*ThC+n*ThF+pi;
%             ang(i)=mod(m*ThC+n*ThF,2*pi);
%             disp(mag(i));
%             mag(i)=abs(mag(i));
%             disp(f(i));
%        else
%            
%             ang(i)=mod(m*ThC+n*ThF,2*pi);
%            
%        end
        
       i=i+1;       
    end
      
end


%% 
% figure(1)
% 
% stem(f,mag,'b-','Linewidth',1);
% xlabel('Frequency of Cosinüs','FontSize',14,'FontWeight','Bold')
% ylabel('Magnitude of Cosinüs','FontSize',14,'FontWeight','Bold')
% title('Cosine Porjection','FontSize',10,'FontWeight','Bold')
% grid on;
% set(gca,'FontSize',14);

%% cosinüs to jw axis

for i=2:length(mag)
    f=[f -f(i)];
    mag=[mag mag(i)];
    ang= [ang ang(i)];
   
end

%%
% figure(2)
% 
% stem(f,mag,'b-','Linewidth',1);
% xlabel('Frequency of jw','FontSize',14,'FontWeight','Bold')
% ylabel('Magnitude of jw','FontSize',14,'FontWeight','Bold')
% title('Frequency Domain Double Sided','FontSize',10,'FontWeight','Bold')
% grid on;
% set(gca,'FontSize',14);
    

%%  sorting f
[f, s_ind]= sort(f,'ascend');
mag=mag(s_ind);
ang=ang(s_ind);

%%
% fA=f;
% magA=mag;
% angA=ang;
% save('SwitchingFunctionPhaseACos','fA','magA','angA');

%%
% 
% fB=f;
% magB=mag;
% angB=ang;
% save('SwitchingFunctionPhaseBCos','fB','magB','angB');

%%
% fC=f;
% magC=mag;
% angC=ang;
% save('SwitchingFunctionPhaseCCos','fC','magC','angC');
% 
% 
end

