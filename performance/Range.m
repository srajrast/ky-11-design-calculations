%% Range 

%The range, which is the maximum distance the aircraft can travel without
%landing, is calculated by multiplying the cruise velocity by the amount of
%time the aircraft is in the air. This time value is found by the mass of
%the fuel and the rate at which it is being burned. During cruise, fuel
%will be burned, lowering the net weght of the aircraft, and in turn
%lowering the thrust needed to stay in steady-level flight. Lower thurst,
%less fuel conseumption, larger range. Allow the weight to vary from the
%empty gross weight (withand without payload) to its take off weight (with
%and without payload) and use Brequet's equation.

Vc   = 680.6;            %ft/s %equivalent cruise velocity
Vc   = Vc*1.64579*10^-4; %nmi/s
ClCd = 32.3559;             %Cl/Cd
SFCc = .975;              %1/hr
SFCc = SFCc/3600;        %1/s
Wmax = 25333;            %lb %MTOW
Wfuel = 5162;
Wpayload=0;
Wemp = Wmax-Wfuel-Wpayload;            %lb %MTOW - fuel and payload
Wmax = Wmax-(.05)*Wmax;  %lb %10% safety factor
W    = linspace(Wemp,Wmax,1000);  %weights %lbs
R    = (Vc*(ClCd)/SFCc)*log(W/Wemp); %ranges %nmi
figure(1)
plot(R,W) %WvR
title('Range of Ky-11 at Cruise')
xlabel('Range [nmi]')
ylabel('Weight [lbs]')
ylim([0 25333])
fprintf('The max range at cruise conditions is %gnmi\n',R(1,1000))


%% Endurance 
E = (ClCd/SFCc)*log10(W/Wemp)/log10(exp(1)); %s %for cruise
E = E/3600; %hr
figure(2)
plot(E,W) %WvE
title('Endurance of Ky-11 at Cruise')
xlabel('Endurance [hr]')
ylabel('Weight [lbs]')
ylim([0 25333])
fprintf('The max endurance at cruise conditions is %ghr\n',E(1,1000))