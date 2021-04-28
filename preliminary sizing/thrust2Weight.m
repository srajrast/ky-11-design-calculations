clc; clear;

% Design Mission
% T/W0 takeoff (jet trainer)
maxM = 0.8584; % maximum speed [Mach]
a = 0.488; 
C = 0.728;
% a and C are graph parameters obtained from historical data.
TW1 = a*(maxM)^C % Takeoff T/W0

% T/W climb not ratio'd
LDclimb = 0.75*18; % Lift to drag ratio for climb segment.
clgrad = 0.04937; % climb gradient [ft/ft]
TW2 = 1/(LDclimb) + clgrad % Non-ratioed T/W during climb.

% T/W cruise not ratioed
LDcruise = 0.866*18; % Lift to drag ratio for cruise segment.
TW3 = 1/(LDcruise) % Non-ratioed T/W during cruise

% Ratio T/W to takeoff conditions

% T/W climb to takeoff
TWclimb2take = TW2*(0.985*0.97)*(1/0.7)

% T/W cruise to takeoff
TWcruise2take = TW3*(0.985*0.9892*0.97)*(1/0.55)


% Ferry Mission
% For the ferry mission, the T/W0 during takeoff is unchanged since the
% engine type and maximum speed are identical. The T/W ratio during climb
% relative to takeoff is also unchanged since the weight fractions are
% also unchanged. However, the T/W ratio during cruise relative to takeoff
% would change as the weight fractions differ from the design mission.

TWcruise2takeferry = TW3*(0.985*0.9071*0.97)*(1/0.55)
