clc; clear; 

  

rhoSea = 0.002378; 

  

% Stall Limit Line 

MTOW   = 24266; % max takeoff weight [lbs] 

MTOWF  = MTOW*32.2; % max takeoff weight [lbf] 

Mach   = linspace(0,2.2,500); % Mach data points 

V      = 1125.33*Mach; % Stall velocity [ft/s] 

S      = 326.75; % Wing reference area [ft^2] 

CLmax  = 2;   % Max lift coefficient during takeoff 

rhoA   = 2*MTOWF./(V.^2*S.*CLmax).*(1/32.2); % Air density [slug/ft^3] 

  

T1A    = -70; % Temperature assumed to be constant [deg Fahrenheit] 

h1A    = (1.73 - log(rhoA.*(1718*(T1A+459.7))/473.1))/0.000048; % height [ft] 

  

  

figure(1) 

% plot(V1A,h1A,'k') 

plot(Mach,h1A,'k') 

hold on 

ylim([0,50000]) 

xlim([0,1.2]) 

  

% Ps = 0 curve (jet aircraft) 

g=9.81; 

Weight=MTOW*0.453592*g; % Weight at takeoff [N]       

Thrust0 = 52934; % Thrust at sea level [N] 

T0=288.;         % Reference temperature            

R=287.;          % air gas constant 

Sm=29.03;        % Wing reference area [m^2] 

rho0=1.225;      % Density at sea level [kg/m^3] 

L=0.0065;        % Constant in temperature calculation 

P0=101300.;      % Pressure at sea level [Pa] 

gamma=1.4;       % Specific heat ratio 

lvl=[0 0];       % To draw contour graph for only one level 

Clmax=2;       % Clmax at takeoff 

N = 500;         % Number of data points 

  

%Altitude and Velocity range 

h=linspace(0.1,55000,N); % Altitude range [ft] 

Vac=linspace(0.1,300,N);   % Velocity range [m/s] 

  

for aa=1:N, 

 alt=h(aa)*0.3048; 

 temp=T0-alt*L; 

 press=P0*(temp/T0)^(g/L/R); 

 rho=press/(R*temp); 

 a=sqrt(gamma*R*temp); 

    for bb=1:N, 

  Vel=Vac(bb); 

  Thrust=Thrust0*(rho/rho0); 

  Cl=Weight/(0.5*rho*Vel*Vel*Sm); 

  M=Vel/a; 

  if (M<0.99), 

% compressibility correction 

   beta=sqrt(1.-M*M); 

   Cd=(0.02+0.0425*Cl*Cl)/beta; 

   D=Cd*(0.5*rho*Vel*Vel*Sm); 

% Specific Excess Power 

   Ps(aa,bb)=Vel/Weight*(Thrust-D); 

  else 

% program is not set to handle supersonic drag. 

   Ps(aa,bb)=NaN; 

  end; 

end; 

end 

  

% Contour Specific Excess Power and Specific Energy 

Vac      = Vac*0.002915; % Convert velocity to Mach 

[c1,h1]=contour(Vac,h,Ps,lvl,'b'); 

clabel(c1,h1); 

title('Operating Envelope'); 

xlabel('True Airspeed (Mach)'); 

ylabel('Altitude (ft)'); 

hold on 

  

% Max q limit line 

maxEAS = 986.8; % Max equivalent airspeed from V-n diagram [ft/s] 

rhoC   = (maxEAS./V).^2*rhoSea; 

TC     = -70; % Temperature assumed to be constant [deg Fahrenheit] 

hC     = (1.73 - log(rhoC.*(1718*(TC+459.7))/473.1))/0.000048; % height [ft] 

  

plot(Mach,hC,'g') 

hold on 

ylim([0,50000]) 

xlim([0,1.2]) 

  

  

% Service Ceiling 

MaxThrust = 11900; 

TW        = MaxThrust/MTOWF; 

WS        = MTOWF/S; 

CD0     = 0.006;   % Zero-lift drag coefficient 

n       = 1;       % Load factor 

AR      = 8;       % Wing aspect ratio 

sweepLE = deg2rad(15); % wing leading edge sweep angle 

Os      = 4.61*(1-(0.045*(AR)^0.68))*(cos(sweepLE))^0.15 - 3.1;  

% Oswald efficiency factor 

K       = 1/(pi*AR*Os); % Drag due to lift factor 

Vcruise = 792; % Cruise velocity [ft/s] 

  

qSC    = 6198; % Found using desmos by overlaying graphs. 

rhoD   = 2*min(qSC)/Vcruise^2*(1/32.2); 

TD     = -70; % Temperature assumed to be constant [deg Fahrenheit] 

hD     = (1.73 - log(rhoD.*(1718*(TD+459.7))/473.1))/0.000048; % height [ft] 

plothD = zeros(500); 

plothD(:) = hD; 

plot(Mach,plothD,'r') 

ylim([0,50000]) 

xlim([0,1.2]) 

legend('Stall Limit','Ps = 0','Max q limit','Service Ceiling') 
