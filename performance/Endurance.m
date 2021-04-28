clc; clear; 

%% Variables 

Wf = 20171; %final weight 

Wi = 24066; %initial weight 

C = 0.975; %specific fuel consumption 

K = 0.0398-; %drag due to lift factor 

Cdo = 0.006-; %zero lift coefficient of drag 

%% Equations 

Cl = sqrt(Cdo/K); %Cl for min drag/thrust (optimize for largest L/D) 

L = Cl; 

D = Cdo+K*Cl^2; 

E = (L/D)*(1/C)*log(Wi/Wf) %units [hours] 
