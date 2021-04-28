clc; clear; 
 

% Key parameters 
Kdw     = 1.0; % 1.0 if no delta-wing 
Kvs     = 1.0; % 1.0 if no variable sweep wing 
Wdg     = 25333 - 0.5*6906; % Flight design gross weight (60% of internal fuel) 
Nz      = 1.5*9.0; % Ultimate load factor 
Sw      = 312.5; % Wing area [ft^2] 
A       = 8; % Aspect ratio 
tcroot  = 0.097; % Thickness-to-chord ratio at wing root [%] 
lambda  = 0.389; % Taper ratio 
sweep   = deg2rad(12.02); % Wing sweep @ 25% MAC [rad] 
Scsw    = 154.1; % Wing control surface area [ft^2]  
Nen     = 2; % Number of engines 
Lec     = 14.583; % Routing distance from engine front to cockpit x 2 [ft]  
Te      = 5950; % Thrust per engine [lb] 
Vt      = 1084.68; % Total fuel volume [gal] 
Vi      = 0; % Integral tank volume [gal] 
Vp      = 1084.68; % Self-sealing tank volume [gal] 
T       = Te*Nen; % Total available thrust [lb] 
SFC     = 0.78; % specific fuel consumption (chosen at cruise) 
Nt      = 4;  % Number of fuel tanks 
M       = 0.8; % Design maximum Mach number 
Scs     = 181.1; % Total area of control surfaces [ft^2]  
Ns      = 8; % Number of flight control systems  
Nc      = 2; % Number of crew 
Nci     = 1.2; % Number of equivalent crew 
Kvsh    = 1.0; % 1.0 if not variable sweep wing 
Nu      = 10; % Number of hydraulic utility functions (typically 5 - 15) 
Kmc     = 1; % 1.45 if mission completion required after failure 
Rkva    = 135; % System electrical rating [kV-A] (typically 110-160)  
La      = 28.93; % Electrical routing distance from generators to avionics to cockpit [ft]  
Ngen    = 2; % Number of generators 
Wuav    = 765; % Uninstalled avionics weight [lb] (typically 800-1400)  

% Weight Estimations of Various Components [lbm (pound-mass)] 
wing       = 0.0103*Kdw*Kvs*(Wdg*Nz)^0.5*(Sw^0.622)*(A^0.785)*tcroot^(-0.4)*(1+lambda)^0.05*(cos(sweep))^(-1.0)*Scsw^0.04*0.85 
% Fudge factor 0.85 as the wing is almost entirely made of composites 
engcont    = 10.5*Nen^1.008*Lec^0.222 % Engine controls 
starter    = 0.025*Te^0.760*Nen^0.72  % Pneumatic starter 
fuel       = 7.45*Vt^0.47*(1+Vi/Vt)^-0.095*(1+Vp/Vt)*Nt^0.066*Nen^0.052*((T*SFC)/1000)^0.249 % Fuel system and tanks 
flicont    = 36.28*M^0.003*Scs^0.489*Ns^0.484*Nc^0.127 % Flight controls 
instr      = 8.0+36.37*Nen^0.676*Nt^0.237+26.4*(1+Nci)^1.356 % Instruments 
hydr       = 37.23*Kvsh*Nu^0.664 % Hydraulics 
elec       = 172.2*Kmc*Rkva^0.152*Nc^0.10*La^0.10*Ngen^0.091 % Electrical 
avio       = 2.117*Wuav^0.933 % Avionics 
furn       = 217.6*Nc % Furnishings 
ac_antiice = 201.6*((Wuav+200*Nc)/1000)^0.735 % Air-conditioning and anti-ice 
handgear   = 3.2*10^-4*Wdg 
