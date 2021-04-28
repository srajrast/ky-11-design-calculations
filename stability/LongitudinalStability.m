%% Longitudinal Stability (Static Margin) 

  

%Static Margin (SM) - range of locations for the c.g. to exist to ensure  

%stable flight (typically SM = 5% of MAC for jet fighters) 

%Neutral Point (Xnp) - most aft c.g. location that ensures stable flight 

  

%The SM is a function of: 

    %pitch moment derivative of the aircraft (Cma) 

    %lift derivative of the aircraft (CLa) 

    %               OR 

    %center of gravity of the aircraft (normalized by MAC) (Xcg) 

    %neutral point (normalized by MAC) (Xnp) 

    %               i.e. 

    %      SM = -Cma/CLa = Xnp-Xcg 

  

%CLa is the sum of the contribution from the wing and the horizontal 

%stabilizer. These two lift derivatives are known from airfoil analysis  

%using XFLR5. 

  

%Xcg is known from previous estimations.  

  

%Cma and Xnp are unknowns. 

  

%First find Cma, then use this value to find Xnp and the SM. 

  

%Cma is a function of: 

     

    %lift derivative of wing 

    CLaw = 4.693; %1/rad %assume same for airfoil    

     

    %center of gravity of the aircraft (Xcg) 

    lambda = 0.389; %taper ratio 

    c_root = 108; %in %root chord         

    MAC    = (2/3)*c_root*(1+lambda+lambda^2)/(1+lambda); %in  

    Xcg    = 298/MAC; %aft nose 

     

    %aerodynamic center of the wing (normalized by MAC) 

    Xacw = 300/MAC; %aft nose 

     

    %pitch moment derivative of fuselage (Cmaf) 

    Kfus = .029; %from 16.14 %empirical pitch moment factor 

    Wf   = 51; %in %max width of fuselage 

    Lf   = 51.1*12; %in %length of fuselage 

    Sw   = 43200; %in^2 %planform area of wing 

    Cmaf = (Kfus*Wf^2*Lf)/(MAC*Sw); 

     

    %pressure ratio (tail/freestream) 

    nh = 0.85; %typically .90 [.85,.95] 

     

    %planform area of horizontal stabilizers 

    %Sh = 6494.4; %in^2 

    Sh = 7819.2; %in^2 %projected area 

    %lift derivative of horizontal stabilizers 

    CLah = 3.592; 

     

    %partial derivative constant 

    dah = 1-.85; %from fig 16.12 (A=8, m=.1, lambda=.389, r=.9) 

     

    %location of aerodynamic center of horizontal stabilizers 

    Xach = .98*Lf/MAC; %in (aft nose) 

     

Cma = CLaw*(Xcg-Xacw)+Cmaf-nh*(Sh/Sw)*CLah*dah*(Xach-Xcg); 

  

%CLa is defined as the sum of all contributions: 

CLa = CLaw + CLah; 

  

%SM is defined as: 

SM = -Cma/CLa; 

     

%Xnp is defined as:  

Xnp = SM+Xcg; %percent of MAC 

Xnp = Xnp*MAC; %in 

     

     

fprintf('Static margin = %g of M.A.C.\n',SM*100) 

fprintf('Neutral point = %gin aft nose\n',Xnp) 
