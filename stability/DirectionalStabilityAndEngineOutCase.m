clc;clear; 

  

%variables 

vol_fus=666.17;     %volume of the fuselage (ft^3) 

D_fus=5.6;          %depth of the fuselage (ft) 

W_fus=4.25;         %width of the fuselage (ft) 

Sw=312.5;           %planform area of wing (ft^2) 

b=50;               %wingspan (ft) 

C_L=0.159;          %coefficient of lift 

AR=8;               %wing aspect ratio 

LAMDA=15*pi/180;    %wing sweep (leading edge) 

x_cg=298/12;        %distance from nose to cg (ft) 

x_acw=300/12;       %distance from nose to ac of wing (ft) 

x_acv=28+x_cg;      %distance from nose to ac of tail (ft) 

S_vsprime=48.3;     %"area of the vertical tail extended to the fuselage centerline" (fT) 

zwf=2.083;          %height of wing above fuselage centerline (ft) 

Sv=45.5;            %planform area of vertical tail (ft^2) 

C_f_b_v=3.592;      %lift derivative of vertical tail 

  

  

%yaw moment derivative (steady trim) 

C_n_b_fus=-1.3*vol_fus*D_fus/(Sw*b*W_fus); 

C_n_b_w=(C_L^2)*( 1/(4*pi*AR) - tan(LAMDA)/(pi*AR*(AR+4*cos(LAMDA))) *( cos(LAMDA) - AR/2 - (AR^2)/(8*cos(LAMDA)) + 6*(x_acw/b - x_cg/b)*sin(LAMDA)/AR )); 

dBeta=0.724 + (3.06*(S_vsprime/Sw))/(1+cos(LAMDA)) - 0.4*zwf/D_fus + 0.009*AR; 

C_n_b_v=C_f_b_v*dBeta*Sv*(x_acv/b - x_cg/b)/Sw; 

  

C_n_b=C_n_b_w + C_n_b_fus + C_n_b_v 

  

  

%engine out yaw moment 

C_d_eng=1.28;               %coefficient of drag for a flat plate 

T=6280;                     %thrust of remaining engine(lbs) 

Y_bar_p=0.0563;             %engine location normalized by wing span 

da=20*pi/180;               %aileron deflection (radians) 

v_to=220;                   %takeoff speed (ft/s) 

rho_cruise=0.0017;          %air density at cruise (30,000 ft) (slug/ft^3) 

q=rho_cruise*(v_to^2)/2;    %dynamic pressure under takeoff condition 

C_l_d_a=0.0052;             %ailron lateral derivative 

  

C_Y_v_0=1.26;               %sideforce coefficient for vertical tail with 20 deg rudder deflection 

C_n_v_0=C_Y_v_0*(x_acv/b - x_cg/b); 

  

C_n_d_a=-0/2*C_L*C_l_d_a;   %aileron directional derivative 

C_n=C_n_d_a*da + C_n_v_0 - T*Y_bar_p/(q*Sw) - C_d_eng*Y_bar_p
