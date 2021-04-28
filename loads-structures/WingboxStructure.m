clc;clear; 

rho_mat=0.056;  %density of material 
yield=180000;    %yield strenth of material 

w_root=42;  %inches 
h_root=8;   %inches 
h_tip=3;    %inches 
t=0.82;        %inches 
b=600;      %inches 
Wg=25500;   %pounds 
n=9;        %max load factor 
delta=15*pi/180;    %radians 
alpha=10.27*pi/180; 
D0=14;     %inches (negative was taken into account deriving the expression for D(x) and Mx) 

  
A_bar=w_root*h_root;                  %area enclosed by wing box cross section 
Iyy=(w_root*h_root^3 - ((w_root-t)*(h_root-t)^3))/12; %moment of inertia about the y-axis of the wing box 

y0=4*n*Wg/(pi*b); 

%Shear force, bending moment, and twisting moment at the root, respectively 
Vz=pi*b*y0/8; 
My=(-y0*b^2)/12; 
Mx=y0*(b^2)*tan(delta)/12 - pi*y0*D0*b/8; 

%-----shear stress------------------ 
%torsion 
tau_t=Mx/(2*A_bar*t); %constant throughout cross section   

%flexural 
z_s=[-h_root/2 ; -h_root/4 ; h_root/4 ; h_root/2 ; h_root/2 ; h_root/4 ; -h_root/4 ; -h_root/2];    %position of the centroid for each area 
As=[w_root/2 ; h_root/2 ; h_root/2; w_root/2 ; w_root/2 ; h_root/2 ; h_root/2 ; w_root/2]*t;                    %area of each section leading up the the point 
q=zeros(8,1); 

  

%the for loop calculates the shear flow at each point using points 4 and 8 
%as basis. Because points 4 and 8 lie on the line of action of the shear 
%force, the shear flow at these points is 0. 
for index=1:length(q) 
    if index~=4 && index~=8 
        if index==1 || index==5 
            q(index)=-Vz*As(index)*z_s(index)/Iyy; 
        else 
            q(index)=q(index-1)-Vz*As(index)*z_s(index)/Iyy; 
        end 
    end 
end 
  
tau_f=q/t;          %the shear stress at each point 
Tau=tau_f+tau_t;    %superposition   

%------bending stress----------------------------------------------- 
z=[-h_root/2 ; 0 ; h_root/2 ; h_root/2 ; h_root/2 ; 0 ; -h_root/2 ; -h_root/2];   %distance from y axis of each point 
sigma=My*z/Iyy;                                     %bending stress at each point

%------stresses------------------------------------------------------ 
stress=[sigma  Tau]; 

for in=1:length(stress) 
    [vector(:,:,in) principal(:,:,in)] = eig([stress(in,1) stress(in,2) ; stress(in,2) 0]); 
    sigma_vm(in)=sqrt((principal(1,1,in)^2)+(principal(2,2,in)^2)-principal(1,1,in)*principal(2,2,in)); 
    sigma_vm_check(in)=sqrt((stress(in,1)^2)+3*stress(in,2)^2); 
end 

N_vm=yield./sigma_vm; 

%weight 
h_root_i=h_root-t; 
w_root_i=w_root-t; 
h_tip_i=(h_root_i/h_root)*h_tip; 

%outer 
V_o=h_root*w_root*b/2 + (b^2)*h_root*(tan(alpha)-tan(delta))/8 + b*w_root*(h_tip-h_root)/4 + (b^2)*(h_tip-h_root)*(tan(alpha)-tan(delta))/12; 

%inner 
V_i=h_root_i*w_root_i*b/2 + (b^2)*h_root_i*(tan(alpha)-tan(delta))/8 + b*w_root_i*(h_tip_i-h_root_i)/4 + (b^2)*(h_tip_i-h_root_i)*(tan(alpha)-tan(delta))/12; 

%total 
box_weight=2*(V_o-V_i)*rho_mat; 
