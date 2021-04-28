clc; clear;
%Estimates Wing loading (W/S) for three different constraints

%Constants:

rho = .001756;          %air density at TO (slug/ft^3) (std. atm. 10,000 ft)
rho0 = .002377;         %air density at sea level (slug/ft^3) (Std. Atm.)
CLmax = 2.5;            %Max takeoff lift coefficient estimated from Raymer fig. 5.3
CL_TO = CLmax/1.21;     %Actual takeoff lift coefficient used in W/S calcs
TOP = 100;              %Takeoff parameter estimated from Raymer fig 5.4
sigma = rho/rho0;       %Air density ratio
T_W_to = .4367;         %Thrust to weight ratio at TO
Vstall = 150;           %Stall speed in ft/s based on YAK-130


%Raymer Eq. 5.6
%Uses stall condition to estimate W/S
W_S_stall = .5*rho*Vstall^2*CLmax

%Raymer Eq. 5.9
%Uses takeoff condition to estimate W/S
W_S_takeoff = TOP*sigma*CL_TO*T_W_to

%Raymer Eq. 5.11
%Uses landing condition to estimate W/S
W_S_landing = (4000-(50/tan(3*pi/180)))*sigma*CLmax/80

%convert back to takeoff conditions for comparison 
%divide by ratio of landing weight to TO weight
r=.7765;
W_S_landing_adjusted = W_S_landing/r


