%% test motor and solar panel characteristics
% test the equations and the parameters used to model solar panel and motor 
% 
% N.B. Before running this script it is necessary to run the main_SSV
% script in order to initialise the parameters

% generate U test
U = 0:0.1:20;

% plot solar panel characteristics
I = panel.Isc - panel.Is*(panel.e.^(U/(panel.m*((panel.k*panel.tempK)/panel.q)*panel.N))-1);
plot(U,I);
axis([0 20 0 2]);
hold on

% plot motor characteristics
for v=0:20
    U = (60/(motor.Kv*2*pi))*(v*car.gearRatio/(car.wheelOuterRadius)) + motor.R*I;
    plot(U, I);
    hold on
end