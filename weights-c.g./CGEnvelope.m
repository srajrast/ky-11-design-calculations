clc; clear;

MTOW = 24266;
MTOWcg = 24.75;
plot(MTOWcg,MTOW,'x')
hold on

MTOWcgret = 24.71;
plot(MTOWcgret,MTOW,'s')
hold on

NoPayload = 21266;
NPcg       = 24.6;
plot(NPcg,NoPayload,'o')
hold on

NoPayNoFuel = 16103;
NPNFcg      = 24.02;
plot(NPNFcg,NoPayNoFuel,'d')

y = linspace(0,50000,100);
x1(1:100) = 24;
x2(1:100) = 24.8;
plot(x1,y)
hold on
plot(x2,y)
xlim([23.8,25])
ylim([0,25000])
xlabel('CG location along fuselage from nose (x-direction) [ft]')
ylabel('Weight [lbm]')
legend('MTOW gear down','MTOW gear retracted','Crew,FullFuel,NoPayload','Crew,NoPayload,NoFuel','Forward CG limit','Aft CG limit')
