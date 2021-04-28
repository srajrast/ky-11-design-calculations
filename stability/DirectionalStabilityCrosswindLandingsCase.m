clc; clear; 

 

%% Variables needed 

B = 11.5*pi/180; %sideslip angle in radians 

sweep = 15*pi/180; %sweep angle in radians 

Svs = 48.3; %area of the vertical tail extended to the fuselage centerline ft^2 

volume = 666.17; %volume of fuselage ft^3 

Sw = 312.5; %Area of wing ft^2 

Clda = 0.0052; %rolling moment coefficient from the aileron deflection 

Wf =  4.25; %width of fuselage ft 

Df = 5.6; %Depth of fuselage ft 

Cl = 0.159; %mean lift coefficient 

Da = 20*pi/180; %aileron deflection in radians 

b=50; %wingspan ft 

Xacw = 300/12; %distance from nose to ac of wing ft 

Xcg = 298/12; %distance from nose to cg ft 

Xacv = (28+Xcg); %distance from nose to ac of vertical stabilizer ft 

A = 8; %Aspect Ratio 

Zwf = 2.083; %height of wing above the fuselage centerline ft 

Sv = 45.5; %Vertical stabilizer area ft^2 

CFBV = 3.592; %lift slope of vertical tail 

 

%% Supporting Equations 

Cnda = -0.2*Cl*Clda; 

Cnbf = -1.3*(volume/(Sw*b))*(Df/Wf); 

DBVDBNV = 0.724+3.06*(Svs/Sw)/(1+cos(sweep))-0.4*Zwf/Df+0.009*A; 

Cnbw = (Cl^2)*(1/(4*pi*A)-tan(sweep)/(pi*A*(A+4*cos(sweep))))*(cos(sweep)-A/2-(A^2)/(8*cos(sweep))+(8*(Xacw/b-Xcg/b)*sin(sweep))/A); 

Cnbv = CFBV*DBVDBNV*Sv/Sw*(Xacv/b-Xcg/b); 

 

%% Main Equations that need to be close to zero for stability purposes 

Cn = Cnbw*B + Cnda*Da + Cnbf*B + Cnbv*B 
