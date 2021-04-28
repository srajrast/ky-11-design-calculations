clc;clear;
i = 3; % 1 for takeoff, 2 for cruise, 3 for landing
M = [0.2 0.74 0.18]; %mach number for each condition
V = [220 792 200]; %velocity for each condition (ft/s)
W = [25333 24137 19435]; %weight of aircraft for each condition (lb)
alpha = [15 0 8]; %angle of attack for each condition (deg)
C_L = [2.04 0.159 1.794]; %coefficient of lift for the wing, includes flap effects
df = [20*pi/180 0*pi/180 30*pi/180]; %wing flap deflection (rad)
rho = [0.00199 0.001756 0.00199]; %density for each condition (slug/ft^3)
dE = 10.2*pi/180; %elevator deflection (VALUE TO CHANGE) (18.4 deg for takeoff, 2.8 deg for cruise, 10.2 deg for landing)

c = 2/3*9*((1+0.389+0.389^2)/(1+0.389)); %MAC (ft)
S_w = 312; %planform area of wing (ft^2)
S_h = 54.33; %projected area of horizontal tail (Ft^2)
Xbar_cg = 24.8/c; %distance of cg from nose
Xbar_cp = (22+(0.44*7))/c; %center of pressure for flaps on wing
Xbar_acw = 25/c; %aerodynamic center of wing
Xbar_ach = 50.4/c; %aerodynamic center of horizontal tail
if (M(i) > 0.4)
    Xbar_acw = (24 + (0.26*((M(i)-0.4)^2.5)*sqrt(S_w)))/c; %aerodynamic center of wing
    Xbar_ach = (50.4 + (0.26*((M(i)-0.4)^2.5)*sqrt(S_w)))/c; %aerodynamic center of horizontal tail
end
W_f = 4.25; %width of fuselage (ft)
L_f = 51.11; %length of fuselage (ft)
eta_h = 0.85; %ratio of dynamic pressures
T = 6280*2; %thrust of engines (lb)
q = 0.5*V(i)^2*rho(i); %dynamic pressure (lb/ft^2)
alpha_0Lh = ((1.576*0.3^3)-(3.458*0.3^2)+(2.882*0.3))*dE; %zero-lift angle of attack for horizontal tail (rad)
zbar_t = 0.85/c; %distance between the thrust vector and cg
K_fus = 0.029; %fuselage moment empirical factor

%coefficient of moment about wing determined from XFLR5
Cm_w = -0.068;

%coefficient of moment for wing flap
Cm_wf = -(1.3/(40*pi/180))*(Xbar_cp - Xbar_cg);

%coefficient of moment for fuselage
Cm_fus = K_fus*(W_f^2)*L_f/c/S_w*alpha(i);

%coefficient of lift for horizontal tail
C_Lh = 3.592*((alpha(i)*pi/180)-alpha_0Lh);

%coefficient of moment about C.G.
Cm_cg = C_L(i)*(Xbar_cg - Xbar_acw) + Cm_w + Cm_wf*df(i) + Cm_fus - (eta_h*(S_h/S_w)*C_Lh*(Xbar_ach - Xbar_cg)) + (T/(q*S_w)*zbar_t);

%total lift 
C_Ltotal = C_L(i)+(eta_h*(S_h/S_w)*C_Lh);

%lift criteria
C_Lcri = W(i)/q/S_w;

