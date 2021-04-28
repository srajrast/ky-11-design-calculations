clc;clear;
Wpayload = 3000;
Wcrew = (180+228)*2;
i = 2; %prop for 1; jet for 2;

%known fuel weight fractions
takeoff = 0.97;
climb = 0.985;
landing = 0.995;
descent = 0.990;

%velocity values
V = [470 800]; %[prop jet]

%turboprop calcs for SFC
C1 = 0.5*470/550/0.8;
C2 = 0.6*470/550/0.7;

%SFC values
Ccruise = [C1/3600 0.8/3600];
Cloiter = [C2/3600 0.7/3600];

%cruise weight fraction
R = 607612; %range in feet
LDcruise = [15 0.866*18]; %lift drag ratio for cruise
cruise = exp(-R*Ccruise(i)/LDcruise(i)/V(i));

%loiter weight fraction
E1 = 4*3600; E2 = 0.75*3600; %endurance
LDloiter = [.866*15 18]; %lift drag ratio for loiter
loiter1 = exp(-E1*Cloiter(i)/LDloiter(i));
loiter2 = exp(-E2*Cloiter(i)/LDloiter(i));

%end weight/beginning weight
frac = takeoff*climb*cruise*descent*loiter1*climb*cruise*landing*climb*loiter2;

%ferry mission reqs (uncomment below to get design TO weight for ferry mission)
% Wpayload = 3000*0.6;
% cruise = exp(-R*9*Ccruise(i)/LDcruise(i)/V(i));
% frac = takeoff*climb*cruise*landing*climb*loiter2;

%fuel weight fraction
fuelFrac = 1.06*(1-frac); % 6% allowance

%newton-raphson method
a = 1E2;
b = 7E4;
x0 = (a+b)/2;
x1 = 0;
x2 = 0;
eps = 1E-8;

%empty weight fraction constants for twin turboprop and jet trainer
A = [0.96 1.59];
c = [-0.05 -0.1];

func = @(x) (Wpayload + Wcrew)/(1-fuelFrac-(A(i)*x^c(i))) - x; %initial function
deriv = @(x) ((Wpayload + Wcrew)*-(1-fuelFrac-(A(i)*x^c(i)))^2*(-A(i)*c(i)*x^(c(i)-1))) - 1; %derivative

while (abs(x0-x2) > eps)
    x1 = x0 - (func(x0)/deriv(x0));
    fprintf('%f %f\n', x0, x1);
    
    x2 = x0;
    x0 = x1;
end



