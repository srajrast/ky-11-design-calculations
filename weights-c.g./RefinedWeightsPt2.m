clc; clear;

F_w = 1.25; %fuselage width at horizontal tail intersection
B_h = 15; %horizontal tail span
N_z = 9*1.5; %ultimate load factor = limit load factor * 1.5
W_dg = 22737; %flight design gross weight (50-60% of internal fuel)
S_ht = 54.33; %horizontal tail area

K_rht = 1; %1.047 for rolling horizontal tail
H_t = 1.94/2; %horizontal tail height above fuselage
H_v = 6.5; %vertical tail height above fuselage
S_vt = 22.75; %vertical tail area
M = 0.8; %Mach number (design max)
L_t = 25; %tail length (wing quarter-MAC to tail quarter-MAC)
S_r = 11.388; %rudder area
A_vt = 0.270; %aspect ratio for vertical tail
lambda = 0.5; %taper ratio
Lambda_vt = 0; %wing sweep at 25% MAC

K_dwf = 1; %1 for non delta wing
L = 51.52; %fuselage length
W = 4.64; %total fuselage structural width
D = 3.77; %fuselage structural depth

K_cb = 1; %2.25 for cross beam gear otherwise 1
K_tpg = 1; %0.826 for tripod gear otherwise 1
W_l = 20224; %landing design gross weight
N_l = 4.5; %ultimate landing load factor
L_m = 43.8+18; %extended length of main landing gear

L_n = 65.43; %extended length of nose landing gear
N_nw = 1; %number of nose wheels

N_en = 2; %number of engines
T = 6280*2; %total engine thrust, lb

S_fw = 21.2; %firewall surface area
W_en = 1050; %engine weight of each

K_vg = 1; %1.62 for variable geometry, 1 otherwise
L_d = 30/12; %duct length
K_d = 2.6; %duct constant, fig. 15.3
L_s = 0; %single duct length, fig. 15.3
D_e = 37.8/12; %engine diameter

L_tp = 2; %length of tailpipe
L_sh = 102.1/12; %length of engine cooling shroud


%horizontal tail weight
W_ht = 3.316*((1 + F_w/B_h)^-2.0)*((W_dg*N_z/1000)^0.26)*(S_ht^0.806);
W_ht = W_ht*0.83;

%vertical tail weight
W_vt = 0.452*K_rht*((1 + H_t/H_v)^0.5)*((W_dg*N_z)^0.488)*(S_vt^0.718)*(M^0.341)*(L_t^-1)*((1+ S_r/S_vt)^0.348)*(A_vt^0.223)*((1+lambda)^0.25)*(cos(Lambda_vt)^-0.323);
W_vt = W_vt*0.83;

%fuselage weight
W_f = 0.499*K_dwf*W_dg^0.35*N_z^0.25*L^0.5*D^0.849*W^0.685;
W_f = W_f*0.95;

%main landing gear weight
W_mlg = K_cb*K_tpg*(W_l*N_l)^0.25*L_m^0.973;

%nose landing gear weight
W_nlg = (W_l*N_l)^0.29*L_n^0.5*N_nw^0.525;

%engine mounts
W_em = 0.013*(N_en^0.795)*(T^0.579)*N_z;

%firewall weight
W_fw = 1.13*S_fw;

%engine section weight
W_es = 0.01*W_en^0.717*N_en*N_z;

%air induction system weight
W_ais = 13.29*K_vg*L_d^0.643*K_d^0.182*N_en^1.498*1*D_e;

%tailpipe weight
W_tp = 3.5*D_e*L_tp*N_en;

%engine cooling weight
W_ec = 4.55*D_e*L_sh*N_en;

%oil cooling weight
W_oc = 37.82*N_en^1.023;