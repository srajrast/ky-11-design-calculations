function [C_Lcruise,C_Lto,C_L_land,Re_cruise,Re_to]=re_C_l_calculator(S,c,L,L_land) 

vcruise=792;       %ft/s 
vto=220; 
vland=200; 
% c=1;      %ft 
% S=5;     %ft^2 
% C_lcruise=.485; 
% C_lmax=.911; 
% C_d=.015; 
 

mu=3.8617*10^(-7);  %slug/(ft*s) 
rho_to=19.896*10^-4;    %takeoff air density (slug/ft^3) 
rho_cruise=17.56*10^-4; %cruise air density 
%nu_t=mu/rho_t;       %(ft^2)/s 

  
Re_cruise=rho_cruise*vcruise*c/mu; 
Re_to=rho_to*vto*c/mu; 
 
C_Lcruise=2*L/(rho_cruise*S*vcruise^2); 
C_Lto=2*L/(rho_to*S*vto^2); 
C_L_land=2*L_land/(rho_to*S*vland^2);
