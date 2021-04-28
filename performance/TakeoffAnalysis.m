clc;clear;

%constants
C_D0 = 0.006; %zero-lift drag coefficient
C_L = 0.159; %lift coefficient at 0 deg angle of attack with 20 deg flap deflection
W = 25333; %aircraft weight (lb)
S = 312; %planform area of wing (ft^2)
V_stall = 200; %stall velocity (ft/s)
V_TO = 1.1*V_stall; %takeoff velocity (ft/s)
V_TR = 1.15*V_stall; %average transition velocity (ft/s)
rho = 0.00199; %air density (slug/ft^3)
T = 11000; %approximate thrust at 70% of V_TO (lb)
g = 32.17; %gravitational acceleration (ft/s)
mu = 0.07; %coefficient of friction
A = 8; %aspect ratio
b = 50; %span
h = 8; %height
h_o = 50; %height of obstacle (ft)
LD = 7; %lift to drag ratio for takeoff
V_f = V_TO; %final velocity for ground roll 
V_i = 0; %initial velocity for ground roll

%ground roll
K_t = (T/W) - mu;
e = 1.78*(1-(0.045*A^0.68))-0.64; %oswald efficiency factor
cf = 1 - (2*e/pi*log(1+(pi*b/8/h)^2)); %correction factor
K = cf/(pi*A*e);
K_a = rho/(2*W/S)*(mu*C_L - C_D0 - K*C_L^2);
S_G = 1/(2*g*K_a)*log((K_t + (K_a*V_f^2))/(K_t + (K_a*V_i^2)));

S_R = 3*V_TO;

%transition and climb distance
T = 11900; %thrust at takeoff
R = V_TR^2/(0.2*g);
gamma = asin(T/W - 1/(LD));
h_TR = R*(1-cos(gamma));
if (h_TR > h_o)
    S_TR = sqrt(R^2-(R-h_o)^2);
    S_C = 0;
else
    S_TR = R*sin(gamma);
    S_C = (h_o - h_TR)/tan(gamma);
end

%total distance
S_T = S_G + S_R + S_TR + S_C;
