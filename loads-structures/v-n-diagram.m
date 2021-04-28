%% V-n Diagram at 10,000ft 

%Known Quantities 
    %air densities 
    rho       = 0.001756; %slug/ft^3 %at 10,000ft 
    rho_sl    = 0.002378; %slug/ft^3 %at sea-level 
      
    %velocities (ft/s) 
    V_cruise  = 792;                       %ft/s %cruise speed 
    Ve_cruise = sqrt(rho/rho_sl)*V_cruise; %ft/s %equivalent cruise speed 
    Ve_dive   = 1.45*Ve_cruise;            %ft/s %equivalent dive speed 

    %correction factor for subsonic 
    M_cruise  = 0.70;                 %Mach at cruise 
    k         = 1.625-0.625*M_cruise; %correction factor 

    %lift coefficients 
    Cl_max    = 2.0;   %design max (occurs at takeoff) 
    Cl_min    = -1.63; %design min (occurs at dive) 

    %physical properties 
    S         = 300;   %ft^2 %planform area 
    W         = 25500; %lbs %max weight of Ky-11 

     

%Limit Load Factors 
    n_pos  = 9;  %max load factor 
    n_neg  = -3; %min load factor 

  

%Corner Speeds 
    Ve_pos = sqrt((n_pos*2*W)/(rho*Cl_max*S*k)); %fps %maneuver speed 
    Ve_neg = sqrt((n_neg*2*W)/(rho*Cl_min*S)); %fps %negative corner speed 

  

%Ve Domain for Curves 
    Ve_max = linspace(0,Ve_pos,1000); %Ve domain for n_max 
    Ve_min = linspace(0,Ve_neg,1000); %Ve domain for n_min 

  

%Curves 
    n_max = k*(rho*Cl_max*S/(2*W))*Ve_max.^2; %n_max curve 
    n_min = (rho*Cl_min*S/(2*W))*Ve_min.^2;   %n_min curve 

  
%Line Segments 
    V_neg_flat = [Ve_neg;Ve_cruise]; 
    n_neg_flat = [n_neg;n_neg]; 

    V_dive = [Ve_cruise;Ve_dive]; 
    n_dive = [n_neg;0]; 

    V_pos_flat = [Ve_pos,Ve_dive]; 
    n_pos_flat = [n_pos;n_pos]; 

    V_vert = [Ve_dive;Ve_dive]; 
    n_vert = [n_pos;0]; 

  

%Plotting 
    %values for legend 
    plot(291.05228,2.078,'o r')               %min speed for gust 
    hold on 
    plot(Ve_max(1,1000),n_max(1,1000),'d r')  %maneuver speed 
    plot(Ve_cruise,n_neg,'> r')               %cruise speed 
    plot(V_vert,n_vert,'r')                   %dive speed 
    plot([201.9069302,201.9069302],[0,1],'m') %stall at n=1 
    plot([0,810],[1,4],'-- b')                %top gust 

    %stall 
    plot([243.707224,243.707224],[0,-1],'m')  %stall at n=-1 
    plot([0,243.707224],[0,0],'-- m')         %horizontal stall line 
  
    %gust envelope 
    plot([0,810],[1,-2],'-- b')              %bottom gust 
    plot([810,Ve_dive],[-2,-.5],'-- b')      %linear decrease bottom gust 
    plot([810,Ve_dive],[4,2.5],'-- b')       %linear decrease top gust 
    plot([Ve_dive,Ve_dive],[2.5,-.5],'-- b') %vertical gust 

    %V-n envelope 
    plot(Ve_max,n_max,'k')          %top curve 
    plot(Ve_min,n_min,'k')          %bottom curve 
    plot(V_neg_flat,n_neg_flat,'k') %bottom flat 
    plot(V_dive,n_dive,'k')         %cruise to dive approx. 
    plot(V_pos_flat,n_pos_flat,'k') %top flat 

    %formatting 
    xlim([0,1200]); 
    ylim([n_neg-4,n_pos+4]); 
    xlabel('Equivalent Speed (Ve) [ft/s]'); 
    ylabel('Load Factor (n)'); 
    title('V-n Diagram of the Ky-11 at 10,000ft'); 
    legend('Min Speed for Turbulence','Maneuver Speed','Cruise Speed','Dive Speed','Stall Speed','Gust Envelope') 
    hold off 
