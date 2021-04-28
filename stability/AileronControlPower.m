clc; clear; 

  

% Sadraey Method 

CLaw = 4.693/50; % Wing sectional lift curve slope [1/rad-ft] 

tau  = 0.48; % Aileron effectiveness parameter (depends on aileron-to-wing chord ratio) 

Cr   = 9;  % Wing root chord [ft] 

S    = 312.5; % Wing surface area [ft^2] 

b    = 50; % Wingspan [ft] 

yi   = 15; % Inboard aileron distance from fuselage centerline [ft] 

yo   = 25; % Outboard aileron distance from fuselage centerline [ft] 

lambda = 0.389; % Taper ratio 

  

Sratio = 46/312.5; % Ratio of aileron-to-wing surface areas 

hsweep = deg2rad(4); % Sweep at hinge line of aileron [rad] 

Kf = 0.9;         % Correction factor for lift increment due to aileron 

Clairfoildf = 4.1; % Airfoil lift increment due to aileron deflection [1/rad] 

CLdf = 0.9*Kf*Clairfoildf*Sratio*cos(hsweep); % Wing lift increment due to aileron deflection [1/rad] 

Cldfspan = CLdf/b; % Wing lift increment per unit span due to aileron deflection [1/rad-ft] 

  

% Strip method to estimate aileron control power as laid out in Raymer's 

% textbook. This analysis separates the aileron into 6 sections. 

Yi = linspace(190,290,6); % Each section's distance from fuselage centerline 

Lleft  = [67.5, 62.1, 59.4, 55.35, 49.55, 44.55]/12; 

Lright = [62.1, 59.4, 55.35, 49.55, 44.55, 42.00]/12; 

% Chord lengths at various sections [ft] 

Si     = (Lleft+Lright)*20/12*0.5; % Area of each section [ft^2] 

YS     = sum(Si.*Yi); % Sum of Si*Yi 

Claileron = 2*YS*Kf*Cldfspan*cos(hsweep)/(S*b) 

% Aileron control power using Raymer's method. 

  

Clbw  = -0.0516; % Wing contribution to roll moment derivative due to sideslip 

Clbvt  = -0.0271; % Vertical tail contribution to roll moment derivative due to sideslip 

B     = deg2rad(11.5); % Sideslip of 11.5 deg to check aileron control authority 

TotalClb = Clbw + Clbvt  

% Total roll moment derivative due to sideslip. For a military jet, a value 

% between -0.1 and 0 is desired, as this implies that the aircraft is laterally 

% stable. 

  

aildef = deg2rad(20); 

B      = deg2rad(11.5); % Sideslip of 11.5 deg to check aileron control authority 

RollMomDer = Clbw*B + Clbvt*B + Claileron*aildef; 

% Total roll moment derivative to check aileron control authority. 
