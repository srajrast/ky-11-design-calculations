%% Cost Analysis for the Ky-11 

  

%The cost analysis for the Ky-11 is divided into three categories: 

    %[1] Fixed Costs 

         %NRE 

         %RDTE 

         %Flyaway 

    %[2] Unit Cost 

    %[3] Annual O&M Costs 

         %Fuel 

         %Oil 

         %Maintenance 

         %Crew 

    %[4] O&M Cycle Costs 

         %Fuel 

         %Oil 

         %Maintenance 

  

%X = [NRE;RDTE;FA; UNIT; FUEL;OIL;MAIN;CREW; FUEL;OIL;MAIN]; 

          

%Standard Parameters of the Ky-11 

We   = 16711;    %[lb]  %empty weight 

Q    = 50;              %production quantity (per RFP) 

FTA  = 4;               %flight-test aircraft (2-6) 

Neng = 2*Q;             %number of engines  

Tmax = 2*6300;   %[lbf] %max thrust 

Mmax = .877;     %[M]   %max mach number (at dive) 

V    = Mmax*667; %[kn]  %max velocity (at dive) 

Tin  = 2911;     %[R]   %turbine inlet temp 

  

%Wrap Rates (hourly rate) 

Re    = 115;                 %[$/hr] %engineering 

Rt    = 118;                 %[$/hr] %tooling 

Rq    = 108;                 %[$/hr] %quality control 

Rm    = 98;                  %[$/hr] %manufacturing 

Rmain = mean([Re;Rt;Rq;Rm]); %[$/hr] %maintenance  

  

%Non-Reoccuring Expenses (NRE) 

He = 4.86*We^.777*V^.894*Q^.163;   %[hr] %engineering hours (NRE) 

Ht = 5.99*We^.777*V^.696*Q^.263;   %[hr] %tooling hours     (NRE) 

Ce=Re*He; 

Ct=Rt*Ht; 

Cd = 91.3*We^.63*V^1.3;            %[$]  %developement cost (NRE) 

Cf = 2498*We^.325*V^.822*FTA^1.21; %[$]  %flight test cost  (NRE) 

  

NRE = (Ce+Ct+Cd+Cf);               %[$]  %total NRE 

  

X(1,1) = NRE; 

  

%DAPCA IV Cost Model 

Hm    = 7.37*We^.82*V^.484*Q^.641;      %[hr] %manufacturing hours 

Hq    = .133*Hm;                           %[hr] %quality control hours 

FHYR  = 1200;                           %[hr] %flight hours/year (per RFP) 

BHYR  = FHYR/2;                         %[hr] %block hours/year 

Cm    = 22.1*We^.921*V^.621*Q^.799;     %[$]  %material cost 

Ceng  = 2.5*10^6;                       %[$]  %honeywell F124 cost 

Cav   = 6000*We; %[4000-8000]           %[$]  %avionics cost 

  

%Research, Developement, Testing, & Experimentation (RDTE) 

RDTE = He*Re+Ht*Rt+Hm*Rm+Hq*Rq+Cd+Cf; %[$ 2012] 

  

X(2,1) = RDTE; 

  

%Flyaway 

FA = Cm+Ceng*Neng+Cav; %[$ 2012] 

  

X(3,1) = FA; 

  

%Unit Price 

Cunit = (RDTE+FA)/Q; %[$ 2012] 

Cunit = Cunit*1.15;  %[$ 2012] %spares 

  

X(4,1) = Cunit; 

  

%Operations & Maintenance Cost  

  

%Maintenance 

MMHFH   = 8; %(6-10)                 %maintenance man hours/flight hour 

FHCY    =1;                         %[hr]     hours/cycle 

MMHCY   = MMHFH;                  %[hr]     maintenance man hours/cycle 

MMHYR   = MMHFH*FHYR;                %[hr/yr]  maintenance man hours/year 

CmainYR = MMHYR*mean([Re;Rt;Rq;Rm])+(He*Re+Ht*Rt+Hm*Rm+Hq*Rq)/Q; %[$ 2012] maintenance cost/year 

Cmain   = MMHCY*mean([Re;Rt;Rq;Rm]); %[$ 2012] maintenance cost/cycle 

  

X(5,1)  = CmainYR; 

X(8,1) = Cmain; 

  

%Crew Salary  

%Ccrew = 2*(70.4*(V*(25333)/10^5)^(.3)+168.8)*BHYR; %($)  

  

%X(6,1) = Ccrew; 

  

%Fuel 

f_m  = 25333-20171; %[lb]     %mass of fuel used for one cycle 

f_d  = 7;           %[lb/gal] %density of fuel used 

f_v  = f_m/f_d;     %[gal]    %volume of fuel used 

Cf   = 1.58*f_v;      %[$ 2021] %cost of fuel used for one cycle 

CfYR = Cf*(FHYR/FHCY); 

  

X(6,1)  = CfYR; 

X(9,1) = Cf; 

  

%Oil 

Coil   = Cf*.005;     %[$ 2021] %cost of oil used in one cycle 

CoilYR = Coil*(FHYR/FHCY); 

  

X(7,1)  = CoilYR; 

X(10,1) = Coil; 

  

X(1:5,1) = X(1:5,1)*1.1345; 

X(8,1)   = X(8,1)*1.1345; 

X(1:7,1) = X(1:7,1)/10^6; 

  

fprintf('Fixed Costs\n') 

fprintf('NRE [$mi] = %g\n',X(1)) 

fprintf('RDTE [$mi] = %g\n',X(2)) 

fprintf('Flyaway [$mi] = %g\n',X(3)) 

fprintf('\n') 

fprintf('Unit Cost [$mi] = %g\n', X(4)) 

fprintf('\n') 

%fprintf('O&M per Year\n') 

%fprintf('Maintenance [$mi] = %g\n', X(5)) 

%fprintf('Crew Salary [$mi] = %g\n', X(6)) 

%fprintf('Fuel [$mi] = %g\n', X(6)) 

%fprintf('Oil [$mi] = %g\n', X(7)) 

%fprintf('\n') 

fprintf('O&M per Cycle\n') 

fprintf('Maintenance [$] = %g\n',X(8)) 

fprintf('Fuel [$] = %g\n', X(9)) 

fprintf('Oil [$] = %g\n', X(10)) 

  

figure(1) 

pie(X(1:3)) 

title('Fixed Costs') 

legend('NRE','RDTE','Flyaway') 

  

figure(2) 

pie(X(5:7)) 

title('O&M Costs per Year') 

legend('Maintenance','Fuel','Oil') 

  

figure(2) 

pie(X(8:10)) 

title('O&M Costs per Cycle') 

legend('Maintenance','Fuel','Oil') 
